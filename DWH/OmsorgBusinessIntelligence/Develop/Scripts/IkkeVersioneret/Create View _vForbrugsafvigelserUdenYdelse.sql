USE [AvaleoAnalytics_Staging_Clean]
GO

/****** Object:  View [dbo].[_vForbrugsafvigelserUdenYdelse]    Script Date: 11/19/2010 08:19:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[_vForbrugsafvigelserUdenYdelse]
AS
SELECT     dbo.SAGSPLANRET.ID, dbo.SAGSPLANRET.SERIEID, dbo.SAGSPLANRET.SAGSID, dbo.SAGSPLANRET.MEDID, dbo.SAGSPLANRET.RETDATO, dbo.SAGSPLANRET.TID, 
                      dbo.SAGSPLANRET.VEJTID, dbo.SAGSPLANRET.YDELSESTID, dbo.SAGSPLANRET.STATUSID, dbo.SAGSPLANRET.RSTART, dbo.SAGSPLANRET.RTID, 
                      dbo.SAGSPLANRET.RVEJTID, dbo.SAGSPLANRET.REGBES, dbo.SAGSPLANRET.SERIEDATO, dbo.SAGSPLANRET.STARTMINEFTERMIDNAT, 
                      dbo.SAGSPLANRET.VISISTART, dbo.SAGSPLANRET.VISISLUT, CASE WHEN regbes = 1 THEN 'Registreret' ELSE 'Ej registreret' END AS Målt, 
                      'Neutral' AS Forbrugsstatus, CASE WHEN sagsplanret.regbes = 1 THEN sagsplanret.RTID - RVejtid - sagsplanret.YDELSESTID ELSE NULL 
                      END AS Samlet_Forbrugsafvigelse, dbo.BESOGSTATUS.BESOGID * 10000 AS jobid, 0 AS Normtid_ydelse, dbo.SAGSPLANRET.RTID AS fordelt_forbrug, 
                      CASE WHEN sagsplanret.regbes = 1 THEN sagsplanret.RTID - RVejtid - sagsplanret.YDELSESTID ELSE NULL END AS Fordelt_forbrugsafvigelse, 
                      dbo.SAGSPLANRET.RVEJTID AS fordelt_vejtid, 0 AS visitype, dbo.BESOGSTATUS.BESOGID * 10000 AS Expr1, dbo.BESOGSTATUS.STAT_TYPE
FROM         dbo.SAGSPLANRET INNER JOIN
                      dbo.BESOGSTATUS ON dbo.SAGSPLANRET.STATUSID = dbo.BESOGSTATUS.BESOGID LEFT OUTER JOIN
                      dbo.SAGSPRETDET ON dbo.SAGSPLANRET.ID = dbo.SAGSPRETDET.SAGSPRETID
WHERE     (dbo.SAGSPRETDET.ID IS NULL)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SAGSPLANRET"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BESOGSTATUS"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 193
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SAGSPRETDET"
            Begin Extent = 
               Top = 20
               Left = 471
               Bottom = 253
               Right = 622
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_vForbrugsafvigelserUdenYdelse'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_vForbrugsafvigelserUdenYdelse'
GO



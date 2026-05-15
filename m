Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99003F39E5;
	Fri, 15 May 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882654; cv=fail; b=KTTaVUYtso0v8FA3QZklqmJ12Sis48A7e/uHd6bjd4tJdHXXRzj/SFWVWHYUu/1UM0/nvQ7vK4I2WyXFw3lIPPQDlL0aHgfvT3oKFwaqrvQIrWnmW96AVQr5S7Pkjr0+Cg1ZP2W0nWqkicp6KUw6zUprKZXMn48aRW/hTe8NPDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882654; c=relaxed/simple;
	bh=TTeUfBsHKghQecswPZj66KjdpRj+H5AcDNrppHNuGNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lroQ670E2TkVt916IKaoCiyYtPHLM2NQ5pKkRseycPLMVUqmsujCY1ptnNtiuExEYv3wnt57ZYKeWkJuJUNev3hvXgqpQ/LsWfHg9VhLTwD7ugSuk5iIO8pOzOBuVpJcJxtF7r3P8Q+0ByiohywMqrhPB5ACNLUPvCFoH+bahZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBMtCfFj; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBMtCfFj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkw3Om/VVwzBm6CXS2Bdlh0uonPRAdhSutnP6xG7yw+l0ORc8DFk3TVRv7Yv2ZVgM/7WujPkepr7jDXFkgiK6xXoUgdgFcbSl7TT9YoZvrq7xN7kEc1FPbwv0es/YYCNNmdMkOjtW74pVm/PWCx7PwtU3EsLwrvyPvVDxVrvomHD84OfSSqqDxVwL5qkELQHt6dU82OzUsYRoGOTRiyzJBGhs7JQ2G2qY4d+k4C/qgJsSU+LrmBIAGqC0EdZhXswz36HlXAnUVqxQP21Gui75EZuaoDBFcawcPvgUdrUjb7YbCf4+2HT7YL8yHJkPwu2Va0phUE+F+xx5V9xGyJXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U/2wwq5cRige4V/4jq8NgMKi8fthf+EvwHR3GcfmfE=;
 b=UPVAJV/3ap0NyOjW9gCVLYWjpBLoQPbBi9zeMff/zOTA0I5IgXVFkfGLHyqZlvK/rSuNeyHhhWa0cbfAIVlJa9zO9KM4RHh9dm1MAN4oBrnBBQDnJ3LFtiqvQ5MbQl1eTNTWKe7nQ6jB2CkBHOJT7DIaWOJbaur9bGwCUmdjBUYCDtqAWOxg3aVn288X6X3vZ0aVsQfLBc5ZCGafl9I4Vc7FEwYjKOW3KhW7hAzT0tvWOMnt6IfduAavVjzBkKoZnqwq+MRXvaJmBZVtNWd9Sye8gzL2tmG1A2JqI0soXy8NMvY4tdK7m+3URmUf6J5mHyE0yzQO6gVtaI1SmLJUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U/2wwq5cRige4V/4jq8NgMKi8fthf+EvwHR3GcfmfE=;
 b=pBMtCfFjgmaNOeVuL3tFWpA8n1kA2VVxC6V0RC7AZYkzg2c0EU8nyGH8wfCSh6j6iagDeNs7Y53UzCyfdgtHXzcckrmwKwe+vudlqyzsm6LOiP2J7dS5+pJsiKVW6LjJoenzBveHucZVLfgVXd7YtJ3WKY/TKJBtP3TKK/vjaQ+bd1dCE/aQDxlPmsuwxefJlO+YMz0hFaZsn+UFX9EPBC0m4P+b0rgFRPxaWgY3k9EoZC0NqEdgY+XXBrym5iKbSmW3+nh+n/wclLZi5dGAxyJbJCVIlyjFSa/NW7SQto1k6XusQBAoUicpsb0cNi9I/AWCPXzie7vD7bS4DLxEgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:05 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:05 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/8] selftests/vfio: igb: Use PHY internal loopback on 82576
Date: Fri, 15 May 2026 16:03:08 -0600
Message-ID: <20260515220330.565792-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260515220330.565792-1-alex.williamson@nvidia.com>
References: <20260515220330.565792-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:930:44::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 259f89c0-5eb2-4772-fa89-08deb2cde11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	wzFl3cpCylRJQgR29DyO0+5oQdLwhWTeepKzWIE0safvZzIP3RV3mfMasQY9781Ifwimy5poPXvcl5/8rn79Qwc7B8DVxs+rqB5JZPyjzorgjGuihfmWr42mpfH+yVL+mqu38SejiJdY/mVFzx/gjsv7IHTNtvUnKRAmCCnOK8hQlpdCNzUi0/vC0htURuzu2Xe1/7BoFGZZBSCi37mhlwMfID6rIzFZ51nYS22lomonb2ciAcKBNPaTAzzRw2G8ajhDrRDzHqiPYbKUc6rDBHztBNySXPzT+aPsw1wGzeitGG9TqmfHAypyBSOlBPvFPR53/7ORofz3iMLAF5SMl63+Hodtim0Z6yeZP75h8slH/h/VC14EpqgRnk+e8yEN5XdWEKUQ4BY/9GajV08ffR0pZLoJOvseC383aE4Y3T4N+0WPWI5/HTpwAwfyow35BOPWCoqhyJRfJFSAcVhNAiCbHLLzqb+5bKGpshka1zOswdK0Fk/9bMvZb65q1Dla7KfmnCGV40slGp1vauWhoQXDTnWLFYg8hLXt2/NdYTqKBMEn5+bhKasgW538Q04eUK/Uf6AmYPPvpmeu5JaHhhvSzxAfVL9JCIRLFfVtYWb39dzHLE8949h1esOzpZvbpyReStyDd2hIfTs9s/EszvORvUhE0yv6ersujwJlVdsL+dmQuegYYUkN1zmeD3n6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pa/wmA+XdB5Wmip+ve2PI9Hj1p+qtu3J596LzvSp7Rzf8jqk25PFkGjDsi+f?=
 =?us-ascii?Q?DEOUP9iYE28ht9yIDo47oXqIcRBsLH1UqquNdMczgApSTpRj8fds83Cy6Dqd?=
 =?us-ascii?Q?DzYr6Yo/uz2OefUq6TqyXHiltWvYflMrhRyWczns/L/wEZ9bKWPQoLbO1hef?=
 =?us-ascii?Q?S/dzY/igZSAeRsFkV2bgIkGVfuOl5LVMWimbGl+da5+TfUodvwMtZwYMQO4f?=
 =?us-ascii?Q?N/2gscSBoHbJdwScqPlCNxlgNG4xWc9gSWSgG0ccpYnRGT8GQmejSzK9h/Qh?=
 =?us-ascii?Q?Fkx/6WxpJTN45azrmSvHzycL2YVA6/cCnlMxQc2ob33l2q6Ke0cDKTnCUnKE?=
 =?us-ascii?Q?fABDIIiUXWFBLGa0jm5fy9uRBo+C1qfIIMmZ8ue2IxnaH9/IUHvGRl3N5Xzx?=
 =?us-ascii?Q?5nWf8AbNFrcjNqmQaF2/5uv6w/HnWTrwQ9wdsQkfTeUdpTecmsnYrHVJrGoq?=
 =?us-ascii?Q?ZGJ9UVT3V7aF9ofikddpGe7SA1cVPBxXc0PClb2IZmraAJ4cZ1O0m0iCEyfA?=
 =?us-ascii?Q?RSFLUdcTfWgjZ8TcPAN6jsi0Yf603jrE/GA0VFv0aOjAckdCjehkw/ySrIjR?=
 =?us-ascii?Q?eVMvBcftbe6PsWTR/esfEK5b+ltlm1pXEPD6ukatfw0yn8iYt6YKUWXwdh1Z?=
 =?us-ascii?Q?n+Pp+Ei92s3gaGRuG8eR/OKQUMPZqfFPZZ+nWKJ65Xxo1e09mY4i4vZ4mcNy?=
 =?us-ascii?Q?YNKnnOPDS7JYCWF99wY8vW84ZdvH/Nl7ySvRuYPogkM638gtzZmYQmnnUJ36?=
 =?us-ascii?Q?QQ/jIfqAXtXOpgg1g+BngYjCAOUq8IWuNry+uLNYMOtaHIuBqWH65Mex4tj8?=
 =?us-ascii?Q?qdGFeU87yfqYMGHT2fO22ehy1S43jS0VhZZQBLqxf2dhflJSn+qcLZddEnwb?=
 =?us-ascii?Q?m3xeNCG+4muKBB7aR9qSBRec1C+EyxMxPfWOJvH2W3c4A04xAn6XaGg5wmwx?=
 =?us-ascii?Q?8yyTJWAhqA6BQrr5dTpa/pZhz8Xas2LXEDJR32KVTA3wnqXvlIQGqPVzhn57?=
 =?us-ascii?Q?WOu/dUItwi/kPJ7ncw5Pn3lEsaD8PGYUAC5DU0nxF9ODclz8J+xAS69/ORw/?=
 =?us-ascii?Q?0z8gt598lhbLt04v/TDKq/CKG+P+qeW2MrZN0hIGbbLb8kOO3Qeaf5kb6tbD?=
 =?us-ascii?Q?QXKMI0aYzJRy2Tov0VrIy1K4MiKZd3aAj4VZhm3inE9P4JyhklYNzR2H45YR?=
 =?us-ascii?Q?p62wwkEc0UF03sl5QhH+gGiLp4NAz+5SdnGsVfV/dRo/ne7CdJQMMCGxAEEo?=
 =?us-ascii?Q?lgh2q2wqo2QReEmz8TrEgaRwB/I7O6w4axu4R75gxOlOp90H+h4X7TvkcI1x?=
 =?us-ascii?Q?FL2whE2amxA8HToOhhXyjoY1qJsS0fR5PHnwOm74ETVSMetYXzxxJ3rxIEaQ?=
 =?us-ascii?Q?VkA2VEruDgMAbEQwtH5K3uVLPYkP22R9WXHTZA3IkMPGooR9snF7HUjEw33x?=
 =?us-ascii?Q?WDyGU/yFO1H1N9a6twRHUHzOI4eRB+C1TslPLvNSpPZeOijsmli84WW8RPSf?=
 =?us-ascii?Q?Ya409AgLG6C0oGDEDwuRS08CluX5Ld7AZjaH6AWk7pbpMN8qC75XbXnE5xzz?=
 =?us-ascii?Q?Akz+J97xeqviiS/ETY8/c4wUPhYEpRy756nFxkYAThIiNR+BgCZ84W0lmO2K?=
 =?us-ascii?Q?KCxto/yRjqsv1Kb6uIhIAEpqcLtElp/sUUhFKKSqoIPkc507OwfnF92PllzH?=
 =?us-ascii?Q?kFa5eliQTwjgddamdx+GpXY65uuZpEHLqHK2GG/arH1CNRaWoL1x3T34VCAd?=
 =?us-ascii?Q?yXoQLWxmqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259f89c0-5eb2-4772-fa89-08deb2cde11a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:04.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4NkbD5GUi8TzYlpR9n3Iek6/Wd8/9c0e9FBs9vgBDOsjYjd+bcYTG6vxTvzIiOfkmWY4j9n6KzF4KDOeL+XmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The submitted driver waits for PHY autonegotiation and then enables MAC
loopback via RCTL.LBM_MAC.  QEMU's emulated igb tolerates this, but the
82576 datasheet rejects the MAC loopback path on real hardware:

  Section 3.5.6.1 (Loopback Support / General): "Use PHY Loopback
  instead of MAC Loopback on the 82576."

  Section 3.5.6.2 (MAC Loopback): "MAC Loopback is not used on this
  device."

  Section 3.5.6.3.1 (Setting the 82576 to PHY loopback Mode): set PHY
  control register bits 8 (duplex), 14 (loopback), clear bit 12
  (autoneg enable), set the speed via bits 6 and 13.  For 1Gb/s the
  register value is 0x4140.

  Section 8.10.1 (RCTL register): "When using the internal PHY, LBM
  should remain set to 00b and the PHY instead configured for
  loopback through the MDIO interface."

Replace igb_phy_setup_autoneg() with igb_setup_loopback() which:

  - writes PHY register 0 with LOOPBACK | SPEED_1000 | FULL_DUPLEX
  - forces the MAC into 1Gb/s full duplex via CTRL.FRCSPD, CTRL.FRCDPX,
    CTRL.SPD_1000, CTRL.FD, CTRL.SLU; without forcing the MAC link
    state, the descriptor engine does not run on real hardware

PHY internal loopback (section 3.5.6.3) wraps data at the end of the
PHY datapath before the MDI, so the physical link state and cable
speed are irrelevant.  This matches the kernel ethtool selftest path
in igb_integrated_phy_loopback()
(drivers/net/ethernet/intel/igb/igb_ethtool.c).

QEMU's igb emulation drives STATUS.LU exclusively from its autoneg-done
timer or a network-backend link-state change; the guest cannot set
STATUS.LU through CTRL.SLU.  Its receive path checks STATUS.LU
(e1000x_hw_rx_enabled in hw/net/e1000x_common.c) and drops every
loopback frame until LU is set.  Issue a one-shot autoneg-restart PHY
write at the top of igb_setup_loopback() to kick the timer; the
subsequent PHY write clears autoneg-enable, so on real hardware
autoneg never starts and the write is a no-op.

QEMU's igb also does not honor PHY register 0 bit 14 (PHY internal
loopback) and relies on RCTL.LBM_MAC to wrap TX descriptors back to
the RX queue.  Datasheet 8.10.1 advises that LBM remain 00b when
using the internal PHY, but empirically setting LBM_MAC has no
observable effect on real 82576 (MAC loopback is not implemented per
3.5.6.2), so set it alongside PHY loopback as the actual loopback
mechanism under QEMU.  With these two QEMU-only accommodations the
selftest works in both environments without environment-specific code
paths.

The submitted driver also wrote bit 14 (link disable) to PHY register
16 (port control).  Datasheet 3.5.6.3.1 describes this as required for
10/100Mb/s but explicitly "not a must for 1G", and the kernel ethtool
selftest omits it.  It is dropped here.  Flagging the removal in case a
future regression bisects to this commit.

Remove igb_read_phy() and the PHY status macros it served, which become
unused: IGB_PHY_STATUS_REG_OFFSET, IGB_PHY_STATUS_AN_COMP.  Keep
IGB_PHY_CTRL_AN_ENABLE and IGB_PHY_CTRL_AN_RESTART for the QEMU-only
autoneg kick; add the PHY ctrl loopback and CTRL force-link macros.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 126 ++++++++++--------
 .../vfio/lib/drivers/igb/registers.h          |  26 ++--
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 13c8429784ac..ce2e2c90315e 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -98,61 +98,71 @@ static int igb_write_phy(struct igb *igb, uint32_t offset, uint16_t data)
 	return 0;
 }
 
-static int igb_read_phy(struct igb *igb, uint32_t offset, uint16_t *data)
+/*
+ * Configure the device for PHY internal loopback per 82576 datasheet
+ * section 3.5.6.3.1.  Force the PHY to 1Gb/s full duplex with loopback
+ * enabled, then force the MAC link state to match.  Internal loopback
+ * wraps data at the end of the PHY datapath (section 3.5.6.3), so the
+ * physical link state is irrelevant.
+ *
+ * Section 3.5.6.1 directs to "Use PHY Loopback instead of MAC Loopback
+ * on the 82576", and section 3.5.6.2 states "MAC Loopback is not used
+ * on this device."  RCTL.LBM_MAC is still set elsewhere as a QEMU-only
+ * accommodation; see the RCTL programming in the caller for the
+ * rationale.
+ */
+static int igb_setup_loopback(struct igb *igb)
 {
-	uint32_t mdic;
-	int i;
-
-	mdic = ((offset << IGB_MDIC_REG_SHIFT) |
-		(1 << IGB_MDIC_PHY_SHIFT) |
-		IGB_MDIC_OP_READ);
-
-	igb_write32(igb, IGB_MDIC, mdic);
-
-	for (i = 0; i < 1000; i++) {
-		usleep(50);
-		mdic = igb_read32(igb, IGB_MDIC);
-		if (mdic & IGB_MDIC_READY)
-			break;
-	}
-
-	if (!(mdic & IGB_MDIC_READY))
-		return -1;
-
-	if (mdic & IGB_MDIC_ERROR)
-		return -1;
-
-	*data = (uint16_t)mdic;
-	return 0;
-}
-
-static int igb_phy_setup_autoneg(struct igb *igb)
-{
-	int timeout_ms = 1000;
-	bool success = false;
-	uint16_t phy_status;
+	uint32_t ctrl;
 	int ret;
-	int i;
 
-	/* Trigger auto-negotiation */
+	/*
+	 * Kick the autoneg machinery solely to bring STATUS.LU up under
+	 * QEMU's igb emulation: QEMU only updates STATUS.LU via its
+	 * autoneg-done timer, and without LU set its receive path
+	 * (e1000x_hw_rx_enabled) drops every loopback frame.  On real
+	 * hardware autoneg cannot complete before the next PHY write
+	 * below clears the autoneg-enable bit, so this is effectively a
+	 * no-op there.
+	 */
+	(void)igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
+			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_AN_RESTART);
+
+	/* PHY control: loopback + 1Gb/s full duplex, autoneg disabled. */
 	ret = igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
-			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTART_AN);
+			    IGB_PHY_CTRL_LOOPBACK |
+			    IGB_PHY_CTRL_SPEED_1000 |
+			    IGB_PHY_CTRL_FULL_DUPLEX);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < timeout_ms; i++) {
-		if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_status) == 0) {
-			success = !!(phy_status & IGB_PHY_STATUS_AN_COMP);
-			if (success)
-				break;
-		}
-		usleep(1000);
-	}
-
-	if (!success) {
-		printf("igb: Auto-negotiation did not complete in time\n");
-		return -ETIMEDOUT;
-	}
+	/*
+	 * Brief delay before forcing the MAC, mirroring the kernel ethtool
+	 * selftest in igb_integrated_phy_loopback().  Not specified by the
+	 * datasheet, but empirically required by the kernel driver.
+	 */
+	usleep(50000);
+
+	/*
+	 * Force the MAC to 1Gb/s full duplex with link up.  Without forcing
+	 * the link state the descriptor engine does not run, since the chip
+	 * normally waits for a real negotiated link.
+	 */
+	ctrl = igb_read32(igb, IGB_CTRL);
+	ctrl &= ~IGB_CTRL_SPD_SEL;
+	ctrl |= IGB_CTRL_FRCSPD |
+		IGB_CTRL_FRCDPX |
+		IGB_CTRL_SPD_1000 |
+		IGB_CTRL_FD |
+		IGB_CTRL_SLU;
+	igb_write32(igb, IGB_CTRL, ctrl);
+
+	/*
+	 * Settling delay matching the kernel ethtool selftest's msleep(500)
+	 * at the tail of igb_integrated_phy_loopback().  Not specified by
+	 * the datasheet; empirical, and inherited from the kernel driver.
+	 */
+	usleep(500000);
 
 	return 0;
 }
@@ -203,8 +213,8 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
-	/* Trigger autonegotiation. This enables IGB to transmit data. */
-	if (igb_phy_setup_autoneg(igb))
+	/* Configure PHY internal loopback for testing. */
+	if (igb_setup_loopback(igb))
 		return;
 
 	/* Configure TX and RX descriptor rings */
@@ -231,10 +241,22 @@ static void igb_init(struct vfio_pci_device *device)
 		usleep(10);
 	}
 
-	/* Enable Receiver and Transmitter */
+	/*
+	 * Enable Receiver and Transmitter.  RCTL.LBM_MAC is set in addition
+	 * to PHY loopback as a QEMU-only accommodation: QEMU's emulated igb
+	 * does not honor PHY register 0 bit 14 (PHY internal loopback) and
+	 * relies on RCTL.LBM_MAC to wrap TX descriptors back to the RX
+	 * queue.  Datasheet 8.10.1 (RCTL register) advises "When using the
+	 * internal PHY, LBM should remain set to 00b", so setting LBM_MAC
+	 * here deviates from datasheet guidance; empirically the bit has
+	 * no observable effect on real 82576 hardware because MAC loopback
+	 * is not implemented (datasheet 3.5.6.2).  Setting both lets the
+	 * selftest work on both real hardware and QEMU without conditional
+	 * code paths.
+	 */
 	rctl = IGB_RCTL_EN |       /* Receiver Enable */
 	       IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
-	       IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       IGB_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
 	       IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
 	igb_write32(igb, IGB_RCTL, rctl);
 	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index d2d402c9bd57..c00b5ae83ccb 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -36,7 +36,13 @@
 
 /* Control Bit Definitions */
 /* CTRL */
-#define IGB_CTRL_RST BIT(26) /* Device Reset */
+#define IGB_CTRL_FD		BIT(0)  /* Full Duplex */
+#define IGB_CTRL_SLU		BIT(6)  /* Set Link Up */
+#define IGB_CTRL_SPD_SEL	(3 << 8) /* Speed Select Mask */
+#define IGB_CTRL_SPD_1000	(2 << 8) /* Force 1000 Mb/s */
+#define IGB_CTRL_FRCSPD		BIT(11) /* Force Speed */
+#define IGB_CTRL_FRCDPX		BIT(12) /* Force Duplex */
+#define IGB_CTRL_RST		BIT(26) /* Device Reset */
 #define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
 
 /* CTRL_EXT */
@@ -46,7 +52,7 @@
 #define IGB_RCTL_EN BIT(1) /* Receiver Enable */
 #define IGB_RCTL_UPE BIT(3) /* Unicast Promiscuous Enabled */
 #define IGB_RCTL_LPE BIT(5) /* Long Packet Reception Enable */
-#define IGB_RCTL_LBM_MAC BIT(6) /* Loopback Mode - MAC */
+#define IGB_RCTL_LBM_MAC BIT(6) /* Loopback Mode - MAC (set as QEMU-only accommodation) */
 #define IGB_RCTL_SECRC BIT(26) /* Strip Ethernet CRC */
 
 /* TCTL */
@@ -83,15 +89,13 @@
 #define IGB_MDIC_READY BIT(28) /* MDI Data Ready */
 #define IGB_MDIC_ERROR BIT(29) /* MDI Error */
 
-#define IGB_PHY_CTRL_REG_OFFSET 0
-#define IGB_PHY_STATUS_REG_OFFSET 1
-#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete */
-#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
-#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation */
-
-#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Advertisement */
-#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
-#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex */
+/* PHY register 0 (Control), per 82576 datasheet section 3.5.6.3.1 */
+#define IGB_PHY_CTRL_REG_OFFSET		0
+#define IGB_PHY_CTRL_AN_RESTART		0x0200 /* bit 9 */
+#define IGB_PHY_CTRL_AN_ENABLE		0x1000 /* bit 12 */
+#define IGB_PHY_CTRL_SPEED_1000		0x0040 /* bit 6 set, bit 13 clear */
+#define IGB_PHY_CTRL_FULL_DUPLEX	0x0100 /* bit 8 */
+#define IGB_PHY_CTRL_LOOPBACK		0x4000 /* bit 14 */
 
 #define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
-- 
2.51.0


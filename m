Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4674A8402;
	Fri, 11 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146296; cv=fail; b=GzViFeT6a69XVKhvaYW1SZv7NpmpzLG6i06OR0auh22N7kwJKdgw5ZPWXJzlzLDgMjs16cIl8hYKY+AdZ3ueum0GC5D3wh46rZfWT9jXx+Ng3GtJj/nxr+coanpkJYoqO7qkdlyD7mcdRnvNAoU9c7i3Q0m5cLxoHJxZVRUoJfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146296; c=relaxed/simple;
	bh=9MEMVtsMkuuyFza5mIvgIUrMdEJva6ea889Citf8cq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/OebJ7qP6hQSJi2MAdNXnexKGcT+x/UxmCT71UF96PiD0LPD97zJN6iULKIh3zrmy0fL0gLjl6I+yUHcRw8MRxAgbxMhw4YmGck7ZCF7f8GrQ5h3ofYcs4UxjOZO17qEJT5FzUEDJQn3y9MX2rX4AhF1c+Jf2V/HJAnsJcTiqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a87lt8A+; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a87lt8A+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucte8PeawXo52u0ZuuDOMLND7dwMralPIfNPUGU6kpFR/0rTh+312LdNnEWMrMUUssqRBXoQMWNEECELReLqUARHM+kdG0c/bl/how7FxHvum3I9tUnDfd+O+hXqZw7yVRyebBqlo6usCDiPclHK65wxIGB1UzoIdd5yY32sgsx5lAHaWPK4bCVyzqLpajGE6yxiX97wWOm+jEIlmByosGnW/eIHZzVVXfLT16yYtoFcELaUEdrUDs0st5WD+gm+lAjSomBR0+fHC/4T9MlBFNtOVquITJMkr2yGzKo1vkf5S3GAtSBnagZaAtE+Kiqtxe+FV0IB+4dlCoNo2HfwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9LTqCXbqoLxybTIqHfOnEFciL8zE+IzF+24+L5PLWQ=;
 b=x2BC1FGuUuuFPSSjCXZYImbmNPV5e/luqvY/aoWAxWMaOCrenAK88PpOg61OWi9Gf0HUXwoHfwLUcLTRlP6B5aGIs9looU8P7/+cY60XfHj24egyHW3RJG2VMho04ybu2Na0dSYlzGs5p5c9jK/Wsev5Oq2T/4v8n7o42yqmVZ+SwEo2CWugEKRlBFdG35gvjZUKieaILS6O12xed02MNcju1xrv1vym0ayCdtooob2qbZFSXSj/ct8xb77Tlz2Ezsp8y0C0Idsm771m8DbXekC9yOlGI34mlFNpiizJvNye2tCDi05dnCfZcH4rUEhxO/WiXZmm1jLjpI5pzH8EvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9LTqCXbqoLxybTIqHfOnEFciL8zE+IzF+24+L5PLWQ=;
 b=a87lt8A+Q1PEaVYMjiUYWW1k0agjQEYotOn4soBEzEdwNHZt2p0CQTV5ARXC4JbtdFKXNXaw4YEHbDUuM39DijscXlNZ5HNJREaed6wxKaqPad17uu4QyT45BRr1FxGhEpreXk9LJHtzS4lKqz8zJsu/dpjdfYyeIuOS3KSVyY0D+UvEOpxQ64lOz+4o8MGCI/K579ovZ5jPH/FPpfVstYmf5aeGmbilB4o5HDnqI4IpTIOFwNzfp7skMQzw9g4pkUddWh3WD/u5CFXkeQMoQtniTyYgLaSwNjxhFw5LQfgFxIUtskNiUBENw3NX2R6Mv5/Eb+pKCUIZ+/wdDpzu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:04:45 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:04:45 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH v2 4/4] vfio: selftests: Extend timeout for runner executions
Date: Fri, 11 Sep 2026 11:04:27 -0600
Message-ID: <20260911170429.1642480-5-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911170429.1642480-1-alex.williamson@nvidia.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: c65443bb-7de6-4554-b5b9-08df1026c791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uwSFlMN4F0zR1/lxoxh8lOZjmvht6kL4JHxYsmx5zYZ/y4XA/FnfG0DWEYgzBmog0Dux4D+OovQuJXX18oR9nrDGu7zuQryQG8NOOhKjQZHJMQMdFpT/HRErDAjPA1sjZ5kX/IHVAruaccFGc2Vju524mVPDQr4rKj4MSXWtJI3IOpcfZVToYpEwiWvscnsijrgDTbyGEFEQEMPK12CfF3QdFjdbRmpH1s0qAb80LyoyyLfkS+LVCDW9I/vzqflo3pWm+Ou4zEc3TNHZhZRZ0FUlNCHQfITSEZfXjsMSJPcibde/cdLp+U26LTRsXa3892cpgtJY5I584Wq4zEpZnJZBMW2/4scZ9YWOupBbaBzPV+JQS/fpama+KzcHe79Ovg58iw5wNEPa4p3e5XWmTt6pkTsGVEsqD5jThF/y+lHUMU/TuwSmrv5Eq1b1MOZ64son0FejVw6SgN38GoADJrePtwv2xFRSmgrG9f1B+2Ig+dHOSQH+tfM1O7FC3W9FTJv/mVwWwxaKd2UZpJmbQGGGHELjxOhSu58T3jkMPx/iotlltZb2Wj9frlTBjy9Yuvg+NTj1XoHTuElrR1wnXVo3p5pgVg7PBqhzLafbDdvoXVd1FfXZxmu6+B15I4vjcrxRijLl8FVNhdwrLu9RYajWpaDa27gBMYldNYaYvt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4J4Odk+1xk3T2FBFEz/hFqh9tRimgyPeEzr9k6wqOwLElZpgR0YZdIRsnOIu?=
 =?us-ascii?Q?c6efRa7cHctlM5f0p5VPEs6jDzNOxhQ79x3CafeqGxGLc05q6GI44Hc8P6yp?=
 =?us-ascii?Q?3cnhDcnHl31UrCjiwdi/quZI0xR7wPkhodB/aeaEx/JdvNB/OTtoFHDNbukJ?=
 =?us-ascii?Q?y/1NOVupCuwu4WQeUAfZLvamfhrNmLwX+i4Ok7Csj+MiVKfGjlIwy1xbVEzy?=
 =?us-ascii?Q?3qHo7xJYmVn30TF7jZ44sMMm7i3iq90tlLxa5kN3dhGBUJyOTrpvygqtojQZ?=
 =?us-ascii?Q?nNpkdOfNk7hBAj2ubOxkNLytEtRtAE3MAVpYxC/bsu2rovMLgyigjDL3hZh5?=
 =?us-ascii?Q?z21h6/Q4uBxTqk6ZXlS/J0Xi992n5vYT2L3FKXbenyo75Y5TjA3dqYR3Lv2F?=
 =?us-ascii?Q?OmL+RH97niJ3aI6hdbeDZorJD2QWzD+TE8UAXTqbOPn6Zy0ZoL96XX+9jBgH?=
 =?us-ascii?Q?IKm0NxdGwEM1FcAffSFniHiOrd5mEaKhEOCkZHhpqofq6szRdxLORiMPnFim?=
 =?us-ascii?Q?97+FtyQTVHRdP7H1SRgzGlLC4cHHsVNetWaJTkL0RquH5R9UfSPDqbTjqpVY?=
 =?us-ascii?Q?l867nCLhLK1rYFnsajdZpsujUKMd8gbVA0/jbfpaWKeWMQ3Q3RdtR1M8lRUK?=
 =?us-ascii?Q?Vp4pKMosAvzpl9+gZl+ETWeSjNb8+K9k3MUm7/InsY9wNy34OyWWgsTollr9?=
 =?us-ascii?Q?oJ7nYkU1J8Xxd9EKULy9nOhCcizp75TGD5xrQP1iKknvrL1qcMC0F5MCXNkn?=
 =?us-ascii?Q?aGcMk8jdW0lgEmi8VP3juTgfAGKTDI8/LBjGzvFvqwXygWnu7xo/x7CPyBJw?=
 =?us-ascii?Q?NB7G5fR5eZLUcQ9eUHbU6APJhDGjgnJUEniB7scRk9uJujl8/Kc0RdLT/YdH?=
 =?us-ascii?Q?q7hrZSd/NXnFFLwhLPgQjgdI/ZmTWOHKfEwS/7yXeAxqe3ivtIOE2GifFpXX?=
 =?us-ascii?Q?AED3z/+AzBm95K9etQiAViME60jTmJy5Kf0DmN8k15isG3VQLshWRL7kKPor?=
 =?us-ascii?Q?ykcnj0gKy6iv+aAQaPpiVdG+cGmY6ZdyzDi1VK9fjlyp87Qz6Cciax0zVYa4?=
 =?us-ascii?Q?caSQIE9TIlA2F6pnELI/oYhvmp1fquFGQtdhi9Tl7lh1qtFWeBhpRg13C9k1?=
 =?us-ascii?Q?lU6RILoI0ed7esnvx+BYSaC5XN3O/P0lhVx0rCRDsygZ4TwJgDtk55/4lyWD?=
 =?us-ascii?Q?K4mkPYkEYlamCgVnUzmYTe1zyQsV6WBy/2WrgvTmrm5Ig26fxxMzjLBG/P71?=
 =?us-ascii?Q?xcE4rf7ZAy/46BimA/8rNGBbyPBKd47rZVoDdoxP7no+r8oeNWTfiPiNJmhH?=
 =?us-ascii?Q?Kynv8UcoDEXGUYUpVqYTmQgizNn+v51fumDkMFb8IFhYjBdh29BNrNX6TSDq?=
 =?us-ascii?Q?DYDpRp2k3CMeEBtwkHm6bFwTJaMcXxCpwkpK9TyBZzKKeqBYPh8o/nR8/0sR?=
 =?us-ascii?Q?w5dKyQIm1Lei5CAhbt6E5Upqgjx6YKJR00wi0O69hrS3w+BEhSvHo3ISkYlV?=
 =?us-ascii?Q?gFe1hEFEDkmzwq58NKMOrcmvss93oWj9uNFF009Q/+3XGtyEwoC8aUI+cPwU?=
 =?us-ascii?Q?yifrJrDGOWT30NhnatEQp8rLK+/OdThwStwbTG7YEPmCprLvNUp5EtbRiihs?=
 =?us-ascii?Q?Idxx+HFoyl9P/hwJ3DAEbLHiLF4DLIiz0KBK7yIpX2EC3YdbSEKXV87HkUVD?=
 =?us-ascii?Q?UQa91x5Vu2GWjRBB5ICw/hV1FbVpOjrdpKggCPClVfkta15X2sw2PU9EKQUy?=
 =?us-ascii?Q?K/5ajVGNgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65443bb-7de6-4554-b5b9-08df1026c791
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:04:45.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbJ191dCKOfOhsQkzvVr5/Lu6OkieX2e/4+xQp0dMB475sWyRpenlP/J426QtoqfyiRdf1t1eidYhvufMnOLWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

When executed via the runner, ie. run_kselftest.sh, tests are subject
to a default 45s timeout.  None of the igb, ioatdma, or nv_falcon
drivers can run the vfio_pci_driver_test within this window.

The igb driver is the worst due to the device getting wedged from bad
DMAs in mix_and_match and requiring the full transaction pending
delay prior to FLR.

This is even further exacerbated when the system implements
firmware-first error handling and the transaction pending scheduled
delays are preempted beyond expectations by SMIs.

Worst case observed runtime for the whole vfio_pci_driver_test on
such a setup is 450s.  Round up to 600s.

Assisted-by: LLM
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/.gitignore | 1 +
 tools/testing/selftests/vfio/settings   | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/settings

diff --git a/tools/testing/selftests/vfio/.gitignore b/tools/testing/selftests/vfio/.gitignore
index 7fadc19d3bca..fc14bc18bcd8 100644
--- a/tools/testing/selftests/vfio/.gitignore
+++ b/tools/testing/selftests/vfio/.gitignore
@@ -8,3 +8,4 @@
 !*.mk
 !.gitignore
 !Makefile
+!settings
diff --git a/tools/testing/selftests/vfio/settings b/tools/testing/selftests/vfio/settings
new file mode 100644
index 000000000000..c9abf1c19f19
--- /dev/null
+++ b/tools/testing/selftests/vfio/settings
@@ -0,0 +1,5 @@
+# Extend kselftest default 45s timeout based on worst case test runtime,
+# currently vfio:vfio_pci_driver_test running on physical NIC, battling
+# SMIs due to invoked firmware-first error handling from bad DMAs and
+# device wedging.  Observed worst case ~450s, extend to 600s.
+timeout=600
-- 
2.53.0


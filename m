Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20646AF0D;
	Tue,  1 Sep 2026 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299661; cv=fail; b=uhSIVgWNiTACrcSsUE5F3Lf83Kc8FgSGsSoAa65VyzpPIEcYgrAPD+TU79inZQeVnYils9GC2nZBReMyMKNGd2/DLK9iKfBQcoCghw4hcI6n0mOCDfYWdjdf3mZ/Fcc7K8ypFaZUZBAUSCegb9Spy9BWaKVutWkHi7cODVBlBqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299661; c=relaxed/simple;
	bh=5xfc+27LAfcePNukA57ytqjziQ9JNDV4dY8VNqGv2AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfW9iSZLjZp7cBa0FJjznVja45DYt3R/lMD+gR1yCmFVL20yyb16E+72jAXottRDEErv7+8Yf99KmXwgTsHniZRJtvSYwxHKz6VWI1xnWH4nJ9gy/GnZmuKbX8z3q3ZV5buW9oH19xBevo9Us0GmJvxZ48JCJnGY4//2Tnk0B4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atz0gYdl; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atz0gYdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1wLwFzlRqpgHXQCu8pgHU73zpYvenLrN5nBh8yiDymwtjpCtTdqDz/jUNBrxO/+zexFx6sSsjkZ7+v4/7Au9L+NzVWXSNs0OGe+AZzgrkhUqX/nV6rhBV3Z19v0096M5K/cKVABnr718zCDHNykawu/5UQieGLM5VwX5J6DL0vNlPyUlbpx8uzY8vwH2Q/uadk9NAOk9mWXg9EVJFF8eNA1fiMokHbSfXbWsAJIxqSj7s0f57KdigwIMkvBDLlz3pJGjdo+Po1qoHG2oUitRuNuRlc12Ka/oE/GbtJbrezRDUR5Nwn4Ep8sbD+bFSLj0MMMUp1HeTqkswW7rAUPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO8fIYkRplkpm437ZyunXirqb+2ZqOSVG1cGAvVPfPs=;
 b=iiGZ/JQ3ggi6LzsTy4Wm3kIDrQBJ2WG+1vf4RRlz7FPMC8GhAhwMe7Ws/As1VaaCrOabkgaJTuoCvz+ZqKevWMOvDyKRkqmX7Cya5zTBNm2QPckubEXrYf0gnb24RsVB/a04FY2DgCze/v4ACxWOM4MwTxZ9BWKRgdVI5kFP8SsEsg0O7ct3ZoNzS/BB4/i++1uKpjO3yogmvySWoMVoznNcUU5Ex+0DvvaMrDw6TBoMpbkfsmOwq8apitBSwylCSkgxV4icvEAEkPPEt5FzfhH/degJkT6uZ36n1yz1SWWvgDdYXo5P+DudZO31F4nV8Cd3YHsetUzCDTBdAqM3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO8fIYkRplkpm437ZyunXirqb+2ZqOSVG1cGAvVPfPs=;
 b=atz0gYdl+MO17DH3QerqdAqGZDh/OT/cgm5rU9Ts3fVu+g5H8Z5vdpJLE92gq4LoRztiyBVHjMmkawZI7Y+kbCr8YeCyUc9EKk3E1Gs63WRbOFtwY8GJtAOUzWGRAmY4Esl9/IyceE4yTxyj9guGoW4XHX5c4IZmRGJXxFU2LkrzduZF3h290P1YULWVKinpwiDBO6TbNKVnDtTxHgLzxwWtX0Lv5MObN0qMzjEukOrOE4QnW4YlaPLPguagjoCRl25tO/FMh9oPhhW8vxrJOJHlpUUUYxNygHECWoKnEsWWBVMzsPlxnfx4FebYwcS7tjpOVP0fXEH2N4PSxXllMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:54:13 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:54:13 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 4/4] selftests/vfio: Extend timeout for runner executions
Date: Tue,  1 Sep 2026 15:53:57 -0600
Message-ID: <20260901215358.2421359-5-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901215358.2421359-1-alex.williamson@nvidia.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::27) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf8e7d2-b4fc-4e88-e1b6-08df08738f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	TYDT9WDWuy7SKy8tO0AQst6G6oqHG7BNcaMqf1eST4pbEurRqJbpTa1tLDlVTtEFR+ZPwx+/9DoZdkFfxetavImWPZfovLpwT1PkvdNYhHfITL2mcXQ8nSvqJb2MJZ7bBSReXVx4vdQWjX7iB+DzjulxTMHBFqSASeJSCifY0nnqCVALt0dZ7UL9BP0zMP0H0hDgeISPsLdxLqhWw2MhkUGIQ2sRl7tnrDIeopVam7nyCEzDW5FgB7rv7/Mwq5Q+pPeUEF6IIc4lYW9LUn+LjaTPjOqXa55rN0W6r8sJqzh32F5unGdpzhNDvT0c0dHeJSzOnDshPVQXtkGyN0w2jJ1VUPJGY0/ynwM6EWq/Ebt7ut1aZ97c5vOYrV8xLlm02fzx6skP8fAvJOpl3DADc7aW6mQ6wRa5gURnaycWrntOM5VcFzwF3QhRrGlH4pXE/oHvrThJfxNmTgoRal/vjAScGOCnoFQgJKlvs9ZvIs/JH4AEq+tl/ASEGl7fTyDbviQttyNwRwooKyld9OcVaKiH1+kBqoUN4p937zLaMuEEgt9QmHqbv4psxvRwjMkiFaCDmx9uGlbGql2omHh4CWJ83bcJF7fxBS5GqKxyb3NPlWh9CCg2a0d98KlAvXsLgu8SbB4c/SYO+59nJqhdF+7AQ7+bfUbcJrkr1phFNBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvQ2IbA61sjrQunHFSekvjQiG5TBvqNwGa6GUpPCkJ3S6TKEDYmDBrggQybq?=
 =?us-ascii?Q?4awAEof/C+vHPMHY6l+/XMeASjyEG82ax3a60K+cvFu3xD2ky2F9c3Rj+PDQ?=
 =?us-ascii?Q?K9t/DbIAM4wy+gwr4NH0b42Sh4aWS4bZYNlsQnUIjBrV0yb0pPvzJC0a+Pne?=
 =?us-ascii?Q?Dhqu6UWbmAfLjx/QJwD89zkbbv4mC5RbzGvO+lT3m4+Do852yphKJu+Kugph?=
 =?us-ascii?Q?b7GL6VvdDEbiou+X22Gk2UZXgafFcEIOECwJFm/hrkXfCGJQ1eQaqsnQ5Q8k?=
 =?us-ascii?Q?Zoke3KHNGNxDvL0GZ3iqZ9AV0TNQSdpzsxgbFg+nUUL1WDIt43YJB0Rnz+p0?=
 =?us-ascii?Q?qhGQ28lq4yoOaNCONSnU28Ux/cZrQV6CBxx7Q2sq+1ADgfUqTu1eKdaUs2HH?=
 =?us-ascii?Q?VU+zthkZ9eFdZg6NRQNsql9mM8IhvJ1X1EMnqQEwl9IPAOHAdYZmcncl72ED?=
 =?us-ascii?Q?f7T5oEhr4qt6qAQjSrg6tlDOc6ctR8RHei7kInCY52+ZnVzbMr3pvyI3M6wK?=
 =?us-ascii?Q?WildO5Lv0CNX6fRaISCu4D3GcZOKwg27KN7ohaFiqM/shs87P+v77ueK7aRw?=
 =?us-ascii?Q?nmOhUuMQLBsNavCFNQ0DJUxDiMzJ7lPbQMtSAf504DbVO/lVlzPcSOQ4M63h?=
 =?us-ascii?Q?N0ynFQRVkmZAfnq3KsGWLWl+tGU60j9iYPww1SxIQV2E1aoFvy7uVUw/QGXs?=
 =?us-ascii?Q?3SHk89n9aqX7XwST6aeiQuznI/fACX7ANEvR3X5LB6XaJl3MDJDIZYb1rgWu?=
 =?us-ascii?Q?ek+1yN/gcedEMw6oYTtxqgyLU7VAaiOw1yGBd0luhkn4SV7tgguze+eAIPl7?=
 =?us-ascii?Q?BX8If1kdwusfND8+Zs3TjbUhxLHn7hKJI70Uo0GdqCDsf+upUcrdW2f6c/4W?=
 =?us-ascii?Q?UmmPtYthXmxXjOrV4+B5UqnC07GL8wjfSwiyfebw6XcEgc1m5UDk+vGv4Snw?=
 =?us-ascii?Q?fhQwyQ+EHWALhJCbVPoBOk6ApYMa7egfLibteA8JYJN/tNbxjJk+sfoDU3Ni?=
 =?us-ascii?Q?n19VYjApOa8kQOmTbql+6X8L8Gfv3FE4ILEfr8h1vfsqFxeRgJyTE00DuNuk?=
 =?us-ascii?Q?lRBo+pnb8WE0lX9BbCiOy3om8rVYhRFXHgwt4RPedhGeGw+futn8nFhxmIvT?=
 =?us-ascii?Q?D7F/xBsvSYFXwXley5dtbROx+dEMbQkJxeqgN377lHVUCeZtw+dpnbI1jkuc?=
 =?us-ascii?Q?UgO0IqvrDaLGoQNO5WJE7Xlyhg4+Aahb0TPZueNl+OTM7HmT27cfjxqAs9rF?=
 =?us-ascii?Q?7O2sDqvQb10yvBn3SzjXxaP5YBPSmxnJRLq6gEaxO7Yp9pj8LpNOO9KOwoq9?=
 =?us-ascii?Q?cL7A2oxbL2HRArpMWbo/Rin5Ioudg52WXKmDZdGpvNBMEwk/IKK6ZBk+h3wh?=
 =?us-ascii?Q?6SMaplKCTSQM+muLxkMTm5W3okOcpGPBzxvZf4FI7yqZZrjvtGFcPcQtN8n5?=
 =?us-ascii?Q?H+Fkogu1KDaji4Ao6rBI9gLkm9CGn7PM4JBoBSB0FsLyvClfnTv16/DnagKw?=
 =?us-ascii?Q?yTsexPxl5Qmt70qn4dhHJ/C5LtZ9CsNa2y40L7in58t5lFuE5MXTOu5sLDkm?=
 =?us-ascii?Q?tHqIsQCqeptNgTbHPiIFKCbr3KocIHqTGDG3UktMVvT3iqW93+TipuWC/VIU?=
 =?us-ascii?Q?/Lf2uI48b9p0kgr6i+urzM0Hy+LefTHncPmwQXqP/Uh4v1qRsAEBisep6880?=
 =?us-ascii?Q?UzWNedG5tFF8JmAREs2XuN6ul2Nuf7aLfAu9lYKnsr7GS3xVn+4LgNKDaLpn?=
 =?us-ascii?Q?HcHVsgLGkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8e7d2-b4fc-4e88-e1b6-08df08738f95
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:54:13.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsXS5XMAQ5UqkpUxgdA55mRbY3LeF3ReB0AIA4KYfYNup0bOuMTAMEH4xkq6421aA2oc8SSdI2aHGiLT10BUxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

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

Assisted-by: GPT-5.5
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


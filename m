Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3401DFFD;
	Fri, 31 Jul 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489493; cv=fail; b=guLrLuO0pvMhLv4D3leabi9fJJ6rRYqnMp7fHlYedD0XsyMhMJJBaq32TEmPaGeyno0bOIvHGa98ljyvmgam4gb4KQKnh4Hsa+kBR8eMtEU86lYaRatcKB0Smkg0W98ZpCqlNE1tc7AuEMJhOjNtTQHipD2yxTaB6ZOavuY4qKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489493; c=relaxed/simple;
	bh=D2v3wqvnIHpHlSKCM4cjnBXcOEPjeT+CQZAEX1DHN8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EIuMmCpW0s5YL+bbYrMq/dQfJ0CJ+iX/Ef9smWO0O1LnAgQ7iqboFEDHAwLjUH7SVhx5CYe8/F8+WgsoK1YypMqHdLa/Q1TUJJZ81SStlOGODBnQwTUivRwUd4SMXm0U+aDxms7XW2rlzdqG4bZcF5mpHAbxR3kJdu6CtVUGvtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=f9FVGLBc; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=A08N0gSQ; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="f9FVGLBc";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="A08N0gSQ"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xPOu139274;
	Fri, 31 Jul 2026 02:17:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=EamZGOmrEauJC
	7WSg4ToC7BjR8nyChAUsjYRNjP6kmE=; b=f9FVGLBcmiy4jmgj5HoscRmqTeint
	jsoYmsatX6GUh4Z1unuP/WwEOEnLo7DFvBznWpOFOMlfY+5X/lg+jTlfcJsNx+jc
	Si28PZ8o3Vd6CoJe9Pe6ODkZL4j0Hzgep0ituRFczTHPsY/B4dmoMoUJcwtNl7ua
	X9Fcz1de0i18IQ0whG5ISWpO5JRwSYjYVXZVV3j+IlrcTREUXML+WB4dA+ODm6lv
	RoIPBqbVFPHChhWKvgcasJHlQuL3hG2DzRgUU0dJCvsdqWPwFuYW2FRXY03k7mJU
	O8Sgmob9VszcpeQgqX/eaaAakRdZfjT1E5fDUWRBrprSwrXchljMOzFLg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022114.outbound.protection.outlook.com [52.101.48.114])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4frpcy0bt6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 02:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9VrbgW79lEsD49+QsNpOn+/pJCDXW6b7WnST5yVQ5/4cqT7cfLAjWQaIqsoPUd7UOXblvU+8IqISjWXfIqH3O9VxPEpaOVhtbgE2pyZGOwN6TFJigKaC1seCvPqncI+qyOZq+l2RUXhw0lrlP8N7W7tCTiUgiCXYAvU+XA89RLnOC9s+IPQml8DrUqr76/qFoc2nDDeAJRaQBDUjp3BnWLNd9SWwwvU4x+rtZl44kc0klRoKK7qHpgobeG6FXxI8dAtkH4tdqNm2Zn+4te4fVKjXxG0mYcxEI7zCc154YNXLDaciCnGZ/2fGTVFLjtA9FpMDk7P/GZ/etnG77mbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EamZGOmrEauJC7WSg4ToC7BjR8nyChAUsjYRNjP6kmE=;
 b=a0E37T20Lj6NCmKA74aeUWruD1xxZjNBHtiIHDFiZfBDQxNQwuFTB4XYbql6mqk9DFTTwWdpasqq9nco/N88qZH6wMKu9D+4BhnNK3uKCY3vigFv212/dl9tf5JTWwCbH0O/wi52FCCjSNK7i+7jz88l7KT7HdD4nnIGhYlaVsiDx/ORHCG+AJaIGmT1l963p72NNx8n240rSxgDxL8yCExtwDNS+h10QZP0Ua2l/gEKpUejyUwf6C8tdH3lPTM/bDC+Ra+Ap7ZCuLhPfIYcmpmwnrbNE7UADSUgE6/yEOERw576XRd8Af/V0ygFU5o+0NhxQF4bJQSWqdKRKUrqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EamZGOmrEauJC7WSg4ToC7BjR8nyChAUsjYRNjP6kmE=;
 b=A08N0gSQSDzelQ7MsDEjEEuYtqYAa7kk4jz7Kto66eoQuEkTCsjoHoQNUJiqUINpP+HaKO2MacW3KGVckSgcUtthe49FcVpzlcmOzrh1I5VH5tbAnN8GcUC0iubbtenEqF8fUmf67Y/b0Mj5V7k7ni/2h3U8jL7H2GJFUH5bacaOdSTN0DLCfVG3XKrVJNEvtNm2B8SoOakiuujSzXBz0PbNYNJyCk6PxyAc58GWrlC2husoJSD5O1DBy0vX2+09dhf38usEqjOI3IELCPoMYuZa4x0BrrMtB4j22kVSYYEzyF1ZiTWEOyCuTF20/ji8S+anLllq7IqZrUBlc8ycyg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by DM8PR02MB8123.namprd02.prod.outlook.com (2603:10b6:8:1c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.16; Fri, 31 Jul 2026 09:17:38 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:17:33 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: Florian Schmidt <flosch@nutanix.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kvm: add EVER_MAPPED ioctl and capability
Date: Fri, 31 Jul 2026 09:17:03 +0000
Message-ID: <20260731091708.2963414-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::14) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|DM8PR02MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd4036a-d98a-4c68-82d6-08deeee48da0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|921020|38350700014|56012099006|3023799007|5023799004|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+cs0xGlpoiAxh0IN1efPKN01feEkxA2+5KlNcl0EPZVED5+AJsJWDYLEDJRxiqBCoH+COyBJflJie1A+6eNHuP/XopJf3+aOH8/BcZnbmFTEhcYm/12VrntgY3cRyVMHABTOGZBvtzuma08ZzatN86wwz5+ipZhYFygp5YkKeREG6sDmkDKlH4WPl2Va2PRflWydnUjSIhd8NbpKW+4/4brRshzAjFTgRq5qjedYJwMC9qDzF9B33Ij/xVOqNhkCTzl1nUePnJ5GW7iy+so90JP6CSmigV24PHDkhgerHLeUFEk21cw8ZVjtoT08gsZ33ARKNue+uTCuu401xC0J5seHKNFwcaJueKxNF6YUmukSTblpXqK8mthWM6M89LaTSXYNUiUdXgV8tKaLbGBL5UvlxtjCZUtA7rBRGJmqsOyEVhuPdpYyxj/KxpeB81n87VjngP4UcQsARZIwmtbC98YGl0C5Z9eLpoqbpMAT9ZMZbAek9SIZ8MyBf+fdvKk2jqjP0lDOy88Mz0/IMWpqaUMK4u8QEjxeOyYdb7Cx23wusXD1kyPMfq+XBXWVpUMXri91wQOWkkjahNA4vYXKRnVvElZgRisvYVh1sp8I6xZJK7vQurjP42FAsWrcTO7lq+HIiabXhonqE92kEZmer3YBKX1+w1wprZBBonXkY9VaFp2jyP1QuV/xVRSjDof4/wTO9FW2/d5yTzX5u/QoRzPC4oPdpgZNficDfhlnAS7eWs6fq6Ywzus4dCQ/e35R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(56012099006)(3023799007)(5023799004)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22V7wUNuN8mlvuQQsulzhZjzL/47itJpEUR4SeokP26+5/quuPAiWqbF9CtU?=
 =?us-ascii?Q?JjAx3Vd2NmzpOhw40LCgsSQpHFHrhHoZG9mWigm9PbvD54aVgLnTIWeXAMFQ?=
 =?us-ascii?Q?eQhpM5lfmXVNwYxawkKFvdxvl4KCToeUWDbZeUHGchl4l7B+45oiANBmcSqH?=
 =?us-ascii?Q?MOYRrvF9zlUG4NX4JYBbr6Vx/u99FtXLIeBWuZqPjVydOVIOlUqf5FSIM5on?=
 =?us-ascii?Q?7uqGxpoX9zjvLyB4VLR5DPKa1OWY3Qdel2ibRd97zEAdkoTBpOut2sgqdd3i?=
 =?us-ascii?Q?cGffVcmljHt+De3KbeDuyi20ogEDkHc2L89eMzK2zFROXllOSLIs8BPrISYA?=
 =?us-ascii?Q?2zQcabqggqBRpD/TerMZyQQWoJDC65RUW9iOuNWLCY6HmPmDtYHfiwxgg/UR?=
 =?us-ascii?Q?jOp20to2nYedkF7lRHJzdp3BnKmfq4vUymxeRFedG2G0JA3J6Nd4s9jQ+5Ey?=
 =?us-ascii?Q?NpapleqfbulYhNb0MiVr6qSJo4Q8vZVSyHqFXr9sHQwLgPEDWfJRhAoJc/0U?=
 =?us-ascii?Q?ujeULCaHm4vVtt0erzUPiHbN1GB1PYnJ38EEjTIgu7oe7zmkxwQyPkfS0qVV?=
 =?us-ascii?Q?8wEJ5XVj5lftaUU8ndqjr907JXPOaOICDvxNPVp8EMIoFbEgdgJjcz+Xw91n?=
 =?us-ascii?Q?cKOgqGlPxaOrBU2sclR9yJ0nIM7O823WchiPGMBcwLmO2jEk32tgyGKeW4kF?=
 =?us-ascii?Q?V9EstBa8BReYcflLgN6t1LZunmYqstFNxEH19tina22wA23tba4Mq5spNiVo?=
 =?us-ascii?Q?QwBVkEIawgOiEBqgn6nAxertjlqPWhEPTFiyimzgAvzd7WUQcpw4kSkkY9WY?=
 =?us-ascii?Q?KdmFBvv62/vfNJpduld8umToURrexa0U6fAUyLid1vJy04MJhE6ChRbDbhjZ?=
 =?us-ascii?Q?d3B7JiFX8NEVpTeHsVmSDoKPAS8R5+0rKQfmm+oxxA7h9YDB35A+TsL6DtOq?=
 =?us-ascii?Q?hQ/E/SsYTejgNlmiLInBr0JuCBGkwqCI8OMQXfTMZXx6I9e/rLoTlvFndin+?=
 =?us-ascii?Q?pf0yXVMRB7+BfAZMaJJu2M3436DJg2WNifz4+MYqZEuWlGQI8vbca61SzeAs?=
 =?us-ascii?Q?sIf0BgMS8kNR+pihTc2MIl3WgMHK3BoA13SyNuu7QjQlYzqzoii0vUQ9nDtx?=
 =?us-ascii?Q?amhBLdwd6EwXCM78V6aibNmEhkx39mY0EuTDC/9ji9oDv75vsV6fY9Y6abDh?=
 =?us-ascii?Q?Gdhq2GBE/yo+1UOp6LZtmh2rNRVApxGWTRKRJwcVNyuRyPkolduZXbRZssnD?=
 =?us-ascii?Q?Khehi/ag27F5AQdTBJNod7OXWoHDvPIxEFJ2tUIKMDlYq3sy2/aMXvhsde94?=
 =?us-ascii?Q?qPE5TrNhjOphxVRl/UPDNTsd6ZulgHOOuZ2rtBjsrrwqlPZTfkODkP6+sEPv?=
 =?us-ascii?Q?orsdV/0LLU2pUSKdQQIz7Pu+iuMPf67J3BgC48biR4846sOFv04Ug5DE2MB2?=
 =?us-ascii?Q?C65LBJJYdDoaYRiT1bsXu7aE/cCNtx3VJgmyCX7cl0P4+KoDnwDz7YKqJgaG?=
 =?us-ascii?Q?krBh3oHee9qtp+CIDGCpK+sJctwPbeRrDUPe0oDbGgvw7PGNAQE4ceY4WSak?=
 =?us-ascii?Q?QkmMIrnI5Sxbj8ICxrIz986Hy+gbo+esvlMjofR59x2ANXwrk0KNFSYVlK3r?=
 =?us-ascii?Q?V5CGolVuZJiTMRHLJkzzN62giKkbNcvyXbWa3o5Z5RszrUp6pwBRycogOR7u?=
 =?us-ascii?Q?wT59aCT6ozRymWf+OY5sBknfh4/By1ASXYCLelDoXcBmpC7F74dgVYAB/Ete?=
 =?us-ascii?Q?oFf4bvw726GI1zi2J4wUzyBSncWB+Bc=3D?=
X-Exchange-RoutingPolicyChecked:
	ieu/E7cH1EJvmsSo5htlsBur9kJMMaMBB0vaIPfbJamyhRGjgXJO1JGNN85DlHPqpgJVxbExHMDj4UNczkzbmCyyo9MuVaDW4tuWO6mK7G3Rlw5tW6lel+YuBhwcbfWFjgrXKcuj8MLaUjAUHoiWPNHvxEHOP1agLsl24U1Udjfydt1XFXW6L53CYCGiOZ25xDsQ4VkVFKoUeXs7ieFYw5aoRPkiniM7+5xnf0J/5nbe/gFKkAWubGN3WxO6lsYYRqKyg2LXU0AzURcb0e1Ol5WVov4mN16B6p0hh1RN13u9MdwAO3KaewlDEhnzgN6y2NeoqrXMigUDPU8DV4F+pg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd4036a-d98a-4c68-82d6-08deeee48da0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:17:33.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+MWNx+nGiJGKoRyiFB0y0cBIJJA1R4OHMczO4lUQAFR/FFUo4kpPxuYqrnULd1M/fjjqquBuJXVp9S7CCfGF4mWa7hLqNYRrQdiF/YwQFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8123
X-Proofpoint-GUID: yrTH0L_-ln0vSpRLKguihFB3XdG0ohTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2OCBTYWx0ZWRfX5xrLCCjsyrmM
 cAz4MV642flZ1D3v+lVA2Smdyu0MgbiP5ASMxGgRIW+iJvBLnHJu/eFnfDvqysKhU9uDj/U0h8w
 RbuXqInVUoYVNg63VrC4bKZSJcw3MuYRmQG5jxMH0WNDcF00RcMaYlscrGaUq3KjicwBSgGIRuS
 RnOPhlSFxMiZhNK0HzLAV39C3ckOTVGJoHs09GCq+26IJYP5vIW8iQ4dma/pLZx0ewCgexBitIB
 BX+Nb0KpgQFf7LNOeEH4LJcrzUJx4qOaUHJTcWKf/G+giMu3JBfjRlE3DezJr9uu1HMSqrQy678
 zwP4LyPZy/aKYNffXGwqEHl4xHvDEKBpTSPoiQCM8YdlAg7RrHoVcBjdMZe2tWJle9tWOBsEanN
 swhQzGUP0altYaXyedxuYqtdpzZ/gy+p6c/PioYQwxVMpEOD4Af0sBMIymcfhPE9VVF6+/z/RQg
 2QmLuCbiL0GmuEiOJ6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2OCBTYWx0ZWRfX1KDrBWd9VQap
 wXOdgDqkhhA1eFKcp0SSp1AjuMSGFCF2txvhakSvsg8B1xU1Vxwy+xRygUIAHpVtwWf3cdqjTb7
 StH9ZyV7kj65SrOgdaE35dbl1Dp6eus=
X-Proofpoint-ORIG-GUID: yrTH0L_-ln0vSpRLKguihFB3XdG0ohTb
X-Authority-Analysis: v=2.4 cv=DuhmPm/+ c=1 sm=1 tr=0 ts=6a6c6835 cx=c_pps
 a=5LyF95Caz1MJpeKVvSEBBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=6HNEicoJ-shmjKDTAWAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

This allows a VMM to keep track of which pages were mapped by the guest
at any point. The main use case for this is supporting the
HvExtCallGetBootZeroedMemory Hyper-V hypercall, which allows a guest to
inquire which of its pages are already zeroed (and so don't need zeroing
again inside the guest).

This is implemented by setting up a bitmap that tracks memory at a 2MB
granularity. Whenever a leaf page is created in the spt, the
corresponding bit is set to 1; values are never reset. So even if
entries are zapped, we still knows which pages were ever mapped, a
conservative estimate of which pages were ever modified. The bitmap has
to be kept for the lifetime of the VM, but the 2MB granularity means the
size is small: even a 16TB VM would only have a bitmap size of 1MB.

Note that for a VMM to properly support the hypercall, it also has to
track all the pages it itself touches on behalf of the VM; this is
clearly beyond the scope of this patch, but it is on the VMM to merge
these two sets of information in some way.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 Documentation/virt/kvm/api.rst                |  67 ++++++
 arch/x86/include/asm/kvm_host.h               |   9 +
 arch/x86/kvm/mmu/ever_mapped.h                |  33 +++
 arch/x86/kvm/mmu/tdp_mmu.c                    |  12 ++
 arch/x86/kvm/x86.c                            | 110 ++++++++++
 include/uapi/linux/kvm.h                      |  15 ++
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/ever_mapped_test.c  | 191 ++++++++++++++++++
 8 files changed, 438 insertions(+)
 create mode 100644 arch/x86/kvm/mmu/ever_mapped.h
 create mode 100644 tools/testing/selftests/kvm/ever_mapped_test.c

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a5f9ee92f43e..ce6e1d15d48d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6566,6 +6566,53 @@ KVM_S390_KEYOP_SSKE
   Sets the storage key for the guest address ``guest_addr`` to the key
   specified in ``key``, returning the previous value in ``key``.
 
+4.145 KVM_GET_EVER_MAPPED_LOG
+-----------------------------
+
+:Capability: KVM_CAP_EVER_MAPPED
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_ever_mapped_log
+:Returns: 0 on success, -ERRNO on error
+
+Errors:
+
+  ======     ============================================================
+  ENOENT     KVM_CAP_EVER_MAPPED has not been enabled for this VM
+  EINVAL     ``granule_shift`` is below 21 (internal tracking granularity) or
+             above 63
+  EINVAL     ``first_granule`` + ``num_granules`` extendends beyond the maxgpa
+             set up when KVM_CAP_EVER_MAPPED was enabled
+  EINVAL     ``flags`` is not 0
+  EFAULT     copy_{from,to}_user of ``bitmap`` failed, e.g., bitmap wasn't
+             sufficiently sized
+  ENOMEM     setting up temporary bitmap for copying to userspace failed
+  ======     ============================================================
+
+This requires KVM_CAP_EVER_MAPPED to have been enabled for the VM with a maxgpa
+parameter.
+
+::
+
+  struct kvm_ever_mapped_log {
+	__u64 first_granule;
+	__u64 num_granules;
+	__u32 granule_shift;
+	__u32 flags;
+	union {
+		void __user *bitmap;
+		__u64 padding;
+	};
+	__u64 reserved[4];
+  };
+
+``first_granule``, ``num_granules``, and ``granule_shift`` encode the GPA range
+the caller inquires about. For example, values of 2, 25, and 21, respectively,
+inquire about the address range [4MB, 54MB). The caller provides a ``bitmap``
+of the required length (in the above case 4 bytes). The call will write a 1 if
+any memory in the granule has been mapped at some point since
+KVM_CAP_EVER_MAPPED was enabled, 0 if not.
+
 .. _kvm_run:
 
 5. The kvm_run structure
@@ -8949,6 +8996,26 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_EVER_MAPPED
+------------------------
+
+:Architectures: x86
+:Parameters: args[0] - maximum GPA to track mapped memory
+:Returns: 0 on success, -EOPNOTSUPP if TDP is not available, -EINVAL if args[0]
+          is 0 or beyond the maximum possible GPA, -ENOMEM if tracking setup
+          failed, -EEXIST if already set up.
+
+The presence of this capability indicates that KVM can track if pages have ever
+been mapped by the guest. This allows a conservative estimate of which pages
+are not zero any more.
+
+On enabling the capability, the caller provides a max GPA value. KVM will then
+track GPAs between 0 and this value. Note that this capability can be enabled
+at any time, but it is strongly recommended to enable it before vCPUs start
+running. Any page accesses by the guest before capability enablement will not
+be tracked. The max GPA value can only be set once; subsequent attempts to
+enable the capability with a different or even same value will fail.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..c607a9193f40 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1533,6 +1533,15 @@ struct kvm_arch {
 	 */
 	bool shadow_root_allocated;
 
+	/*
+	 * Tracks which guest pages have ever been mapped. This allows
+	 * tracking which memory is guaranteed to still be zero, e.g., for
+	 * supporting the HvExtCallGetBootZeroedMemory enlightenment.
+	 * The granularity is defined by KVM_EVER_MAPPED_SHIFT.
+	 */
+	unsigned long *ever_mapped_bitmap;
+	u64 ever_mapped_max_gpa;
+
 #ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING
 	/*
 	 * If set, the VM has (or had) an external write tracking user, and
diff --git a/arch/x86/kvm/mmu/ever_mapped.h b/arch/x86/kvm/mmu/ever_mapped.h
new file mode 100644
index 000000000000..f795337e6848
--- /dev/null
+++ b/arch/x86/kvm/mmu/ever_mapped.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_EVER_MAPPED_H
+#define __KVM_X86_EVER_MAPPED_H
+
+#include <linux/kvm_host.h>
+
+/*
+ * Track if pages have ever been mapped at an internal granularity of 2 MB.
+ */
+#define KVM_EVER_MAPPED_SHIFT 21
+
+static inline void kvm_ever_mapped_set_range(struct kvm *kvm, gfn_t gfn,
+					     u64 npages)
+{
+	const unsigned int shift = KVM_EVER_MAPPED_SHIFT - PAGE_SHIFT;
+	unsigned long start = gfn >> shift;
+	unsigned long end = (gfn + npages + (1UL << shift) - 1) >> shift;
+	unsigned long i;
+
+	end = min(end, kvm->arch.ever_mapped_max_gpa >> KVM_EVER_MAPPED_SHIFT);
+	for (i = start; i < end; i++) {
+		/*
+		 * re-mapping zapped pages and breaking up of huge pages can
+		 * trigger a number of sets on already set bits, so test first
+		 * before atomic-set. Since bits can never be unset again, this
+		 * is safe against races.
+		 */
+		if (!test_bit(i, kvm->arch.ever_mapped_bitmap))
+			set_bit(i, kvm->arch.ever_mapped_bitmap);
+	}
+}
+
+#endif /* __KVM_X86_EVER_MAPPED_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ce3f2efadb05..ea2a37a04b2f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include "ever_mapped.h"
 #include "mmu.h"
 #include "mmu_internal.h"
 #include "mmutrace.h"
@@ -554,6 +555,17 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 		return 0;
 	}
 
+	/*
+	 * Whenever a page becomes a fresh leaf, mark the memory as mapped.
+	 * On hugepage breakup, this triggers for each new lower-level page,
+	 * even though the memory was already marked when the hugepage was
+	 * mapped, but the overhead is negligible.
+	 */
+	if (unlikely(kvm->arch.ever_mapped_bitmap) &&
+	    is_leaf && !was_leaf) {
+		kvm_ever_mapped_set_range(kvm, gfn, KVM_PAGES_PER_HPAGE(level));
+	}
+
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
 	 * the paging structure.  Note the WARN on the PFN changing without the
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..89cbcf8399f4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -25,6 +25,7 @@
 #include "tss.h"
 #include "regs.h"
 #include "kvm_emulate.h"
+#include "mmu/ever_mapped.h"
 #include "mmu/page_track.h"
 #include "x86.h"
 #include "cpuid.h"
@@ -2391,6 +2392,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
 		break;
+	case KVM_CAP_EVER_MAPPED:
+		r = (tdp_enabled && IS_ENABLED(CONFIG_X86_64));
+		break;
 	default:
 		break;
 	}
@@ -4190,6 +4194,36 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_EVER_MAPPED: {
+		unsigned long *mapped_bitmap;
+		unsigned long num_granules;
+
+		r = 0;
+		mutex_lock(&kvm->lock);
+		if (!tdp_enabled) {
+			r = -EOPNOTSUPP;
+		} else if (kvm->arch.ever_mapped_bitmap) {
+			r = -EEXIST;
+		} else if (cap->args[0] == 0 ||
+			   cap->args[0] > (1ULL << kvm_host.maxphyaddr)) {
+			r = -EINVAL;
+		} else {
+			num_granules = DIV_ROUND_UP(cap->args[0], 1ULL << KVM_EVER_MAPPED_SHIFT);
+			mapped_bitmap =
+				kvcalloc(BITS_TO_LONGS(num_granules),
+					 sizeof(long), GFP_KERNEL_ACCOUNT);
+			if (!mapped_bitmap)
+				r = -ENOMEM;
+			else {
+				write_lock(&kvm->mmu_lock);
+				kvm->arch.ever_mapped_bitmap = mapped_bitmap;
+				kvm->arch.ever_mapped_max_gpa = num_granules << KVM_EVER_MAPPED_SHIFT;
+				write_unlock(&kvm->mmu_lock);
+			}
+		}
+		mutex_unlock(&kvm->lock);
+		break;
+	}
 	default:
 		r = -EINVAL;
 		break;
@@ -4197,6 +4231,73 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	return r;
 }
 
+static int kvm_vm_ioctl_get_ever_mapped_log(struct kvm *kvm,
+					    struct kvm_ever_mapped_log *log)
+{
+	u64 max_granules;
+	unsigned int coarseness;
+	unsigned long *bitmap;
+	int r;
+
+	if (!kvm->arch.ever_mapped_bitmap)
+		return -ENOENT;
+
+	if (log->flags)
+		return -EINVAL;
+
+	if (log->granule_shift < KVM_EVER_MAPPED_SHIFT || log->granule_shift >= 64)
+		return -EINVAL;
+
+	max_granules = kvm->arch.ever_mapped_max_gpa >> log->granule_shift;
+	if (log->num_granules > max_granules ||
+	    log->first_granule > max_granules - log->num_granules)
+		return -EINVAL;
+
+	/*
+	 * For the case where the request uses the same granularity as our internal
+	 * tracking, and we are byte-aligned (the expected common case), we can
+	 * just copy_to_user. Otherwise, we have to create a new bitmap to pass.
+	 *
+	 * We do not lock against concurrent vCPUs mapping new memory on any of
+	 * these operations. Bits are set atomically and never cleared, so any race
+	 * here is indistinguishable from a write happening after this handler
+	 * finishes but before the caller reads the results.
+	 */
+	coarseness = log->granule_shift - KVM_EVER_MAPPED_SHIFT;
+	if (coarseness == 0 && !(log->first_granule & 7) && !(log->num_granules & 7)) {
+		if (copy_to_user(log->bitmap,
+				 (u8 *)kvm->arch.ever_mapped_bitmap + log->first_granule / 8,
+				 log->num_granules / 8))
+			return -EFAULT;
+		return 0;
+	}
+
+	bitmap = kvzalloc(DIV_ROUND_UP(log->num_granules, 8), GFP_KERNEL_ACCOUNT);
+	if (!bitmap)
+		return -ENOMEM;
+
+	for (u64 gran = log->first_granule;
+	     gran < log->first_granule + log->num_granules;
+	     gran++) {
+		unsigned long start = gran << coarseness;
+		unsigned long end = start + (1UL << coarseness);
+
+		if (find_next_bit(kvm->arch.ever_mapped_bitmap, end, start) < end)
+			__set_bit(gran - log->first_granule, bitmap);
+	}
+
+	if (copy_to_user(log->bitmap, bitmap, DIV_ROUND_UP(log->num_granules, 8))) {
+		r = -EFAULT;
+		goto out_free;
+	}
+
+	r = 0;
+
+out_free:
+	kvfree(bitmap);
+	return r;
+}
+
 #ifdef CONFIG_KVM_COMPAT
 /* for KVM_X86_SET_MSR_FILTER */
 struct kvm_msr_filter_range_compat {
@@ -4710,6 +4811,15 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm_vm_ioctl_set_msr_filter(kvm, &filter);
 		break;
 	}
+	case KVM_GET_EVER_MAPPED_LOG: {
+		struct kvm_ever_mapped_log mapped_log;
+
+		if (copy_from_user(&mapped_log, argp, sizeof(mapped_log)))
+			return -EFAULT;
+
+		r = kvm_vm_ioctl_get_ever_mapped_log(kvm, &mapped_log);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..d0be94946a77 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_EVER_MAPPED 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1670,4 +1671,18 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_GET_EVER_MAPPED_LOG  _IOW(KVMIO,  0xd6, struct kvm_ever_mapped_log)
+
+struct kvm_ever_mapped_log {
+	__u64 first_granule;
+	__u64 num_granules;
+	__u32 granule_shift;
+	__u32 flags;
+	union {
+		void __user *bitmap;
+		__u64 padding;
+	};
+	__u64 reserved[4];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4ace12606e93..1eb0bac1920d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -162,6 +162,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += ever_mapped_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/ever_mapped_test.c b/tools/testing/selftests/kvm/ever_mapped_test.c
new file mode 100644
index 000000000000..76723f0c9ee2
--- /dev/null
+++ b/tools/testing/selftests/kvm/ever_mapped_test.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM ever-mapped bitmap test
+ *
+ * Copyright (C) 2026, Nutanix, Inc.
+ */
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <processor.h>
+
+#define KiB 1024u
+#define MiB (1024 * KiB)
+
+static void guest_code(uint64_t base_gpa, size_t len)
+{
+	GUEST_DONE();
+}
+
+static void assert_bitmaps_equal(u8 expected[], u8 actual[], size_t len)
+{
+	for (size_t i = 0; i < len; i++) {
+		TEST_ASSERT(expected[i] == actual[i],
+			    "byte %ld, expected 0x%02x, got 0x%02x",
+			    i, expected[i], actual[i]);
+	}
+}
+
+static void pre_fault(struct kvm_vcpu *vcpu, u64 start, u64 len)
+{
+	struct kvm_pre_fault_memory range = {
+		.gpa = start,
+		.size = len,
+		.flags = 0,
+	};
+	vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+}
+
+static void test_one_page(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_pre_fault_memory range = {
+		.gpa = 0x0,
+		.size = PAGE_SIZE,
+		.flags = 0,
+	};
+	unsigned char mapped_bitmap;
+	struct kvm_ever_mapped_log log = {
+		.first_granule = 0,
+		.num_granules = 1,
+		.granule_shift = 21,
+		.flags = 0,
+		.bitmap = &mapped_bitmap,
+	};
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_enable_cap(vm, KVM_CAP_EVER_MAPPED, PAGE_SIZE);
+	vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	TEST_ASSERT(mapped_bitmap == 0x1, "expected 0x1, got 0x%x", mapped_bitmap);
+}
+
+/*
+ * Add 64MB or memory at GPA 16MB ( --> [16MB, 80MB) ),
+ * pre-fault [16MB, 48MB), request and check bitmap for [16MB, 80MB).
+ */
+static void test_one_block(void)
+{
+	int ret;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	const uint64_t map_start = 0x1000000;
+	const uint64_t map_len = 0x4000000;
+	u8 mapped_bitmap[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
+	u8 expected_bitmap[4] = { 0xff, 0xff, 0x00, 0x00 };
+	struct kvm_ever_mapped_log log = {
+		.first_granule = 0x8,
+		.num_granules = 0x20,
+		.granule_shift = 21,
+		.flags = 0,
+		.bitmap = mapped_bitmap,
+	};
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, map_start, 1, map_len / PAGE_SIZE, 0);
+
+	ret = __vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	TEST_ASSERT(ret && errno == ENOENT,
+		    "expected ENOENT when querying ever-mapped log before enablement, got %d",
+		    errno);
+	vm_enable_cap(vm, KVM_CAP_EVER_MAPPED, map_start + map_len);
+	pre_fault(vcpu, 16 * MiB, 32 * MiB);
+
+	ret = __vm_enable_cap(vm, KVM_CAP_EVER_MAPPED, PAGE_SIZE);
+	TEST_ASSERT(ret && errno == EEXIST,
+		    "expected EEXIST when enabling KVM_CAP_EVER_MAPPED twice, got %d",
+		    errno);
+
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+
+	log.granule_shift = 22;
+	log.first_granule = 0x4;
+	log.num_granules = 0x10;
+	memcpy(mapped_bitmap, (u8[]){ 0xa5, 0xa5, 0xa5, 0xa5 }, 4);
+	memcpy(expected_bitmap, (u8[]){ 0xff, 0x00, 0xa5, 0xa5 }, 4);
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+
+	log.granule_shift = 23;
+	log.first_granule = 0x2;
+	log.num_granules = 0x8;
+	memcpy(mapped_bitmap, (u8[]){ 0xa5, 0xa5, 0xa5, 0xa5 }, 4);
+	memcpy(expected_bitmap, (u8[]){ 0x0f, 0xa5, 0xa5, 0xa5 }, 4);
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+
+	log.num_granules = 0xff;
+	ret = __vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "expected EINVAL when querying beyond range, got %d",
+		    errno);
+
+	log.num_granules = 0x10;
+	log.granule_shift = 1;
+	ret = __vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "expected EINVAL with too small grnaule shift, got %d",
+		    errno);
+}
+
+/*
+ * Add 128MB or memory at GPA 32MB ( --> [32MB, 160MB) ),
+ * pre-fault [32MB, 64MB), and [90MB, 94MB),
+ * request and check bitmap for [16MB, 120MB).
+ */
+static void test_two_blocks(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	const uint64_t map_start = 0x2000000;
+	const uint64_t map_len = 0x8000000;
+	u8 mapped_bitmap[7] = { 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5 };
+	u8 expected_bitmap[7] = { 0x00, 0xff, 0xff, 0x00, 0x60, 0x00, 0x00 };
+	struct kvm_ever_mapped_log log = {
+		.first_granule = 0x8,
+		.num_granules = 0x34,
+		.granule_shift = 21,
+		.flags = 0,
+		.bitmap = mapped_bitmap,
+	};
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, map_start, 1, map_len / PAGE_SIZE, 0);
+
+	vm_enable_cap(vm, KVM_CAP_EVER_MAPPED, map_start + map_len);
+	pre_fault(vcpu, 32 * MiB, 32 * MiB);
+	pre_fault(vcpu, 90 * MiB, 4 * MiB);
+
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+
+	log.granule_shift = 22;
+	log.first_granule = 0x4;
+	log.num_granules = 0x1a;
+	memcpy(mapped_bitmap, (u8[]){ 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5}, 7);
+	memcpy(expected_bitmap, (u8[]){ 0xf0, 0x0f, 0x0c, 0x00, 0xa5, 0xa5, 0xa5 }, 7);
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+
+	log.granule_shift = 23;
+	log.first_granule = 0x2;
+	log.num_granules = 0xd;
+	memcpy(mapped_bitmap, (u8[]){ 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5 }, 7);
+	memcpy(expected_bitmap, (u8[]){ 0x3c, 0x02, 0xa5, 0xa5, 0xa5, 0xa5, 0xa5 }, 7);
+	vm_ioctl(vm, KVM_GET_EVER_MAPPED_LOG, &log);
+	assert_bitmaps_equal(expected_bitmap, mapped_bitmap, 4);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_EVER_MAPPED));
+
+	test_one_page();
+	test_one_block();
+	test_two_blocks();
+}
-- 
2.54.0


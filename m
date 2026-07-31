Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7C3C5523
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491518; cv=fail; b=TFeaztFLLp/ctXunyC2sOCgiyoxjPvo+HtzQegbgp+MsTVgklcVxYYsVP4hB9pNQsNDvAPkAOumHrpEotSlQ4ucTxo7DgGk01sNnx6VZYwuCciiFKDpuYLwva7VGpWx8IOdOT2AF6c+OGLPZBKQC2ocrTvWIMo4hJa8MQhTgCrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491518; c=relaxed/simple;
	bh=s86GPmIym7KlRktkUav0E9hxii6ZFhRH7ZnMzVbJgmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rs4jbi0/wVnRcyEVtBTv9SorCeofy9h+/rZCLJSSgzVZDRmCARTemeox6dDgjcnjZbSX+qSS3KTqFvOVh+YYwZzsZ96y8sLbAS7IuwNsYJy+8I+x8tkHg381w2L5iHh6IYh4tGk9+YAqDiPjxJFpg+Umm6c7kfHjleOuvL2jmfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=aRE9NV6r; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Bl/QknQM; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="aRE9NV6r";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Bl/QknQM"
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V983BD417415;
	Fri, 31 Jul 2026 02:51:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=43m1k8CtLU4o9/62AmIm7vcfO1VgHTpynnj3cCg9L
	V4=; b=aRE9NV6rd8rdc8QRq3zuFTMLYrjX/stgrxhiuwjkLI224TK5ZHqS48o80
	HXGgn5VBr87xoKwHLng7FK2tJ1v99+Wrs5FdnnS6Zlh6XjIo8MjRvwrr4kCG2Jat
	4ul/HBxzP1SVUCqSt43JDaq+IUyF4GXmg0DQ0BY6UWEAKMWn0ID/tdB9geGmLair
	TqubI7HwnsPhvtU9NymhfVeHTPHaJ3o19Ll77QXbYCU+QRv92+keI7/Df3leAIBJ
	QCYE9eM2RgNDM/8JkOqLCA6Bw0mtbMZKk4/HRYOupqmuHmc3RVEkk0Q7Pnm5Jkzh
	SzkllpV3nNumrQynFcswjY3GN94SQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020140.outbound.protection.outlook.com [52.101.201.140])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4frrt9g2gf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 02:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXrC4UqTpdtDwAODl1w1ko8AjtIWbXBXuGRuhJNN6tqVhUUqyqa/ROUZm+EEuCDwklH/Ib+9oBO6pbf3rvnksSCMQo+/SjTglvRCroVpLnwDUkZh91nrn1RkN/jHLFrM5aVEOWyux3zu27O0ydFFgwPtpUDaeiy9AwZjPzQMDRD27NTztzop4yTqwxkrezWMbM6O1KC4ocB2ZNaK6dqRlmuwmOocY8XiQREpJLThtm84R9mGpnggyOBSpr3DkbOOlyw5eRBXeFg8uYrTowOVwUvc9Suk8HRdhDAmJuBpndXGyVLggELwXZKVkgmTrH8acLUacr3MMATl0JjtHkSMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43m1k8CtLU4o9/62AmIm7vcfO1VgHTpynnj3cCg9LV4=;
 b=InXeh2OTUs1j24VDF9JMyD8W2Lvn2W4CqvNdnTH51Z3xr78wBTqI0R0PuNOUmdz+iw2jHR+Zo8t8c5oPi7dda/fCdiKXN8ADG+xMy0j1CJnp0GNHIMsenRnM22B69nZU3tk+PR3fSubnXqUL9hv+ow3C9Oh7ZaRu0gMXvCpwI4d0znr2ZroBfnn6MzNsmF+V8bFfu3bdqeszzxuzxgJygX1+XGDabEH8deZAvO19wOWbmbkrCXNYPIQj9IZ6ziSRMPfC0vUZkAbTAYe6LRTBn1VLeTuqnzC50DHSfxoWpy4dZnJUaYdNWvAd7g1hI7DNAzSRfdjxNeuJ6SxbJhG/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43m1k8CtLU4o9/62AmIm7vcfO1VgHTpynnj3cCg9LV4=;
 b=Bl/QknQM+qfhzOU5ilBp1elOj13VVV8fnq52xSvnyWEZygzOLocqVTrkNxv11UGl9ESN55tArJsSX2mjuqcMPuV7XuUu46o1FaU8Zr5Ka1hvxznXN0X+UE93N4IcnyHmsmT0ilPNjVqDeVW5CeLzgnXuCZIRgt8ODV8hwtSsmp905VfprFgQP1Wfw3msaBe+sNjvAPdM6G/BaKJHGpuVXqimepvlqV8QwLrGBSBa9bRYv0WAGL6vedZakwuclndQLbsM1k7OrhV9KLJX/FQ3uig9tfvBDfNBQ3YNU4Uy2uQBM/V6WC7KcmheqEip5lUMBMNbNY0B2Ea9kl8lLmXCPQ==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:51:35 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:51:35 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Cornelia Huck <cohuck@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: kvm@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: [PATCH 1/2] Add HvExtCallQueryCapabilities
Date: Fri, 31 Jul 2026 09:51:11 +0000
Message-ID: <20260731095112.2975175-2-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731095112.2975175-1-flosch@nutanix.com>
References: <20260731095112.2975175-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CO6PR02MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd95ae6-cf90-42cd-758a-08deeee94ee6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+Rj7L0nUevUq2/Ch1dotYgUBVAr339BkoCNrtJNDtL3wW0hVEsVccQT3KQvwKwk31B4HPcJNthSm/nPjWrGvkBshJRaCxbYNAi/VpblYJ8c5eqpW/71VWjPt0nMMOvc4/NndwCpEKTMctqZ+eWEW34vshgTg+f7Hoh/aKpvP19ggoCSC7FZkUvkeDUq0zV03geHDjLZL1J1tsyU154r8MPBkZhth0Dn5QQLuOF343nqoy8Bjh3Um0TSFePY9nVLjc1/lUTCiya3iqMJimwHSzKVui9AXPA1o0aKikCI7pBKFYLMu5yTx+vTxlQADoIIQb2Eskr44EAamCe9wuRgX/6lhMZ7VQjQ3J7TfZSf3UaKG5ho9Dk8KgAReuIR0rou+HDisqScvfifMtjApmQCna7udHFt8UBiq9hz2vR+gtlu+k/o+sUToxkiIUPJ2haIQ+f34SABJ4v4jZRNEga3Qu5LGGonwYXAh35Y4u3X9byY3e3X2lKO5k7bcXUFdYkqJVg4DZpnGTuVCnlvz4MAdCUOlfQzWk/lLLaBnRyKd/ZqDoILM6aXHaiWI3A4KElLTSXpcKBKwQBLU9NpgoON2RLp1Vpl7/Llwr0D325nJjVLIH3ZCJjqIDfHQhWa0hGtEXwDZs7ik8imerpYSTRIGs3C6EL0k1gVSP/GbB8Pp0mYdy5xbMMFgSExYwJcCKUhbSGL7gJP/J+i2NycuuwAUxnKTZSiHbTk8bAfu2O02wmQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eW9KOXf25OV2XXn9WdkzNksAffBUD9GjMqComjVMRIkwmC4ibo274/ejNGCZ?=
 =?us-ascii?Q?IPGM/x775XiaciesJ0M16XxYHQjar3kanmt3EjlZ4tkmDWjpFOrV8WSVAujL?=
 =?us-ascii?Q?Rfw78NdttvXj/yWdnyrnfbjOfqcD/VTbdCmJ6nDH+NH2PxkZJh/umEo6GyRd?=
 =?us-ascii?Q?0FRVdtlca80sND3INgjnUanQz/WBtuudRHB5F78tTi2JvYiabibMY7sk3/QI?=
 =?us-ascii?Q?jv0wXP/8CdiWTAI3C7vEL3p1/6S/a3DTVAkMBZFQEoNrWJhoq9FjGizCzYag?=
 =?us-ascii?Q?7TrGmzY7hN6DkcsTSsLJ1LuTardzyCoLokvVsDZe0bLTwnjEH7ZxRIhowFSu?=
 =?us-ascii?Q?j9dr2fEKHCcJnuqBMX/aqXyaw/rC3XGC0X35u7dpEQX58nq6rmPSKRSKWgFg?=
 =?us-ascii?Q?6K0QmiSUl1KVPzyUFtNMxGWLTVkx3ftXhDeRqqdyS+vsckhMJkx4GdBFpyOj?=
 =?us-ascii?Q?odCSKPKPSC5VvhJ7sOZauhGcQGoOgYpPHNhh4gXSQgbeakV6ButLRUIdA6GT?=
 =?us-ascii?Q?005dlDaTx0ht9ePCmw3y4SsOJbrvsmf4OJlMjFozQ4EeHq+yYYXVWSyPCWWO?=
 =?us-ascii?Q?RvrMustDOtV5wscBaFYQesI1RFbq14W6sMnObn6ryFY4tlC0JNoQa7tq/G/p?=
 =?us-ascii?Q?EST1hN+ZC8osAUvfOsDIUOQadiUcfjdfxHrXFx0qwfQzLFd8yEtD7+4HkOel?=
 =?us-ascii?Q?7rr1tEhK453OaYtlskqpP4mKO7gxi2sZcO+XURfwRKLfDNPjqHlSzKtkQ/zI?=
 =?us-ascii?Q?wGyG5SqeRlZrlgAY4zqVJFTnrTIFWavTJiY/sk1pc44/D/XNMwCGVJAK0Vr3?=
 =?us-ascii?Q?L03gqzh2qUb9s9FlPHDn2BEcWos+y8/Pdyw5QRifoUfCEMXfhi7rZRwZp5Nc?=
 =?us-ascii?Q?xwXZGf7ykgx02JZDGPrds5Mmj9H0Rfwbb3WGT4clZ+HpnzRxosbD8PzldO/I?=
 =?us-ascii?Q?SncFuXP0YkGYxMv0FN1yjeyKddipe9J1sGz0TH53yjSC3ZyYzVLuRwr/tvaB?=
 =?us-ascii?Q?oKYpXoUL51M1pdO3xgu85bokgSm910MCoK0p0HNkCbuSqY2E9xtxxsVPv+dk?=
 =?us-ascii?Q?LAcWVclFxfY4l8GFsBClMUNfBVVX+sf+MLnOfACaomIEwwhWOa0qSh1iBWkd?=
 =?us-ascii?Q?VVIFEExSHSFJg6hYFIayjKmHMGlKmf5aWiiaNq6izrD31mco7vsMExAnMULE?=
 =?us-ascii?Q?IG91YuNfv/rFCXlo0Dn7Dwz03EH9RDowtWro6zZlJEjYLWKtFF24GaFHd/OO?=
 =?us-ascii?Q?ozHLsAuX59M4o7Fm+N+sNBQhg7J6b8fB49aSZWihiWQ580LdaqQKJ7np2hgz?=
 =?us-ascii?Q?i7lpY/RnLzxVJPA/RgCEIDcc5h0ufCloQmesz+ox4het/+z4WGY7gTzLwDUI?=
 =?us-ascii?Q?gPR/AbyEOk/J2ZP6J8uzdjSklKR0vDVbvkMhN8EwVmKF96jkOjiZnpERrASO?=
 =?us-ascii?Q?8ZIZp9hDqo4380tuwRdeUCPgZEsnmIWk1FplmcWNQSuRclM4a/pC9S2eYSrH?=
 =?us-ascii?Q?fSrPp/CIgVrJ8aYO8om8DU97YMbHg+sa6UdmePiBE5Hc8PZQM+1YmbCU51Bm?=
 =?us-ascii?Q?YjKcQhexTQy5PYKwkOZfM2BLqFG2pgOJdefOifL7aB3e1mCF6k5lR+o2U6vM?=
 =?us-ascii?Q?vADQaXi7G9+TqiYQ0As6lDIs2KnepJq+fLOAt8eXMJUbv9qjBU1zWfLo+hiV?=
 =?us-ascii?Q?qH/28iZ7lQqPYpiuc0P++eiQ1E6b6myfNPp2QtfwPj5hkDJjVQH27z8Fnera?=
 =?us-ascii?Q?cx5EoBsRv7qZUQdar90Q7ppktz7cJB4=3D?=
X-Exchange-RoutingPolicyChecked:
	VtQ0gc2c0YspzAdaoppIGWXtZUFbtWyM1W9IWW3dezpD1cXjIXJQTnjzb8aOG5FC/8KTwGfqrkGoK9EofHb5Cdog5tWrcCpqMf9nrnppr/gopoTnLShCJMclSxnHOcGHgpdlvBIle+X3LDBRWL6ap5Jsk7LLhk83qIEibglCAxxJJw8h3hoJyKHViuJ/WOYExB/RaFzrL/5dKtD7tlfecf3+JvPPZlescnHYFx8HwRu9OvMtta4N4lMGLT8onWHLo+TIE8aAVmJUBcKVvnPS248lNgOV43kKZDyzZDPTq2iqwjZtRDIF34kr1U9kBS9ZeopK3rfx7GLk8N0fRsVj7A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd95ae6-cf90-42cd-758a-08deeee94ee6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:51:35.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7j1MXf1bxgi34+mk+XGqxXcWzXerKNvgnSWxtXMEdzwgxmaIWorWbse5oXS3TlHgmeuxeGkv69P8Evi2MtuX+e8fUj4RuxRCPWRCblkVvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfX/NUJoHPcZb6e
 j2aWsIdYv8bJiOge+dcFChAholMmGpos/m8A+IhPtF1FnJX46cPCz2I949ikKrMVErR0dKy+eAX
 W1492dq9UKD5zpGD87k7GyPRGeWVZHw=
X-Proofpoint-ORIG-GUID: OPIGTPYG_VN8c0Uc_enTZ3HzbG0V2pIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfXxrhaN7GlFUrl
 zpiNZ/rMgYE/w0gDJnltek7BVMuhO08juHlHqQn1+yN04Fgkasz/yGiaIrBgkgFOPKHzR5Jso66
 bvDHAuFRPQFcEw3dHGHlEnkR/su50XlPtKSO539++3R9NGk8Avjq9d4a+RMBUWy93CFxvO+pYvH
 zKSrNtQQ8M6zjqE1VJfNFhDeSMKT/Jd73dglnmMjkd8+8Um2ggl8YhPRmjJrwSNaWmN5m5/lXMi
 nqrCkmgX7HcD/2IAvW0kNIjVPoLewC3zRYe4BeMp+VwBUN2LanosymsFvzwwYENzcKH4G3Rfdou
 KLXrxhpVvzG6Kp5npwSF0P39Uipf2wSR6W1FbK/eO9WlPNgR3W2TLhj6NECeuVhQRi8zlGVgeD6
 XQa1yWG6p19nGg4J/wowiWYN9o7z1yxnkCYBOk65rXAG8H7TjGgYoMrcQ0093uSrPgcXchBXyf/
 nmkJ8NVXVAfKDOZ9hsA==
X-Authority-Analysis: v=2.4 cv=N58Z0W9B c=1 sm=1 tr=0 ts=6a6c7028 cx=c_pps
 a=7xlfGB0ub5Zhz2aq4ZyXAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=C5gtayXK1LZycCbmP6EA:9
X-Proofpoint-GUID: OPIGTPYG_VN8c0Uc_enTZ3HzbG0V2pIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

On CPUID leaf 0x40000003, EBX bit 20 signals that we support
the HvExtCallQueryCapabilities hypercall. This returns a bit field which
signals which further extended hypercalls are supported (as a way to
conserve CPUID leaf bits).

We'll track such capabilities in kvm_hyperv_properties like all the
others, but they will have a ".reg" entry of 0, since they aren't
returned via CPUID and so don't have a corresponding register.

For now, we don't support any extended hypercalls, but we'll add
HvExtCallGetBootZeroedMemory in a followup patch.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 docs/system/i386/hyperv.rst      |  7 +++++++
 hw/hyperv/hyperv.c               | 28 ++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  1 +
 include/hw/hyperv/hyperv.h       |  5 +++++
 target/i386/cpu.c                |  2 ++
 target/i386/cpu.h                |  1 +
 target/i386/kvm/hyperv-proto.h   |  1 +
 target/i386/kvm/hyperv.c         |  6 ++++++
 target/i386/kvm/kvm.c            | 12 ++++++++++++
 target/i386/kvm/kvm_i386.h       |  2 ++
 10 files changed, 65 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index e1babffb0f..a1985dc418 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -259,6 +259,13 @@ Existing enlightenments
 
   Recommended: ``hv-evmcs`` (Intel)
 
+``hv-ext-query-caps``
+  Certain "extended hypercalls" are not signaled to the guest directly via
+  CPUID bits, but use a separate hypercall that returns a bitfield to signal
+  support for them. This enables this hypercall. On its own, it does not
+  provide any useful new functionality, but it's required to be enabled to use
+  any extended hypercalls.
+
 Supplementary features
 ----------------------
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 900ff80213..3dcf23ba53 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -702,6 +702,34 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
     return set_event_flag_handler(conn_id, notifier);
 }
 
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    uint64_t *supported = NULL;
+    hwaddr len;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*supported);
+    supported = cpu_physical_memory_map(outgpa, &len, 1);
+    if (!supported || len < sizeof(*supported)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    *supported = sup;
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (supported) {
+        cpu_physical_memory_unmap(supported, sizeof(*supported), 1, len);
+    }
+    return ret;
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     EventFlagHandler *handler;
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index fffc5ce342..f1d1d2eb26 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -35,6 +35,7 @@
 #define HV_POST_DEBUG_DATA                    0x0069
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
+#define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 23091301d0..e29d60f565 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -97,6 +97,11 @@ uint16_t hyperv_hcall_retreive_dbg_data(uint64_t ingpa, uint64_t outgpa,
  */
 uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_QUERY_CAPABILITIES hypercall.
+ */
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..ed9773ac9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10768,6 +10768,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_EXT, 0),
     DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-ext-query-caps", X86CPU, hyperv_features,
+                      HYPERV_FEAT_EXT_CALLS, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..6737340766 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1480,6 +1480,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_XMM_INPUT           18
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+#define HYPERV_FEAT_EXT_CALLS           21
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..4eb2955ac5 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -46,6 +46,7 @@
  */
 #define HV_POST_MESSAGES             (1u << 4)
 #define HV_SIGNAL_EVENTS             (1u << 5)
+#define HV_ENABLE_EXT_HYPERCALLS     (1u << 20)
 
 /*
  * HV_CPUID_FEATURES.EDX bits
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 420c76b5ff..807acaf6b1 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -17,6 +17,7 @@
 #include "hyperv.h"
 #include "hw/hyperv/hyperv.h"
 #include "hyperv-proto.h"
+#include "kvm_i386.h"
 
 int hyperv_x86_synic_add(X86CPU *cpu)
 {
@@ -117,6 +118,11 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             exit->u.hcall.result =
                 hyperv_hcall_reset_dbg_session(out_param);
             break;
+        case HV_EXT_CALL_QUERY_CAPABILITIES:
+            exit->u.hcall.result =
+                hyperv_ext_hcall_query_caps(hv_build_ext_call_caps(CPU(cpu)),
+                                            out_param, fast);
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c..bc1e44c33e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1137,6 +1137,13 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_VAPIC)
     },
+    [HYPERV_FEAT_EXT_CALLS] = {
+        .desc = "query availability of extended hypercalls (hv-ext-query-caps)",
+        .flags = {
+            {.func = HV_CPUID_FEATURES, .reg = R_EBX,
+             .bits = HV_ENABLE_EXT_HYPERCALLS}
+        }
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
@@ -1434,6 +1441,11 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
     return r;
 }
 
+uint64_t hv_build_ext_call_caps(CPUState *cs)
+{
+    return hv_build_cpuid_leaf(cs, HV_EXT_CALL_QUERY_CAPABILITIES, 0);
+}
+
 /*
  * Expand Hyper-V CPU features. In partucular, check that all the requested
  * features are supported by the host and the sanity of the configuration
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442f4..8c71ad01af 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -72,6 +72,8 @@ struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
 uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg);
 uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
+
+uint64_t hv_build_ext_call_caps(CPUState *cs);
 #endif /* CONFIG_KVM */
 
 void kvm_smm_cpu_address_space_init(X86CPU *cpu);
-- 
2.47.3


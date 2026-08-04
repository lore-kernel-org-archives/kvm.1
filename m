Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC81624D5
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835133; cv=fail; b=etG/mB7ufEQiJusEInw66jPG61dh2nQP4GWpID3RIMM9/9RBpx1MmtR2xih0mIMIRsuIhNz4imuoV+iGKS+woLWGqzgw69yJNHtU0T9/y8XfHove3EZTrAPnc/5JY56LS+KUyHhGMWF6taISmc6HYRA27oBMlzB2OFHBqCiCZEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835133; c=relaxed/simple;
	bh=znBu38FbbiOjlnKLr0iNHUOqkJQPsx3cS1ptiTrN5ak=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q30/iIfG+pMffdVjL9P9kFzOXtu3025DGXSHrueJpxCMUbuT639AgonxoPRWrx7mRBFnMqYpiIkZvoSu7hP2uvo3juOLgikkm5oQ5lLVxZfQo9VEbQzvHAVGkVdY8Vzv6kIBSIVh8ngT0of2TN/J64NBi5mzQQE2qdeFb4H5ijA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=S21y/xpC; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VlTqcXwb; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="S21y/xpC";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VlTqcXwb"
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748ERmp4137282;
	Tue, 4 Aug 2026 02:18:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=JpG0PAO1Xl/hH
	jo/kmcHMGSIbcHA3nn1WOY3iAz3NrA=; b=S21y/xpCe8H1AvLrP7rvvb6ArJcqY
	NYDRLMAccjs/V1nT9omCuT0yERlrzIFWX0J9FIBJgMdd5/1+rNaOfBixowTJYCv8
	0501G0nHCDB6kZV+N/jb/kZqhYYnHEID5MMDTNsCpnPjzctJC6zAaVVUSHJ+Luuo
	I+98dlT/yaKjPhT9CiLB8YR/Ap8d8viHqrA7qQK7WgXLkfot9NOEgvahHwfw8uZ5
	FKxRGbnNiPn+8qz9W1VqE9gT8r5I83A3KBCjy+GZRiAb+D02wESGdw9Ww2UBbVyL
	murB0OkTJVEebMkgDsJLSyjmfOeP3XfHS2R2sFriVN6GpWELF88icGpgQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021118.outbound.protection.outlook.com [52.101.62.118])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fscq6eewu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 02:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7RcOHdct2DMIV0dcrCnfUPcJFai6ZRce0Hy2z3AiovTvsEStD3HgXtMIeT4j56YV6TOd/QqLGXadvM5Vq22Xzl3v3FhxISmTic2q8o5z3inNEqgHjUHKAio+rklapkRofuRfuD+WgDrogcJ2pRGJ1PdHIADio64XiedLPEGvWvFeZf0D0ANX1rKZvki5xMfzYP+DPCO0ZPa6mtRiFaFMVjywyWhJiFG8NtREJwbSftF/84p82n6MRE7bo7IlOpq7zaMiYzpZQSS4ZK2UKmRSNG6hoszt6ZVQIDYdXBHYhwIW6+HjrMUdF4reaO35e4y6jC2GAvkAtUJMjseCYMyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpG0PAO1Xl/hHjo/kmcHMGSIbcHA3nn1WOY3iAz3NrA=;
 b=zSBOElR7MKawXCu9CpSz1I3kG7/4xzmhGAP3RkgVESHS9crslLELxUNRyk62AdV2FSVivXETerHqjmCtEN+VovTB/iuqCS1EV2J5TPff9cyXWPZLWOsJhLqQ1Q8ePXncVfEQUThXWn57/UYqEFkJH3mqHwH5J+P906SPukh82HNbiZxbh3K/uEx/bzbkMUElrdpDkIvMM8YbPVN4wmegn2b2XCmQ05M9JQUn22mzYfLBiMRBmWsi17O3J5mdAUD3dDXfr4hlw143UWI3btdRFvxxWFthZTg8RVPFN7UrcJ46QXw2irvbmGrx6r/Nnrui8FRFlnVMNK3Y+IxVRyauqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpG0PAO1Xl/hHjo/kmcHMGSIbcHA3nn1WOY3iAz3NrA=;
 b=VlTqcXwbIJodZiSp4siUkw2BBXVgVLxNeuOMUPm0MjJLXgZQooXdyf9yMCQO0XDj0B/OalwKjp0AAaSyFwWWiKhEknIP5G7ymhP295Mdp0PTg4C8BIZHjnVKRrdxfW9cl2I42Vax/gNU5ybo4xBkS1ldWLEHpH5fOM09sRkrQflrxpwXBPuivi1ghtE6Zi2lbN8qDOT/5nsGwcdboreivQjiETAMuXwae5Vwy0Ad6KPPEOkmRK3NfyW9FCspxWrEUq0CjUcecd8o7hKaA8UVL7nIBHG+BBSrzCC90q9GU65wSd0wyGyDisdOjdbBgCWyxj1GGvjW6zkM2MjmYsQW7Q==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA3PR02MB10952.namprd02.prod.outlook.com (2603:10b6:806:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:18:39 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 09:18:39 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
        mtosatti@redhat.com, kvm@vger.kernel.org, mark.caveayland@nutanix.com,
        shaju.abraham@nutanix.com, prerna.saxena@nutanix.com,
        Khushit Shah <khushit.shah@nutanix.com>
Subject: [PATCH v3] hw/i386: Configure proper KVM Suppress EOI Broadcast behavior under split irqchip
Date: Tue,  4 Aug 2026 09:18:27 +0000
Message-ID: <20260804091827.3203086-1-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::31) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|SA3PR02MB10952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf2d24c-8b5c-4c50-5063-08def2095efc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Tf8dLUbvuJ4zDIwzs6GEGWt6fksUdT6kWd7etfENrAclg2WF5HGahSNGJYXYYXkB5bSOGVpx7N6oEUVcsrXcUOdkPvvaqWBg2aAeBymd8wDbJDKm22Uv8Zu3kIjuAjHnVZNbJ6gcphcaBgpsnN/LdxbwI1mWD1XuUrRmtYi8Ln/ugm24+swIyzPFk/UWZmjOxQ1jCkMuKjddST+80tY1VD05W+OuFhiO7Ts5VmlUpdVVJjdhTdYkETI1MBI8BgyIf3YaZesVnS5wsd+PDTt8lHhfFpBqcJMxyFHbwVDoXc2rmqyyEriK8+kqbJfy3WHNdth3i1XCDuLVaQ6q/OQjTwwbYk2WdTsdQBTDkzs24b+Iea9GKRxSbm054xG1vR8NiJCA2CJbzoCNsfIBNDIlUeZzYKD0sHZQPOndgVais/pt/SbO47Fd9Z/EuQEHcB7vO0Ga9LYuNzHX/DGX05Ze4jeoJ3REoLRSFrkyUaoR3Sh00bjJvOiy/VYM2mOn8vLFISESRbhFx4wdLS3N7FKMBz0cMedwvjN+6ur/WIzPkPLWZPybx1wqFBY8xAm/3/UBW0rhq+ss9hYsOWdAUDlhUeGA97mMHr2AK9eOD1UbNgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4g82bqvKK0DNhQwZPb2o6QGWmCy4NP2lYimgNW0zbYx5B62vRV9wsf68dgMW?=
 =?us-ascii?Q?WIEztNf6IE8s8EnH9tOYlCPqLUJw0OppN+KhdJ+k82C7CeUa9jkqoSmfEGQx?=
 =?us-ascii?Q?csZnOSJ+1ZDoJ7+rB2K0jrJ2O/csdF7HrGocxKl2e0HyOnHhy1npzPF1DtWm?=
 =?us-ascii?Q?Z4Ls2ND0c+6uaM0DvKvl/hZZRovYpDY8n3WE7WyUsTg/Dfj+K9fM2JAAKtSD?=
 =?us-ascii?Q?oWcuPkEw3cBHHEJHrtN7MHy1fV9SNrOl1H3VAdxoEoIsNXVeITl+bxffh80b?=
 =?us-ascii?Q?W6fiElyR4WX7oCg49KIL8275ZgzP/q7eZ+flE6zQTx8xDCPVNr6KT0p5cCJp?=
 =?us-ascii?Q?Y9QQD+WB8qC/wV9Ue5viTqAd0i+xz4TDq28gVx+5+jdW8Rq/mT6IXxyJc1aS?=
 =?us-ascii?Q?1NKpBffnJCQfBmnNcAJbjKiyAGZN61hIQQFlb8upgN0m8ajoiYqL8tZMzPS0?=
 =?us-ascii?Q?Gtm3UpC25LK8MkZ1Lt/cP2QBa0FrJFpRkuHD5c1ljzMjKTH7i5FK2glGsSqJ?=
 =?us-ascii?Q?Sr3sJov3Ykjjk+UYztBdlbty8FSjDH7xompSmjPFADLurJ+6vLJi8l6bIpZX?=
 =?us-ascii?Q?t2gWJBXpcxTicWLI/nmwDqBEyTP57qnGRqNImFhhgjezDair400C4AioH4zc?=
 =?us-ascii?Q?7J8MScvyQpyF5DkPRjJ8hZdhDKUOyfTDTU1Gs6yykiOJH8HFKehGZ09vWR6h?=
 =?us-ascii?Q?/WWbvp0pKkZWfCTLbO23jdNC52JNCjshH4lr5v77OVnXpG1xk0Qz6TB8nwUG?=
 =?us-ascii?Q?6q2fUDZ6bHsBD5eOWyOhdT8EboSMfWpDT57TcPTYOS57EP9Bhdql+m0yIa06?=
 =?us-ascii?Q?3e82Y/tYLAr5Lpx+yb8/BCKSvPL4pBsmbCBqTtoDy2r9qwu8sJyrLiznq7Mm?=
 =?us-ascii?Q?YUJDk9Uv7CKvYHyaRlAOdrHJPq8+ckYDyEPE3jETFMVsPXD3TO9oi/5Rv5OC?=
 =?us-ascii?Q?PwmIR1aLH0UncucEo5rLtT41FktsCGFLfvNppuwffRdNEVWs0AhPSnsb8mit?=
 =?us-ascii?Q?eHNzad/lcHGACKmQwhNiXnVfHhdzA2mh1GC3/2aZKDWyDqDRpobTdE2//1/k?=
 =?us-ascii?Q?cTrc+VgqY4wZRcAEv81NI/nH0qbDajtvwBPGy1k4pjeI3YVGCXKUVmG0RZ6E?=
 =?us-ascii?Q?xnsA+QMbGtfUikr/AHVaAE0q6+WbSo5A1UQ1becIFZ6HmIQFcFkDqFq8atDe?=
 =?us-ascii?Q?7jWQZr4OPMIJ/IpUBXF9h60NAxuRVVhC9ArvXvoiHuJyKIwUgQCzGLj7+6Qq?=
 =?us-ascii?Q?pvVuWmfQQM+uEj0YHzKQXNLG61aB2ql9rCZOgSZDxwtg+OagLZuURZOTx5dO?=
 =?us-ascii?Q?lnOLTcoVm6RxhYLU0tcrFSzlv1PrHRvffpZOmMGPPQgLaeG93PZivsZ/YfFO?=
 =?us-ascii?Q?YTndIB6QO5oYrVeLhBUcG45/Bxm2TF2WL2tmWamSmi2BmtKRdM/FZ9LpwDq5?=
 =?us-ascii?Q?jNJotNC8pn42fYPx9yk/OXrOz8f62ImL14rjj7NrLQCvxGalwMkHy7RiijiD?=
 =?us-ascii?Q?+ZBFQ5I7eXTeqFdcDh50AOTjtv+lp8NjvYOXSNSG2u5nnYUT4Y3VS+S61/pY?=
 =?us-ascii?Q?iB/RF8+QGJhWFLAlsMVETR6l2iZTqYitiwfSVT26RpytXnKY69ExT1ltH+6s?=
 =?us-ascii?Q?hZCN4oyKLSYsNe68+mvWfy33cRhh+1ijhgWcB3rfMnk0jVR7Ph3PQSR8eiGw?=
 =?us-ascii?Q?6Pt4xWKrMjpclPB5o0flY4qDYdxbJUGJQZKi5Y+Yc5o8dwLgnUb30a0WTIHN?=
 =?us-ascii?Q?N2QlKvMHTXt7xnbKCHf/4JjXn6/qpuo=3D?=
X-Exchange-RoutingPolicyChecked:
	hcvl6WnV0iTGzhgttgughtXA+KsFxQI480Xo2Hs//wGFyUsIJ9mfpXc07wScJCItA1zmvJZ31ZZ7pY6Wja3r8DvOrjQXC4y4UDQqmOGhgMeinkxJU6VZ/11kcyT735g8gDNzug8hjtuQS2LyeALPsErVXPr9Ja2NL4olUkHBzOefMU5s5Lw001iZ7hM8owISObdrlhjQVcWZbzsuTWp+jVPiySb0m+C5xyWvwNuRFWyU4IpsiIsmH6NmSH3k7UHMNSaS+gHK2MFxyPEpYmmPtZEXSV43BkcY4rt9TGkq7+ihRt5NRjJ8Nq1w66eltSf2FHOBLwqO6tWKP+8deQYnAg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf2d24c-8b5c-4c50-5063-08def2095efc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:18:39.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOpEB8tLBLHUPnaaQdOgbfd3+GYDF/TUdG5xksIH4yGoT7gJv7SThpq1AMOpxoZAUPruTho9SSMTHOPSLNr7rgx4yNJPcoc4E0RVeKZBjfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10952
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX1cJzHmOEhBdV
 oAFBFGRpEweq7UdMg2bN/NbSaDLKrxL5gRmUXktOc2wtgVBmFBid/C/HC2F6RvfkvOC3wAWaEo5
 p0ULtcxG6NzPzRx+XarshUzl/Smk+nIyaR1rqAB7Nor8KisXSLemwzokZXpbOnSUY4sPYk1tBJH
 ez49NO/w3PKOwgiKp1HnUTPa8Y5wk7dqgJjBOa8tO/nrqgFVFWLJXFIx3+eiRr39q6YebQRCizz
 xyyExQbdqcexf07JBpZO2UNx12K93mQryiq+sWi4lUTMBj+tNrcbhTjIJWE/c2uIMGHh3drxw5H
 9jG5mMLNfORiTsOX0RYRiolO/ILXCQgvsHiyHnodAnm/GPfRlusPynAxFW9v+diOiJeNq4BGvuC
 GznFB6MZ+18G2MIlZEoPU2wNMFnqBhFH1PltOQZRWm6fi4+Lt0Y5ufMDMQHZ96szV1t2MJzSKaO
 /WxEI/o8oI3Rvmy5J8w==
X-Authority-Analysis: v=2.4 cv=MexcfZ/f c=1 sm=1 tr=0 ts=6a71ae72 cx=c_pps
 a=faNChB6ooTmYohDsr5IHEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=0SlfaxJ1cKGaSeePZSIA:9
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfXxvNzLo3d3EnD
 UbKr7sWRPyGtxxxqld83+nhHdNMLNe8C0BVMqyzjvAuyQcqHIW7iCr6BKYELHrEXHPwgfcj5oPf
 ZjNEUYmucvlDmnyZ0Tobq0EunvfQazM=
X-Proofpoint-ORIG-GUID: vJ9Ib337yDD1CvTrRttbbkhA1Pn7-2YM
X-Proofpoint-GUID: vJ9Ib337yDD1CvTrRttbbkhA1Pn7-2YM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Historically, under split irqchip, KVM advertised Suppress EOI Broadcast
(SEOIB) support to the guest, but ignored the guest's decision and
continued broadcasting Local APIC EOIs to the userspace I/O APIC. This was
fixed in kernel commit 6517dfbcc918 ("KVM: x86: Add x2APIC "features" to
control EOI broadcast suppression") by introducing two x2APIC flags:
- KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST: Advertise Suppress EOI
  Broadcast support and honor the guest decision.
- KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST: Do not advertise Suppress
  EOI Broadcast support.

For compatibility, KVM continues to follow the quirky behavior by default
unless any of the above two flags are passed.

This patch fixes the behavior by dynamically configuring KVM based on the
userspace I/O APIC version. If the I/O APIC version is 0x20 (which implements
the EOI register used for directed EOI), enable proper Suppress EOI Broadcast
support by passing KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST. Otherwise, if
the I/O APIC version is 0x11, disable Suppress EOI Broadcast support by
passing KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST.

The fix is required because certain guests (for e.g. Windows 2022 with CG)
fails to boot or exhibits extremely slow boot on legacy KVM behavior.

Changing between the legacy quirky behavior and the ENABLE behavior does
not cause any guest-visible state change; it only affects KVM's internal
behavior. However, changing between the legacy quirky behavior and the
DISABLE behavior does result in a guest-visible change.

Hence, to maintain live migration compatibility, introduce a new x86 machine
property `quirked-seoib`. When enabled, this property leaves the legacy KVM
behavior in place and is enabled by default for PC and Q35 machine types
version 11.0 and older.

Users can explicitly override this default by passing
`-machine quirked-seoib=on` (to force the legacy quirky behavior on newer
machine types) or `-machine quirked-seoib=off` (to enforce the fix on
older machine types).

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
Note:
Changes from v2:
- Added a new x86 machine property `quirked-seoib` to control the SEOIB
  behavior.
  v2: https://patchew.org/QEMU/20260309054243.440453-1-khushit.shah@nutanix.com/
- This relies on the KVM flags introduced in Linux kernel commit
  6517dfbcc918 ("KVM: x86: Add x2APIC "features" to control EOI
  broadcast suppression"), which landed in v6.18+. For hosts running
  older kernels where this kernel patch is not present, QEMU will
  gracefully exit with a hint to use `-machine quirked-seoib=on`.

- I realise this is very late for 11.1 so will probably need to default
  quirked mode on 11.1 also. Sending the patch anyway for now.
---
 hw/i386/pc_piix.c          |  3 +++
 hw/i386/pc_q35.c           |  3 +++
 hw/i386/x86-common.c       | 38 ++++++++++++++++++++++++++++++++++++++
 hw/i386/x86.c              | 21 +++++++++++++++++++++
 include/hw/i386/x86.h      | 12 ++++++++++++
 target/i386/kvm/kvm.c      | 24 ++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h |  1 +
 7 files changed, 102 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..f8636d0b1a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -437,9 +437,12 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
 
 static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
+
     pc_i440fx_machine_11_1_options(m);
     compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
     compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+    x86mc->quirked_seoib = true;
 }
 
 DEFINE_I440FX_MACHINE(11, 0);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f..3f045f3582 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -392,9 +392,12 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
 
 static void pc_q35_machine_11_0_options(MachineClass *m)
 {
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
+
     pc_q35_machine_11_1_options(m);
     compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
     compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+    x86mc->quirked_seoib = true;
 }
 
 DEFINE_Q35_MACHINE(11, 0);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 8f9419e7d3..4f34360b87 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -66,6 +66,24 @@ out:
     object_unref(cpu);
 }
 
+static bool x86_ioapic_has_eoi_reg(void)
+{
+    Object *obj;
+    uint64_t version;
+
+    /*
+     * The I/O APIC device does not exist yet, as x86_cpus_init() runs
+     * before ioapic_init_gsi(). Hence, use a throwaway instance to check
+     * I/O APIC version.
+     */
+    obj = object_new(TYPE_IOAPIC);
+    version = object_property_get_uint(obj, "version", &error_abort);
+    object_unref(obj);
+
+    /* Only version 0x20 implements the EOI register used for directed EOI. */
+    return version == 0x20;
+}
+
 void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 {
     int i;
@@ -109,6 +127,26 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
         apic_set_max_apic_id(x86ms->apic_id_limit);
     }
 
+    /*
+     * Under split irqchip KVM advertises x2APIC Suppress EOI Broadcast to
+     * the guest but historically ignored the guest's request and kept
+     * broadcasting LAPIC EOIs to the userspace IOAPIC. For compatibility,
+     * KVM still follows legacy behavior by default.
+     * Based on the I/O APIC version, use proper x2APIC Suppress EOI
+     * Broadcast flags (ENABLE or DISABLE) to fix KVM behavior.
+     * This needs to happen before any vCPUs are created.
+     */
+    if (kvm_enabled() && kvm_irqchip_is_split() && !x86ms->quirked_seoib) {
+        Error *local_err = NULL;
+
+        if (!kvm_configure_x2apic_seoib(x86_ioapic_has_eoi_reg(), &local_err)) {
+            error_append_hint(&local_err, "Use -machine %s=on to keep the "
+                              "legacy behaviour.\n", X86_MACHINE_QUIRKED_SEOIB);
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dc7f0d56b0..75cc3eb3e3 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -205,6 +205,20 @@ static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
 }
 
+static bool x86_machine_get_quirked_seoib(Object *obj, Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    return x86ms->quirked_seoib;
+}
+
+static void x86_machine_set_quirked_seoib(Object *obj, bool value, Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    x86ms->quirked_seoib = value;
+}
+
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
 {
     if (x86ms->acpi == ON_OFF_AUTO_OFF) {
@@ -370,6 +384,7 @@ static void x86_machine_initfn(Object *obj)
     x86ms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     x86ms->bus_lock_ratelimit = 0;
     x86ms->above_4g_mem_start = 4 * GiB;
+    x86ms->quirked_seoib = X86_MACHINE_GET_CLASS(obj)->quirked_seoib;
 }
 
 static void x86_machine_finalize(Object *obj)
@@ -445,6 +460,12 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "sgx-epc",
         "SGX EPC device");
+
+    object_class_property_add_bool(oc, X86_MACHINE_QUIRKED_SEOIB,
+                                   x86_machine_get_quirked_seoib,
+                                   x86_machine_set_quirked_seoib);
+    object_class_property_set_description(oc, X86_MACHINE_QUIRKED_SEOIB,
+        "Leave KVM's Suppress EOI Broadcast quirky behavior in place");
 }
 
 static const TypeInfo x86_machine_info = {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71fe6b5e12..bf3075d6f8 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -32,6 +32,14 @@ struct X86MachineClass {
 
     /* CPU and apic information: */
     bool apic_xrupt_override;
+
+    /*
+     * Leave KVM's Suppress EOI Broadcast quirk in place rather than
+     * configuring proper behaviour from the userspace IOAPIC version.
+     *
+     * Only applicable under split-irqchip.
+     */
+    bool quirked_seoib;
 };
 
 struct X86MachineState {
@@ -93,6 +101,9 @@ struct X86MachineState {
     uint64_t bus_lock_ratelimit;
 
     IgvmCfg *igvm;
+
+    /* Defaults from X86MachineClass, overridable by the user. */
+    bool quirked_seoib;
 };
 
 #define X86_MACHINE_SMM              "smm"
@@ -102,6 +113,7 @@ struct X86MachineState {
 #define X86_MACHINE_OEM_ID           "x-oem-id"
 #define X86_MACHINE_OEM_TABLE_ID     "x-oem-table-id"
 #define X86_MACHINE_BUS_LOCK_RATELIMIT  "bus-lock-ratelimit"
+#define X86_MACHINE_QUIRKED_SEOIB    "quirked-seoib"
 
 #define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
 OBJECT_DECLARE_TYPE(X86MachineState, X86MachineClass, X86_MACHINE)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c..c9348d69e7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -307,6 +307,30 @@ bool kvm_enable_x2apic(void)
              has_x2apic_api);
 }
 
+bool kvm_configure_x2apic_seoib(bool enable, Error **errp)
+{
+    KVMState *s = KVM_STATE(current_accel());
+    uint64_t flag = enable ? KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST
+                           : KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST;
+    int supported, ret;
+
+    supported = kvm_vm_check_extension(s, KVM_CAP_X2APIC_API);
+    if (!(supported & flag)) {
+        error_setg(errp, "KVM does not have x2APIC Suppress EOI Broadcast "
+                   "flags");
+        return false;
+    }
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flag);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "failed to configure x2APIC Suppress "
+                         "EOI Broadcast flags");
+        return false;
+    }
+
+    return true;
+}
+
 bool kvm_hv_vpindex_settable(void)
 {
     return hv_vpindex_settable;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442f4..1e154e536b 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -25,6 +25,7 @@
 
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
+bool kvm_configure_x2apic_seoib(bool enable, Error **errp);
 bool kvm_hv_vpindex_settable(void);
 bool kvm_enable_hypercall(uint64_t enable_mask);
 
-- 
2.39.3


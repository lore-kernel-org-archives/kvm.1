Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D1281530;
	Mon, 11 May 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521643; cv=fail; b=CNuSivqU8f78ih7bjFrvjyHJc5sukY0dkzlquHuDYw1XfQ8/xdyecwcaw0vt6tfvuxY3KckKLB4S/sDd8sS7lHKhHQG5Vlj2cAEt//ywrb1Yvg4QPnhcjzhtjsJ8yRUMSsoVYK+Bv6WffrdQaT4yWAH25wv28FPGwNZ2mGWq+vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521643; c=relaxed/simple;
	bh=npYMIlxW+lqG74t9q+6MoKj2Azknc/lkvLKp20AWrXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDdMUT2ToBZxi/d4YQ+hRtZ1g22PIjIJC5Nmy+fe3KIlp+3uFGx3OQ5AppnuIgQC3x6WeVY2oTiaWgVIJwnYG9WZlMoBp02hj023HCz7sjZpiR2SD4MN+6rg3rVQMJDuEes4d8ybmhUHF31+GsbtRutSh8vaWkmMX1OsHY/DcZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlAUNHin; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JKmkgNQ1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlAUNHin";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JKmkgNQ1"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BFtbte1339003;
	Mon, 11 May 2026 17:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6/8gAhQSPmr8oBA9R9qxOuD94KHFkTMnibzK8sbuZJQ=; b=
	NlAUNHinC0MdO4n/nyows6Wq/gUlJtl6KvwMmi2lSMm74C+Ck1p/oEoNiPi9GhVV
	fufUDiqARjYnZqMOwnS7exvgmk6cSZoHM9dqXEdyg8pNc/eVeI8i8k8/ilGaezGG
	rqsUp57JcumJO9C7IiLd+IuE6fQvVZLKIlq9gMy/jVo2a1Kpfp1+gJORI49cy1jY
	y6/whgP5AlN7Mg8WSUiYSv4Wr1aTfOPQ9rXM+VHqH433qN3nr6nDMjS/SrpHHa3e
	6TODKawG0DeDXRhCmS2zDKKvIUGG7jqhabRMwUYYmyH9HRCSEvY8f5f8hr6LtHmN
	NkgFRycQfw/5d8r/PQt+aA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1wfrb55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 17:47:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BHfLJv035140;
	Mon, 11 May 2026 17:47:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uc9hwbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 17:47:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTWsAfk+dnQwd+ZB95HCgEKP1hlRYwuh3v+QQw10n47jXNxbObeQ8jjhDs2ZUNLEaA4OR96S/3gGGBYnJGrfK5eqWXxXDdB2mam1F8sDN7K8oo4frf0J+Dea42BoKG7ahyHDL7sVL0johRvEnqWPJbFy2JTasjqdQSUEhgiJrJn4E3kknQ+bj1aRsSfuARUWMYkUW+4i8feJlYkicSFKr8JNgDJhfb3HVxwRdQ8Sv9IRmnjehFsq1cWv85H+0u9cLxTDVVv8ffqwTrBGoC/LznBAcqeu8+olJ+FR6nxDaNxmTg2TfNBJ6N1t81ib9auJ52pRfUSJ/z7Al/sSOUBi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/8gAhQSPmr8oBA9R9qxOuD94KHFkTMnibzK8sbuZJQ=;
 b=nQcOXcFFXQV81agMLDioq/CcTIRzx+hucPkzrsEicXKF/c5cf6TYNpqv1P0bdnJ1jrJKPtlkZrHSzjz/ImIkPZzE3KXsJ5HKNDQ04cIZaJmRK5eCgOhAjkSiZnGt64wkcbEPWI/vImYL0eTYPzIkrWeTYYC5jo6v6XeQu61Bwk3wGIbe/Lpe+GsICTwhr3c4K5DYd8jassJftEZJQ0w/9Mcq8EQmJnMgQbzO25vKC40KQQm7lVDaCHriA+7kWqKzuG//Zc8aLBg0dIt4emaKLE3ROi8h8tJPw4sL6EB/bKZpFh70ZSBKpIlFSnGy11T5XIjqr7Kzf+E87rvMv2Ia+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/8gAhQSPmr8oBA9R9qxOuD94KHFkTMnibzK8sbuZJQ=;
 b=JKmkgNQ1hJMEleVpAC68AbA9uVy5sxyavIuPRMjHQvwCCBcPLWW6hDYUHdr6/ny0bcLwOewHTbYOvfEm6RQLYjci14xElsUph7Nk7jWwhgArd4sJ0ojHBEap+AOPc9P8FUr0EGiXPLWZTkVRDhtYJ9VwRK3rM6n54KGEIAGwUwM=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:47:04 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::54d4:413b:e276:e71d]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::54d4:413b:e276:e71d%7]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 17:46:59 +0000
Message-ID: <6e4d4bfa-a8af-4318-a62d-d11f3e20d8dc@oracle.com>
Date: Mon, 11 May 2026 18:46:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: kvm: update links in the references
 section of AMD Memory Encryption
To: Ninad Naik <ninadnaik07@gmail.com>, pbonzini@redhat.com, corbet@lwn.net,
        skhan@linuxfoundation.org, seanjc@google.com, michael.roth@amd.com,
        vannapurve@google.com
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@brighamcampbell.com,
        linux-kernel-mentees@lists.linux.dev, liam.merwick@oracle.com
References: <20260511174302.811918-1-ninadnaik07@gmail.com>
From: Liam Merwick <liam.merwick@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260511174302.811918-1-ninadnaik07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 95eadbe5-297f-4ffa-7d4c-08deaf854d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YjtguwI9uvWF1aGH/wW22JYEZScqSyfR4Ps0OKVcDBiXmoxvs8rf1dC9vuCnPtSQCt29BWuyvhq6p33t4UZXTuuCsc5YziIqp6AJ9VZgzFHyTWN853MkpGeV/qKYigg4ETHyh+iX7sxPKzRkkpEpl78AbCOYSz5vfc6kQavvk9GXA7x5U145EsJKwLvhmwWcoCqtAMnkEFN2fEG3UXhqFxUt2ABt4CUI/9SJYeg4nsP+m+QXFajxSu/KLSfxV38mFL1Jm/JbN6E7aa9y9immjVX9UZWWRs/1QOMPMuAXreUALdtjDnG5fzAFoH0RtQZjH9tDcYsIFuxRbaoBCQKNVMWkCmDa5D9HqRa/Y2UpmBtlymorYY0KUzXExNa5bBj0RxSfWrKnALyNDC4l9Om7z/qo/tBz0wEvncVCf1VK/WuwupaSs/uEosrgEH1rMB2pEM+U6hd4PUjiFISxD7P/DjnJvIkmxLY5xq9f5zO/aTtoRo64aUyo0teXlKwCo7/xNa/1MRYpoWt24eSMPOJUC0zUA4BDt4ttgBXkDnI99liqB4w9qBsPPFd7itxDBCPNgBndHf56dKkdAsUTV49P5V+qmJq+AzikXIuPyYfyD0JGx7TIBAIDInrhl3GAoyxcRQCiaHteNJEFQMmpCyOCXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWRSMkdiNkZKWG11NFBmUUIrTGZwYmpSL05MdjhaUEpFUGVscW94cDFnWmg3?=
 =?utf-8?B?cStkT1NJZjFGaDFNdXZTREczMGFYMEdmeFl4NkpFREp3MlpTSkFibmJVci9i?=
 =?utf-8?B?SVZOTjAwVUxXR0IzRXhyMUhWaXZXbWl3bDFHdnlPNjljakZiV3RqNnhaUzVx?=
 =?utf-8?B?d1NrQ2xXckdKUWlVQ0JtcW13S1JrTFo3Umh6Y2wxUUU3d1hucllzeGtScjVZ?=
 =?utf-8?B?S2lSU1dqeVVSQmpWSTVFWVdlM09kNGFGS09EbnVadFlXUkhjQis3TjY4dXhH?=
 =?utf-8?B?a3ZhaERBRzNEQUduNGpYMGpmN0JiVW02N2JGMkJTVlZkYk5EaDh3T0FsOEN5?=
 =?utf-8?B?L1k3c2l0U2loRG5Bd25NVW5vVElWKyswN0FXdGxEOTlwNDRXYW4xMG9iZ0kx?=
 =?utf-8?B?T0tZUGNkOS9adU9xWVg4MGIyWHFSN0YxRUFZaFQxVU81S0R2d2IvRlFkRkNw?=
 =?utf-8?B?REE3TFg1MnZnQ2NMS2tOQVJqV2N4RTRpbDIrL0ZsdkVyQzM5MitOZ1ZwN2JP?=
 =?utf-8?B?RWp3bFlVWmROVmR1SXYySWJrTjF2U3llV2MxRVNWT1lWc1RiZkxUV09OZ3Zu?=
 =?utf-8?B?R2F3bkhrdFBiSG1FZFNFbThDRlRoeUJJUlNxbytuU3B0bWVRMm9QOHR0VWJT?=
 =?utf-8?B?K2lqbFpvUFBEbjhWWU55NkI3QlVpN3d2cG5oenIzZXNXZkFRVkUvbTdzRExS?=
 =?utf-8?B?UEREQ1Z0c2JZNlVsVmIxQVdoc0pSeGpVcWNNMTZzb1hZS1E5Q2tDS2tCakVt?=
 =?utf-8?B?OHRRUHZRczRhQkJoL2lHY1gwUktGZ1VvSGlhc1FpTUl5OWlNcDZ3dFVFNENh?=
 =?utf-8?B?WU9FWXZWV2VUTGhoWXNyYkRNM0Fva0Y2ZWpMSHIxTW9XVlZ1VldCUzZwdHVT?=
 =?utf-8?B?MGpBNGc0M2tDaEczZXBESXQrMWVpMVpRdWVhVDdnTlJPclBBZnBtNVRDempO?=
 =?utf-8?B?QnZJakJRdC85QUY4T2dnaG8wMTFPeWhKanpma2t0ZnBDSzc3aU5QMms0MHhE?=
 =?utf-8?B?emdlQU8xemwyd1plUFFpcXRsQVpESmZUWkxRRTBwOUNwL3NnU25vaXcxZElx?=
 =?utf-8?B?dXNKY2V5ZzJ3WS9LSzB2dE9zbUl5amo1WjNYaTdwQ2hzTmg4TjhxdWdyUUsz?=
 =?utf-8?B?YzFFNUJydVJmcmhYc0wvZktxa05QOEkwb1Y3ZjN4SHhKcTVxdUVkRmJxaXZO?=
 =?utf-8?B?M0laZmQvVnVrZjVoc1FSMUlvS2taM21SNFMybkNDSlBiVUx6SVMwZjk2SG5a?=
 =?utf-8?B?ZC8zV3ZIYmZJUmt0N3dkRmt0bXptNmhRTjNBZ1BXMUVhYXRBdW5FQnJuQW03?=
 =?utf-8?B?Lzl5U3JzcXp2cXltT3dtUktrVkc0SGNRZ1F1akNTb3VMeXdzbjRmYTlUY085?=
 =?utf-8?B?c250NGFPYlZLTitnQWdzMjNUODQ0cWFicHI1ejU1eGpiUi8yWGd6QWtWU3k3?=
 =?utf-8?B?UzdTdEFCVTNOUnZ4dmRxTHhta2grRkF3NXJRWThvaVBYREFNSjZrbFE3dEsw?=
 =?utf-8?B?VUxFOTd0a1l6bFM2OTE3c05xenpDb3lyTFJRZG9PVzlMZEJNSjBMeTdEK2Ex?=
 =?utf-8?B?SGhMN2FtTXR3NDJFb1JIai82MGN1MUFZNEFYVzRXQ1dlcC8xLzZmZjR1b052?=
 =?utf-8?B?Yms2ZkwyQ0ZjcFNQSm5Vd1VuRVNqZW1EYnRMZXlSSVRtcjNlMkNEZzhHSE5Z?=
 =?utf-8?B?TDJ6VlFQRGhlRGs3NW1abzRKME8zODRXejFCMHBYRkRCR3hjQmp1aEJyblJt?=
 =?utf-8?B?bDllUHlEUU9qQVB1enZDVytwUHJjc0w2TERJRmo5QnFhWUlKL21FMTduQTFX?=
 =?utf-8?B?SW1relNtSERmM3RNeVB1cy85VWk1d3ZHM0FDZUFRSDM4dmJEOXdWN0xtbDVv?=
 =?utf-8?B?Z0FtYUZFYnlCYW9Ob1BlZGlRblZiY3FvQUxhUndCWkZ4UkRGbmNRcWNwMjF5?=
 =?utf-8?B?NW85bGRmSWtldlpRc1Zxa29vYlJXcW9EYUlxTkNiOWpXRUhXYWVYSTdYTHJK?=
 =?utf-8?B?TUxwSTJoS0tsQmovN3V4RUNRY29YdGVTc0oyUWM2ZzJoSURYKzdYUktwM1Zq?=
 =?utf-8?B?ZngrbG5YM2tvSGF0WmJsdTkva2k3cHZjNlM1dTEvZUUydXFzRXdwMUJFOUVJ?=
 =?utf-8?B?ekVyS1IzTkN0ZXFuTjNXSm9EYjVqM0FPc3IwUlM4NzYxRlN1NzJnbEMyb0pW?=
 =?utf-8?B?R2xqaStNcjVYVmNQQ3NaVVk5dkhTL2VISDhZUk8yMkQ4cEdReFR0WlpHNm1Y?=
 =?utf-8?B?allHdE01K3kvUHhKV2xhZDAxZXdiRmJMcERKSC9nNUc2d3VnL3YxVTRpVnNv?=
 =?utf-8?B?bjdqT3hsZ0pIZGNHL3VRNWJBSDlqYTZuNkRlaElrcFlIOHZoVkpPZz09?=
X-Exchange-RoutingPolicyChecked:
	E6ZDa93hR9T4MG2itvRMdhl0H4jFmdSwmnMWRpHK5OrKl8nRItws6ChOSdRRnnDwc0zegZnBi71e1C6xqK7CgXbj0XxEAzvosc/5I9F520cEGJwSV5jkkDDSFi0Dz5/FZcZambQbzoLbozJEtEA2eSiPLGrN4oQ0n79TydPRNox2rbHXODD51jF3DMy3fZjHdKZYV8c04X8Ds57q6midXHnzrOJzb2+SDXn9vhJ2ro4CKEqvbsXFnW5Ej1QaWEe6sHCexE10W0c/EG0tHZX7pqSCyBPbIsFcYvxJ96p14RR2DL+NUjO14YyU/3VhhNyGO+mZr86h7MR3k5sfpj8nzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	chbi6EVOaecTkB1Twxbg/arwQzx06q3hZH71LyEudCjPNhxeW5Pke8U/w25k4UbUruCqU3HufqBeSOzKhESAxyfUn4DqKj/BlESReXQnj3Q3ztYQZzidJvq1wv9X/JMqgdi38vwXPcNAISXwdbIZtwa3Ko6p5bkMe8T7YG3dFXf2W+HDz6yUW/OB7+TvDL3YInCP6mKEI3dKdC+lCTHy2EBYYHehVGxk7T0B3wOkzcrTmM2cJ9XJfcQMzZzqIrxSBBFsb+L5ssoRbgpaHhYe+cBAkUm/btOG/c97wsUu60jKgLk7mkVAbe3opqi9SmWpJ3NYqXKHrUyP1DFJE+RuJoxjPkn/MvgBjrsCbnHyuZZzswM/awfcaqpRyv3Q8wt2Qlqu+vWqSmwpvllbut7rUanVI9yqmqwziGPkXEJs39Xq/on4VCxY5I8dEoILpGQoGkXNEIVqxSPC44eUvyyfabKJVcvicprQut8k0LsYiud4e4LQfulne8MwVDv/vEdiMX1sIiD2fCZbMO0wjJc9TieBPsexB5THHGc7haPB0Xl7oOWDfbwfW/N5KIeAyR4NosK79d4llaVcpg/jsFOGpz0KyVAAJsggspV8fLn9T0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eadbe5-297f-4ffa-7d4c-08deaf854d0c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:46:59.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2HLO5FIUWql+RP5xYmSqZKlYQO/YGdDRK4ACxyHW34DoBafzqBQ5Elo1prPVwYwHWgXSijaBnhgZJyeYSA5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604200000
 definitions=main-2605110189
X-Authority-Analysis: v=2.4 cv=cPXQdFeN c=1 sm=1 tr=0 ts=6a021621 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=zd2uoN0lAAAA:8
 a=6y9mIIUkAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=t7PVQ9Ey1SMm5L1QrxgA:9
 a=QEXdDO2ut3YA:10 a=BT1tkpHCJze4Rb8jY6gx:22
X-Proofpoint-ORIG-GUID: pbal7CnuvknsKluic8d7BqDqmTyDQ439
X-Proofpoint-GUID: pbal7CnuvknsKluic8d7BqDqmTyDQ439
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5MCBTYWx0ZWRfX9p6Yh86HYD08
 H0CbT++suws7T822TRAqZ+rsrJdoadBok2nwovlvNB6SYqcFdjjypSKCKlLfTkgDtxDcT8yO6Wi
 4gC566jm9d6JAGfo80VXpEaVLKlHEQBdXgPEE6L9+yvSPuOw65Y/F17hIZtMr/sMkIlNKDC8Fqv
 J/p7AdFEd57Efgs6hVFYwq9GS/GOxOmaJAwZ/xJPoelJVMdH2K6b+7PZrNT2UZ9wZSsTnTHcVKE
 qLHY6IQYjnxRxpuWdyTdGJ3aFO0rHAfZUFlFGdjBF8Ar63GmwxsFbdQZ71pc3xICAjNXDrfiggE
 kd6J0a1Ca8IGqmFVJqsPT1nvgO6oScPw+6uegClQklCth+2CBCoP13fM7bWDW2dMr3C5VRg1avm
 SwwabOnH2d5+KYi91Q32Ac9na2nXfqJwC9J9Me+AuHLhtvudKq+Muibm1yb3FUiFeo//OXbBoGI
 jUA6kilQ/c9l8q3Zd8g==



On 11/05/2026 18:43, Ninad Naik wrote:
> Replace non-working links in the reference section with the working ones.
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   Documentation/virt/kvm/x86/amd-memory-encryption.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> index b2395dd4769d..bd04a908a8db 100644
> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> @@ -656,8 +656,8 @@ References
>   See [white-paper]_, [api-spec]_, [amd-apm]_, [kvm-forum]_, and [snp-fw-abi]_
>   for more info.
>   
> -.. [white-paper] https://developer.amd.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
> -.. [api-spec] https://support.amd.com/TechDocs/55766_SEV-KM_API_Specification.pdf
> -.. [amd-apm] https://support.amd.com/TechDocs/24593.pdf (section 15.34)
> +.. [white-paper] https://docs.amd.com/v/u/en-US/memory-encryption-white-paper
> +.. [api-spec] https://docs.amd.com/v/u/en-US/55766_PUB_3.24_SEV_API
> +.. [amd-apm] https://docs.amd.com/v/u/en-US/24593_3.44_APM_Vol2 (section 15.34)
>   .. [kvm-forum]  https://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
> -.. [snp-fw-abi] https://www.amd.com/system/files/TechDocs/56860.pdf
> +.. [snp-fw-abi] https://www.amd.com/content/dam/amd/en/documents/developer/56860.pdf


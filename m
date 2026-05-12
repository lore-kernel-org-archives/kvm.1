Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3C383985;
	Tue, 12 May 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628261; cv=fail; b=mzvBtyNO3h3enQoyHXeoTOx+8ATcufYnqYJXiAnvdiy8215koEetkDfozsiA4jUjZZNkiudX2zabWvYW+97ILX4qZpq7AHuuVy9KYbKr+xjVl6hljdmnxV6AjhwfACAtLg7ZcpoxN1H3inz6VUfjmGdAzjgJv1ciac9Mgdk9VOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628261; c=relaxed/simple;
	bh=PtzFFmt4Q1aFRh1ghNSY3ys+2qHlC2dEPt3Xg0wUeNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o79xQRcZnr6WWtubUVd8u2q8Qm5lkUv8Y53tVA2xgmSqSJK7Jo9gNJ/fJsSkuZuDalKuxcS9cYb3yXBoBK4Q94U3eeDuSoGEn4Soarbvzm/2mjm3fZOr5c6xDuusIWTLlUthb0mTfNxnoDb4OtLokXdcaGCIWLnhUGzqlSXoDag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qPW/1/J1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jcP0Xd0D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qPW/1/J1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jcP0Xd0D"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CMwlv6588251;
	Tue, 12 May 2026 23:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SAExFRtRGmx6C1iE7ZkJG1MBxRGBHFlZEKJRMv/fWQ0=; b=
	qPW/1/J1A9GMqVpUGr1DacNkoQL5/VsCsTiW2pXLBRkkR7/7FFxDM9BWWwwzYb7A
	S+oYYZ7RR27YzRYY0B2uOyr49qGRKbQ6GwRwLWo5cWlvfE4Lf3SiX+5MnjXAPuXV
	VE78Fbolrm1XS0TXePLxuyYAfQl5W4wXZsUmmRcXNb0eHAw3Vn57R5S8mXNPsLPj
	k6CjA2738BJ65/BGeM/cnb8MtAxl1Gnuj9mPRy8cy6fBSTGb6FPfhRPWiwhAWWFG
	vos20Ot7pm9AqH12UxRrML3v+ymeG8Vt0FeQPwPRNQXUFpGNQeirRxmAOZ89jVMK
	ChpZZtl+rowyYj5cTb9W3w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c97g57h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:23:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CNKPaT005054;
	Tue, 12 May 2026 23:23:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nebx32u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:23:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXOTiuhjqAVVklum5yAVqb9blRKfsTIl6vo1wK6Z05eUOvrhTiMkLJXJenWHrwxzr1mUV+ql2nt+wjndi1DGdh9x/D2On/KZdIeUp4jTgxjAjvvwejtpRxRdKbDCTPMHaIGXAC+cQWkpvd2wLmy9zYJfsweQmvbzZrGwFxImw3gsYRXQS748TxomGWtD5ghhPd6hmpFXlMU+pz/Nj5FUOqcdWsVkaffNyz3RLP/yfpGVAMT3swL7mgrlE/KLHuV4TYw7E+/oRGc9z6AyQ3BoIGVk+mWT9t/0TdG4QyGrBrMIC7NPe2sAl4oFXzLY3wthSwvGK08TchSGzYnfv9aUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAExFRtRGmx6C1iE7ZkJG1MBxRGBHFlZEKJRMv/fWQ0=;
 b=ia4SO4sl2LppU9267GNXomfD0yKWZ4NBu37IxzEtg6DrRA2QXFWH8PCpsAboK7c0UjzbGptvjQLN7dS98dlNKexHAer07cWV7J+WNHCCAU3AtEdQSp+fTFDCcGrhz83/TNmuDCbV9kkxYkA4DhrVAx3/uZI8oNOANLYcWF631mgzekf6CSqbwCPGgLOBHnVqBM4C/04h0zgftge9JOZ3zM5p7BLb7ikOnkHXJPNDQqJPjn4u/oX10LY1nFamdCwi+JDf0F2BPbEHsekQgFawsDdKTmqUjyRKpE971V7ULpJnztYkK/tCwIVwDjiorN1D9SAgLjD6DWnXpUBrv6sc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAExFRtRGmx6C1iE7ZkJG1MBxRGBHFlZEKJRMv/fWQ0=;
 b=jcP0Xd0DB3YUGjVgIuvwuZPftwdhFG3AJCP21aQrPit3fJ5rfDMxji5AA7a9/6FFx74eAuuV8AufujSvLDOszqTFO7AHhBVc+CmQUfqlSUl3buz/BHSs5q6xV07ewniu6oOQxoapgqN6AAH5XOm7MMTWw5QUi8L5WO/a5WeipEU=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by IA1PR10MB5924.namprd10.prod.outlook.com (2603:10b6:208:3d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 23:23:39 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:23:38 +0000
Message-ID: <1a7da49a-9737-4e00-b1ef-ab900433657f@oracle.com>
Date: Tue, 12 May 2026 16:23:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: x86: conditionally update masterclock data in
 pvclock_update_vm_gtod_copy()
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        joe.jin@oracle.com
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
 <20260115202256.119820-4-dongli.zhang@oracle.com>
 <16b69905d5d14a06dbb68f29355c58e2c7d2f0d2.camel@infradead.org>
 <dfc032bb-c17e-45d2-bce2-7e09d8b2b187@oracle.com>
 <94bbb27100ac85508f00234e4ffdb619de855d7c.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <94bbb27100ac85508f00234e4ffdb619de855d7c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:610:e4::19) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|IA1PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: c9edf6aa-c736-4025-55cd-08deb07d7f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yWaIEJ2ImS4N2YJa0a33jtVYwfxYvDDhBZ6trKd92hcvx9KffuIhEnM7/Da/AeSiaSnYl7biwnp4H3Ssxm9Yp6QiWNf5DWy9x96SMfEs3rhG9ULBiGiFVZL0SPkEGlIfjMuVIL7G1oztNyJSC3dt7cfcuzH4i3uiGpKddbX8q+KcjG7wJrcFU/a7KrKQG5P+Ty9ZQQeBk18HWH4gF35GHM3nu8PNSLnJuGexJ0WGptuGcBJQddZsfBEWu+xlky41jJPoLofOEIGVIDo9Jaq/Xc5RsgOAo4ADZW4cLCf07aN9JUZmtErJDfM2Z5gGkLiW1VYGGiUin21cqElkZcrXdCjmbSBMY/49azvzorD8LFX1oQBnUNMxHnyJIuDMdo4ZKK/7a9leKojn3QdG0vwRngmdLS6PdcofkAO/EN9mYvmRc7VEnYyVMqYhbMgJnGkWjFfwonllSCmz6GOuSviaFLZhh6rCrJgbiOFzf0C3RJSSwtSjyN4oCrHrHSZllvzLHGdGCrM8BdVMBffLeY0kKaOy1qnVU4dkcIBJvgdtZ8JCZ3JOrLmwQ8aH+hw/MPmcZVAWc0E0L+WTtHUyJnOKzeyQhRJjyRP5UTVROjHD5uv/fdILXLUsXimnhKdttXzmOCfnW6bDb/kOVAe2U1fTomPxAT5SpG9/NwNqGCI4R5+zcqJ1d6/FdXbZAaLX5Ceih81xlRM1zs07dUdumDqb6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEE4bEw0VFE2L09Sd1luS3lzczdpcUVudDVEdk45WE16cE8xclhBbktReGFt?=
 =?utf-8?B?UU16L2MzV1M5cExrMDQrd1NrcGZzQnZnR3MvQkQ0WHZmRkhiWWREM2VuSjhB?=
 =?utf-8?B?d1orMGNFWFlYNEJlcFdhdGNsL1BNMW43azQvbkVwakZhdEt4d2hRRENxR2dY?=
 =?utf-8?B?eC96RmNtWVpjSGFETUhDSVFnWFpWVXFUaUNSbDhrWWd5aW9jemFqTmpqN0RD?=
 =?utf-8?B?aGNJb0J3TmhsSzBuVjFGcTdNb0xGWmJhVmJGU0ZNK2xoMERKK2Y0ZDNqM2Nu?=
 =?utf-8?B?dVYzR0ovR2o4V2Z4WEIxd1lDbHlNRmd4MkRNUzBEMlRDS3plT29pQk05SVMy?=
 =?utf-8?B?Zi92S0tCckp6WmppNnZDN0xYMENadENtVG1RWkZvdlR2bmhhN1pVVjFJSGxl?=
 =?utf-8?B?bmU5RUcxcldhNzV0NXJ2MHViVlJoNzZTSjdKb01ybkhGS0R0RGpsVHFTTjF0?=
 =?utf-8?B?ZGxWVnV2N1VzWVlPUXFMVmhHbDZnU1BGa28rcHVVck9NaWdhZFZ1bXpiZzVl?=
 =?utf-8?B?NEpJc2dzZ2VBazRHZThDNzdBQkJPQzBUei9Nbk93eGQ3VWhFU09kMDl5S2N0?=
 =?utf-8?B?S1d1S3NnRWVrQlVORWMvME1IQTBJeXpsMUpqSWJhdms4bXVaY1NwTHRLUnhJ?=
 =?utf-8?B?RDlMb3NGRC9NZkwwWVdUYS82OHRJYVM0UzdER0FtT0cxS1VtUUp6ZHVuSk5i?=
 =?utf-8?B?VHk1NGpyRG5zVUg3RnFaVGtXQkJ3MGhtN1p4dDRvR3B1a0crRmtaNHN1Qlk2?=
 =?utf-8?B?K09KZXdFNVdwZVQyTGhyOWp1cTBLV2V4MkZyME1ZLzQwYVZEM24yVzVYOUpQ?=
 =?utf-8?B?dE9MU0VnRkV6UlJZbGhCN3MvaWl6Z0lyQnNLekNGZWZ2aVpyQkFGZ2V6Sk9L?=
 =?utf-8?B?OTFzTElwV2VVSHk1eitZU1hnRVlmdGpjUkV0Z1M3d3k5Q1ZIeC96TWxQVDRZ?=
 =?utf-8?B?WWUxNnQ1K3pUc3lBNkFENkNvRFlKZVhFUEpsYVhWTXg4KzFXVVN4UG9Rd0ZP?=
 =?utf-8?B?MS9xdE1TWUNLR3V3N2Z0emxLeGZDVTRwUlROcEZ2MExqOTYyRDY5WVNKTng2?=
 =?utf-8?B?VDJuN2tVSVR2UkpOOVJRSmczMEtvUDE0TVhtaGtRUnA2WVZJWjlCcklSQlho?=
 =?utf-8?B?aU5seFFrbVFybjNlbXh5aEdISlBKeUtuT2ZsUE01TTVUT2NWbS93bnZpNlpY?=
 =?utf-8?B?elZYRHRqc2Fab0FHWXpKOW9lVS83YXVxK1pwVHBNdFBJZTBGWVJ4K2w2Q21I?=
 =?utf-8?B?U3c4YjltanI1cHVJaHhHOFBMek41bXR5YUkyK3VPR0k3ZXVkcnFMZ096ZFFw?=
 =?utf-8?B?TnlFQkF6c212aW1PNkVMNTd2Yk9IMHd2VGh6TWJtbHY0U3UrQm9HRzR1WWUy?=
 =?utf-8?B?b2dpZUFpY0dnRkVoNTBwMFU4WTlFMGdtalRxUHRKa3RIbUw2UWwydkpTYnpJ?=
 =?utf-8?B?NzVPS2pkekp5dDJ2T0ZhZG1keDhYQmpDR1lQU3UxK0kxTnRqQ0dseXJBQkY1?=
 =?utf-8?B?d3RvVjlybjhiZlZIcHR1Nmc3czRwVWJuRFVjUmV3d1FSb21vY25YWXdNZGVT?=
 =?utf-8?B?M0xYbTJQaEh6VGpTU1dXcnBFSFRuclNyVFlINGVLUGxYUkVRUHNhUjRKK0t6?=
 =?utf-8?B?Rm9DeG1vL2hsVkRma24wM2tOUzRzZVNQckhLM1dTdUFDRFBNdUQ1cWhXa09C?=
 =?utf-8?B?ZTljUVl4OFkrcTZjK1Mxa2ttaThyMlR2d3dqUlRoanNWL3k3Q0d5YXBMMkpU?=
 =?utf-8?B?ajVVaHZ0Znl6WGlXZzR4OTdZZjR0dzBONGtjRjM2T0JlMWxROVIyYk9OYjRX?=
 =?utf-8?B?VCt3bUFnNjRXTWJlT2hwdE9WOHNER0FiQ2xwT2d3eHhkVEF1UjlOd1VHVXJT?=
 =?utf-8?B?MEp4eHoxYkF6Y3N4Y3htdUZDYjJtc2ZobGdrOTZ5amdpcHRYTEdDUHc2cGl0?=
 =?utf-8?B?RWlVaWNVT0JENGp2NXBBSmhjblFUZy94UjZZTlIybVRZSE1OaTRkZHB3VDg0?=
 =?utf-8?B?ajY3ODNmd3RPdEpsYzNKTGRQVFNVdzEwdTFBUUhoOExiVjhWZ2hFOE1yK3pC?=
 =?utf-8?B?WG1JNkQyOEFCK3NLc1R6YXJWYkt0dGtnd2h3WHJGNnBLcVhITDhSbDRrY2Rp?=
 =?utf-8?B?NEpPMlcydXEwSW55M1F0K2gxMDg3UzE0a1FrUkZDL1UyUENmeXJuQ2lCcFpl?=
 =?utf-8?B?WFhTTkNuSlVJbmp1TFhEbGJBQXhBYk1RVktjRUVQYnAyUzZ2VzRkSGJSZk9n?=
 =?utf-8?B?T0RlNVZZY244SDlDb1kxdVRkc2xlNTREUXhnRXZJS1BpWktZTkZEVXFOMHNy?=
 =?utf-8?B?Q09kSnBoaENoc1kzaEZzcmhkeTZCTFFBTFhacDdCczFoOEtiV1RkUT09?=
X-Exchange-RoutingPolicyChecked:
	T0i9SYePBEZwtc2fEe9++Dp8qcxOCphmrys2lo2CuH92kXUmQT2mxkMG/7IDhC3263rRJZbtex2ebgpsPy3ZOz/fWfotqns+/LcjUJgdw37xt2jD2iHnQNmYUo8+IhpzAFr38YdIJMZrM0KPoCEcCaQhoQOQe9n0e4LL1CAWmgdlplxKUP/HsmdVTa6CJxVkybWVQhaU5bdeX+fpSCbljifOi/hiYMO1+3vlO9C4BAhQgEZVIokcfJnU8L3PKMq2VlyYSle//unEqPjMf52J9aw662iKg3AWPVwA0LlRRxhSXoprh6Hi0cKngfpVwGMFsEMaNO+tdnTMCIGAwKkEcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZLRLFAU8IbEtSxBPCcejakxRJbm+oZFn4VDO/Ce9GmfX471mlzfDLvIl9D5YL7PMDI8iisim7dKVslt3w92mLLA8eqLCb7zdOkxFdD5AuqtdgVPxnv7qejiOoJ6i96peMYPH1QwqUB0WciQ7RWwPVyaGeYgHca7AwD4wCtOjOt7iEGyJGhRB1QKU+yT+ezpkkgZnU9fNJWYJfymaPf+qUhWkAsjK5+oWFH5a63xiwHBRkhC+e8NG8NAtGjy/fNxaI6/2aXj6TVJjpLkfGTmNfTYGvzNzS/WS60bT2nd7wS2J96fbZ6zcFDAVWLiTy+5lKzZTUIkEqC9nZYu99s+ae7NWpYKUZIBEdcs3WJhdHsSBlJ3YaZBKJbU91OOD+JFBrlPFuEieCudCcZXHNxsqgamn6lfT4ISH6eeHT5ITyYkVnWgPt0s0zNPXbPBxj8eTM+AWS0h+mYlLzNAfPqphpzQUI/xt5CaQRCcwNOizMRqQWtJveL0BLrW0sj6jAw5RG3LzMEdXhJgga2GwvPi3CncmbbhYSMugl/1jxDP9LIsb9wws45wJidSdLNq+eMhMX4HiLbArwIUi7oBpOHVquwyt+n//l6IiCxop0QtEOkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9edf6aa-c736-4025-55cd-08deb07d7f54
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:23:38.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHdqqFmY7f6FZFeYwKttfT5V5KL2OFD2PxknznzLdyBnAouejQ8ifAW8PN61vMlnhzxQ8Ckz11VyeYLswa1Kmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120239
X-Proofpoint-GUID: xl1wdtdxCPZZXwAV9XIwtxgc3YCFNV0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIzOSBTYWx0ZWRfX5OsqkcPWiN6W
 BROsJovuBS8f+bnsG/ErIrlBNiouUCCwxekPtthjTR2zsyIpMs52R9f1Iet8/1grGk38SL7BRe6
 ej65+/r9LK+K7dXKECouc4RrRA8RbLJ2qDOnY3qQ7K2b8BELsAlg2lxiBsJhSG8kDsT3y7+jqRM
 M4tJ5pI40SJ7+9GIG8m7IJ1b5klvigMvMRXhUglp25bB8DLg7BDv2GrtKJSdNO8AB14x9sOipgW
 QPm9y6XkzgI85ljSfg2MO6PrMyU+qHW1ybLxqVSwdiOltiE/d/8shB51QJADvxKwkXot3Du15H6
 /Idds7FZz5Tqx3Mp16jMe61jpGlPiyvrQeIDOEpN2Mwswzj8BOxYxC3a0znbcumwIN33easE0uV
 QsckEqpo8+EDfNLrG/+llUYq/SLEfyhOSCQAwE5uQpc79knCuAHL0LlqvmJZvu9vyJTS1VCjL3C
 4Ad8YyeBgQ4L4LAzmAJCC9hDumK8LEZ8SgbPYZ3o=
X-Proofpoint-ORIG-GUID: xl1wdtdxCPZZXwAV9XIwtxgc3YCFNV0V
X-Authority-Analysis: v=2.4 cv=T8a8ifKQ c=1 sm=1 tr=0 ts=6a03b682 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=pBOR-ozoAAAA:8 a=FrCO_6ffwmZE6t9IdJgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13839



On 5/11/26 10:21 PM, David Woodhouse wrote:
> On Mon, 2026-05-11 at 17:16 -0700, Dongli Zhang wrote:
>>
>>
>> On 5/9/26 5:22 AM, David Woodhouse wrote:
>>> On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
>>>> The pvclock_update_vm_gtod_copy() function always unconditionally updates
>>>> ka->master_kernel_ns and ka->master_cycle_now whenever a
>>>> KVM_REQ_MASTERCLOCK_UPDATE occurs. Unfortunately, each masterclock update
>>>> increases the risk of kvm-clock drift.
>>>>
>>>> If pvclock_update_vm_gtod_copy() is not called from
>>>> vcpu_enter_guest()-->kvm_update_masterclock(), we keep the existing
>>>> workflow. The argument 'forced' is introduced to tell where it is from.
>>>>
>>>> Otherwise, we avoid updating the masterclock if it is already
>>>> active and will remain active. In such cases, updating the masterclock
>>>> data is not beneficial and can instead lead to kvm-clock drift.
>>>>
>>>> As a result, this patch minimizes the chance of unnecessary masterclock
>>>> data updates to avoid kvm-clock drift.
>>>>
>>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>
>>> Hmm... so the only caller of pvclock_update_vm_gtod_copy() that doesn't
>>> set the 'force' argument is the one in kvm_update_masterclock(), so we
>>> are asserting that kvm_update_masterclock() never needs to *change* the
>>> masterclock origin point, if it was already set?
>>>
>>> The gtod notifier callback in pvclock_gtod_update_fn() also ends up
>>> setting KVM_REQ_MASTERCLOCK_UPDATE, and is triggered by an actual host
>>> timekeeping update (which could potentially be from a clocksource
>>> change). It also hypothetically possible that the clocksource changes
>>> from TSC → HPET → TSC, switching back to TSC again before the
>>> masterclock update ever gets to run. Or maybe a suspend/resume?
>>>
>>> Are you *sure* that the optimisation is always valid...?
>>
>> Thank you very much!
>>
>> I didn't validate the scenario you mentioned. I missed that scenario because I
>> assumed that most production systems nowadays use STABLE/CONSTANT/NONSTOP TSC as
>> the host clocksource, although I sometimes forgot to add "clocksource=tsc
>> tsc=reliable" to my AMD L1 KVM guest (acting as the hypervisor for L2 guest).
> 
> I'd love to assume that, but we do still have to cater for systems
> without it (or where it goes wrong). And where userspace sets up vCPUs
> with different frequencies... although I'd quite like to ban that too
> :)
> 
>> I didn't follow up on this patch because I noticed another issue. I found that
>> the tsc_timestamp in the PVTI can become a very large number if we simply reboot
>> the guest VM. This happens because the patch stops updating the masterclock data
>> when the masterclock is already active and remains active.
>>
>> For example:
>>
>> current guest TSC: 122763682
>> PVTI->tsc_timestamp = 18446744073656540006
>> PVTI->system_time=196515164269
>>
>> Although I could not reproduce any bug, that still made me feel uncomfortable.
> 
> That's just negative (-53011610). Theoretically it's OK; it's just a
> consequence of using a reference point in the past. Probably just
> *asking* for guest bugs though, so best avoided.
> 
> I'd like to understand how it got like that though. Did your 'reboot'
> reset the guest TSC to zero but *not* its kvmclock?
> 

Taking mainline QEMU as an example, I simply trigger a reboot from the guest VM.

A normal reboot from the guest VM resets only MSR_IA32_TSC, but not
KVM_SET_CLOCK. Before the reboot, the masterclock is enabled. During
kvm_synchronize_tsc() for each vCPU, the masterclock remains enabled as well.
Therefore, pvclock_update_vm_gtod_copy() does not update the masterclock values
because of this patchset.

As a result, tsc_timestamp eventually becomes negative.

For example, I apply the patch below and this patchset on top of the latest
Linux kernel (as KVM).

https://lore.kernel.org/kvm/20260115202256.119820-1-dongli.zhang@oracle.com

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6e88310f5979..d9f93cdb46ab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3158,8 +3158,13 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm,
bool forced)
        if (forced || !(use_master_clock && ka->use_master_clock)) {
                ka->master_kernel_ns = master_kernel_ns;
                ka->master_cycle_now = master_cycle_now;
+               pr_alert("debug: pvclock_update_vm_gtod_copy() update (%llu,
%llu)\n",
+                        ka->master_kernel_ns, ka->master_cycle_now);
        }

+       pr_alert("debug: pvclock_update_vm_gtod_copy() old=%d, new=%d\n",
+                ka->use_master_clock, use_master_clock);
+
        ka->use_master_clock = use_master_clock;

        if (ka->use_master_clock)
@@ -3416,6 +3421,9 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
        hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
        vcpu->last_guest_tsc = tsc_timestamp;

+       pr_alert("debug: kvm_guest_time_update() vcpu=%u tsc=%llu time=%llu\n",
+                v->vcpu_id, hv_clock.tsc_timestamp, hv_clock.system_time);
+
        /* If the host uses TSC clocksource, then it is stable */
        hv_clock.flags = 0;
        if (use_master_clock)
@@ -4108,6 +4116,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
                vcpu->arch.msr_ia32_power_ctl = data;
                break;
        case MSR_IA32_TSC:
+               pr_alert("debug: set MSR_IA32_TSC vcpu=%u, host=%d, data=%llu\n",
+                        vcpu->vcpu_id, msr_info->host_initiated, data);
                if (msr_info->host_initiated) {
                        kvm_synchronize_tsc(vcpu, &data);
                } else if (!vcpu->arch.guest_tsc_protected) {


Below are tsc_timestamp and system_time before reboot.

[  154.159733] kvm: debug: kvm_guest_time_update() vcpu=3 tsc=97471036 time=4759583
[  154.160101] kvm: debug: kvm_guest_time_update() vcpu=2 tsc=97471036 time=4759583
[  154.160658] kvm: debug: kvm_guest_time_update() vcpu=1 tsc=97471036 time=4759583
[  154.161292] kvm: debug: kvm_guest_time_update() vcpu=0 tsc=97471036 time=4759583

After reboot, there will be TSC synchronization.

[  154.217551] kvm: debug: set MSR_IA32_TSC vcpu=0, host=1, data=1
[  154.217980] kvm: debug: set MSR_IA32_TSC vcpu=1, host=1, data=1
[  154.218384] kvm: debug: set MSR_IA32_TSC vcpu=2, host=1, data=1
[  154.218792] kvm: debug: set MSR_IA32_TSC vcpu=3, host=1, data=1

The masterclock remains enabled. Therefore, pvclock_update_vm_gtod_copy() does
not update the masterclock values because of this patchset.

tsc_timestamp becomes negative, as TSC is reset to start from data=1.

[  154.219283] kvm: debug: pvclock_update_vm_gtod_copy() old=1, new=1
[  154.219671] kvm: debug: kvm_guest_time_update() vcpu=0
tsc=18446743945549702059 time=4759583
[  154.504499] kvm: debug: pvclock_update_vm_gtod_copy() old=1, new=1
[  154.504898] kvm: debug: pvclock_update_vm_gtod_copy() old=1, new=1
[  154.504898] kvm: debug: kvm_guest_time_update() vcpu=0
tsc=18446743945549702059 time=4759583
[  154.504898] kvm: debug: kvm_guest_time_update() vcpu=3
tsc=18446743945549702059 time=4759583
[  154.505240] kvm: debug: kvm_guest_time_update() vcpu=0
tsc=18446743945549702059 time=4759583
[  154.505240] kvm: debug: kvm_guest_time_update() vcpu=1
tsc=18446743945549702059 time=4759583
[  154.505241] kvm: debug: kvm_guest_time_update() vcpu=2
tsc=18446743945549702059 time=4759583


Usually, QEMU users (i.e., libvirt) reboot the guest VM from outside, that is:

1. Send shutdown to guest VM.
2. (qemu) system_reset
3. (qemu) cont

The cont command triggers KVM_SET_CLOCK, so we do not get a negative tsc_timestamp.

That is why I did not follow up on this patch set further.

Thank you very much!

Dongli Zhang


Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02531F9B9
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334321; cv=fail; b=iuorgIEk4PQFwINPy+mmV8kW7EYcBfzlsq09m++7cj65YYjbTDPqV5IpuNrMZ+R9jqWQOfA9Nc/klhP3LE3u6WbuU8mwsC6WXyeKvBlqPbNPO/DSLV/Im0LoH1uBstWQFM42qXrEoAU/jPNQZQssshcO22yEZXfBkbxJeXa06kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334321; c=relaxed/simple;
	bh=fu9kfBN5+OhWQKynQyrLmNXJh8c9ntl3YxN4wOceX8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fnp9vBzqf2laDAK4D/o5YWOTn2pHw46OCbYDiykSLO/68k6hY/SSr/1CFeBHpGw3DGNjfCNyaUMLhxes3rdHD6mdHXUQgNEXRaTfvh5fYDUT2YpMOeRbp1WFDqMZLDg2X7DsmoYpfHTYrd3LUYLzO1SHe10erARcGM+RQDIMVgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqdwA7RB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6m5dsAd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqdwA7RB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6m5dsAd"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LdaEA1697492;
	Wed, 7 Oct 2026 00:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Nr9UnlVBezxQhLRq9sYEQvw5ftbW2cE0/+mZTf55MFg=; b=
	lqdwA7RBtz1VwogdJnFfrxJ3RRVil5Q0ESCV1SXpKCDNhq0diAKPyVXTOh5387Rb
	MhNz6GzaUgxNhkaK+rIjSOLCR7qTrS4M0n3uFhygz3AevwJXu9p33ZqsMHF6AxJ+
	0Wykwh72nKq307ix8oWYPnubXyAviz8xoSJmJsnHEGiVsGIfPev9PMIvTRpZ8oug
	78IuVqua8bjGQW+oqOXYax3z0D6akhzzDv82DDNwwF6LBc6zfYNNFtNUbj8blxkY
	2Lz/S6PwoKIdVldg5UCHMvDWcVxvH3Wuj/U4jdFihmp8P6rkuEjv9MfL3fSZl56a
	D7uO82ekpboKwgbA40r6aQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rm9cts4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Oct 2026 00:51:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6970pB4t007180;
	Wed, 7 Oct 2026 00:51:14 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d1r8f29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 07 Oct 2026 00:51:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKTUtgqn1Mse58SFrEJoI5MV0gr9+VAeTNtlNhFaviChWjVu+p+FmOEE/kyEG9v/owbvtcW+OfXDtHxb/h5woOwQKmGUJpBeTrTAfMmElFTIwFcaO9JCNqjhSESxAzVrJ+6/LJPHM9ju/1Bka1/kPpP4XCgo8zOisas0lujhRX6eL/Dg1XKb+6qxMuTSnB0ExrqgGh/6vj+yZW6eDttSxbFa9WXitucp29qtotKxFFb2QzKEeTMSPihVd0xH/1bgjMN+fytioPhVVMmEFX794l0kNYkQBPUT6ebskZNSg6WHYutCsTn2mAVj8rkenFIvYODrBaEbSZchoRyZ0pC5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr9UnlVBezxQhLRq9sYEQvw5ftbW2cE0/+mZTf55MFg=;
 b=fF7TQFDPCx1+QfSZOIjaU9qiv1dXVVSUlR0GrONmSP3jC2p0f/GSxYxaq0OI7T8GEXlN02yOExRZ57MjiROX03+CQmHWOFHP0zei3tjSq1Syuz0bOotgjQut1Do75U4hKHD4XYwzVFYHQ0bVUOzKISw3WLuWNA4ycss2BFjfwZVeX0J97q2QGVm7Cxm85oKvB5QwQyh5HdziOvzrMXDgokM7Z6hZiZjyjQFoDPM6D3oV69gs0a6jDAB2TwRsU+gmwFEaPPiLZfikhmoM3++ojjVredNuadPssmjl69U8iSpYHq7LDTay8fdi+pY45rp6DBOZnc0JRh+GhLHQX5+wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr9UnlVBezxQhLRq9sYEQvw5ftbW2cE0/+mZTf55MFg=;
 b=b6m5dsAdz+IovloYYXhUwhyH3muNDfiHE9I4BCO+Y+fgRM3HuD42G8d/+JpxE1IlfUqPrHqd1Ng4om+K5j/SD1QHxWzGMInDUVUczWuaUdMFs6koMubXh8KBLdzB79HyprbhgFNeEA8/5bB2wGsTW7DtzOThfxcbOwzHAPgE/co=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SA1PR10MB5510.namprd10.prod.outlook.com (2603:10b6:806:1e5::6)
 by SJ2PR10MB7734.namprd10.prod.outlook.com (2603:10b6:a03:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Wed, 7 Oct
 2026 00:51:10 +0000
Received: from SA1PR10MB5510.namprd10.prod.outlook.com
 ([fe80::a9a8:cb4:1056:5d96]) by SA1PR10MB5510.namprd10.prod.outlook.com
 ([fe80::a9a8:cb4:1056:5d96%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 00:51:09 +0000
Message-ID: <d0a22994-1a01-44c6-8a79-12470ee8dcd4@oracle.com>
Date: Tue, 6 Oct 2026 17:51:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Sandipan Das <sandipan.das@amd.com>, zhao1.liu@intel.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, babu.moger@amd.com,
        likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
        khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
        den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
        dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
        ewanhai@zhaoxin.com, Michael Tokarev <mjt@tls.msk.ru>,
        qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
 <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
 <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
 <84b5b038-e32f-4765-9d23-9f6ecbf382c0@amd.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <84b5b038-e32f-4765-9d23-9f6ecbf382c0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::17) To SA1PR10MB5510.namprd10.prod.outlook.com
 (2603:10b6:806:1e5::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5510:EE_|SJ2PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f648605-92dc-47a1-4be0-08df240d13bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|4133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P0UNb/KWeeSfZVznzZO5zrTw3Oc6UIwg/RYq4oId8w84VPj9/bATip/eMFGxqrKMz4UG33PmbJydOuoPfPD+OAQ98LuabAr2bLrRbkl4CXhkoqeglrKmtzJmkZqijC0MYe6R5YEEjhFDKfiTlxwZAViWY5x79ehyy01OqmjFYsPCAnnxPsqO1roqvv7sZdUr+OsdGUp+qMzxHN0zhWTYxIDNzydRjedmOykZW/L5NsQ8EsXkTC74q9CDcQpqdzwbRcTZEO5H8jyJdCPe4cOer8HpOwrfQSBZQSw/HeY1kdyk/ab5jfywHSIAeWl6fAnEAmllWaecTuymBRSKdBSWqRwLX+a77jL2t4ixkUDHdEyQTiTZszLP1lxrXue934EUDi96OpKLetyFs3SNxBWgBYbLGpra9Fw+T6FbyNGH8TEzcCw0w+Tt/KGp1Z57eAFa7Kifag0ZtQveq2yWf1O1JaOelr+XCskVoP9DXvDTjSXwuI/og2d+Hgc3rlal0zGEMqmseqCNMed7qR/RoD2os50VKUh83hmto0SZr8zmxsHknOQu61iKMT6m4s7wcgf3BWkuds1e+tWB03IuUSGiWz6Ido7EpZxDnws09HesILs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5510.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(4133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk1PYUd1Y3BES3h6bTFTUmR2NVg4VVAwVEpjcHlKWUhPV2hZVmdhU2JEa294?=
 =?utf-8?B?NkhMRmhqcjNnZ0lZOHBWT3NVUDNYcUF0Tjl1cVNyTEU3OGtHci82Q0p5ejFa?=
 =?utf-8?B?ajQ1MHFhYzhzQ1ZEOXZ6d1IzcXUzVGlWbkdzanRmNGVsNFFmaVB3djU4OHdi?=
 =?utf-8?B?UXMwNTVXakJKTEEvQWE2aXNod0tkVzhGVmNkd2QxRy9JNzh6aDdwMExyTEZV?=
 =?utf-8?B?Wko3ZjRieWp5U0FodVN6QU4xRVNlZ0QzL3dzMG1HaFVySDN5ZGovVGxlYkxl?=
 =?utf-8?B?eTE4NVRvQVd3dS9FMDl3VDBoc2F3dFNYN1U3d0JUQ2tLYU1ObjBuSjdXdXMv?=
 =?utf-8?B?MUorMUQvT0Z4ZENyWXpvYmZIbXd6K2lCRnhlb0xUdGNaZTVuMFd0S0NuN2V6?=
 =?utf-8?B?dkRrT3VPNnBoMk0xdyt1TklNNlA2MUhJZmlzUUc2QnZ1T2tWZ1FPWjZJTE5o?=
 =?utf-8?B?ZzRlOGpvYkt3KzUzMWxSNlNwWnVhd2xFWWs0U2E5TXdYNHFJTjZ4TFRKNCtt?=
 =?utf-8?B?d0pMcHI4QkI4dXpSUkJFWGdtdEROK0xKS0xJMUdzZEVzM1E5MWJPWVFucnI1?=
 =?utf-8?B?VG40TERlT2NrK0pnSkU4aXhjcjNKVlZVcEZqQlBXYWx4TVJhNHR0enJ5YnhX?=
 =?utf-8?B?blJaRlRpWlorTzFwczl4VHJ1TjhHaWtEU09MUlNZYVhDQnpsUEtaNGROSDZo?=
 =?utf-8?B?WFMvNUJMSVBmdVpFMGhJOVRVbTBteXVLV3Ezeld1c1NEdWZrY3E2Y285QWN6?=
 =?utf-8?B?ejFVaWJkYjQ1SFY4OEQxd0FpbjV1TUs2N1BMYmdqZjVkS2JvSWtSbUFwdjV5?=
 =?utf-8?B?OHRRMXF3Wk5Zam0zT0RTbE4zZlN1TURmM0ZkZmxSQk1WVFNialNvaFNaVUpo?=
 =?utf-8?B?ei9GNXZFNFNnUzQ5U3pKZTdOZjB4RkJrdHZ4eUI0SVVQajhFaFlVR1AwVWF6?=
 =?utf-8?B?czZwbk84Ui9jdkFTTEk3M01jTG5PK0RPZUNMdHNmdE5tdU5ZU0RHR1I4ajZO?=
 =?utf-8?B?WFR5YlVITENoSUlnNmhQMnN3cnkzajEwN2ZBZGJsK2ZrUWRhK1dKWnZUTUlX?=
 =?utf-8?B?UFZLcHcwaEJJcWhPV2x1bXMxaEVlRmZCNXk2S01wbVZZbWFKNG0rbDZ4ZG1u?=
 =?utf-8?B?WlkwMGUwTXNGZXBxS3lmTVBmVWRLT1lTbXRxWjladjI0eVFxYlpmQUF4T0I1?=
 =?utf-8?B?VkVVb1dwV09GZ0Z5SHRZcC9PVU1qNXoveUNkTTFQdEJmY2RZR1hYSnVkTmND?=
 =?utf-8?B?dHVEdlZsZ3ovWFlLVlFyaGZBWFUwRlhmbWZROERobDFKOFNYaXMyRFJUWDhi?=
 =?utf-8?B?TWJINkh2RGZKa1l6d2x1TkFFVENHQ24zdVZad1V1NnZMa2g0cEVRUmNWVjha?=
 =?utf-8?B?Mm9tTVh6OERlcFFMLzNUZU95eUpKUU1mR3NnQzA0R1BOcEFpZWFuK3ZoRVR5?=
 =?utf-8?B?c1lQM1VpenE0eVZueFhsZXFVS0hwdzRZdmFTVnNwVjFxODNWOUZKckMzUXF6?=
 =?utf-8?B?RlNvZ2FwaGllb3IvR1F5cEhmYU53SW5IVk5vUUl5ZmpSOTY0YU40UnR2bE5D?=
 =?utf-8?B?M2pCZGlvWlNpZkhEallFQTlSckJTUnlwRFlacDJMajhLU2NJZ0ttNDBieTVY?=
 =?utf-8?B?TktLYnhDVktKQUNFYTZnZUhBSzlMb1lmc3RLTmUwUUd0aGNzRGhpdEhqaERR?=
 =?utf-8?B?ZjJjckdFWXpCQit4d2p1cjZhVDBIdEJieUx3WmViL3hJTmY3TTcyYUpKZjZM?=
 =?utf-8?B?ZkVXZ2tyRzA4SGtFaGlNZVZ0ZTlFVjlsZThEa1Vjd2lLVEFZbU5uZEpJVWRu?=
 =?utf-8?B?eE5NYWZTbjFmd0JyaHhsMFhIdjhpRmF3MWlwVUNkazlmdGhnNWFEdElKSUIr?=
 =?utf-8?B?aDM2aXFSU2pCNkNOa21IcU94OVNiejRLMWJobGVKL0FyN1IvS0I3OERLVG5Q?=
 =?utf-8?B?blNWREZQWmRDb2UzVFdlWk0vTElwaWdlU1l6eVdVOHByZjJCbmcvdkFPeStL?=
 =?utf-8?B?WWlld0xuL0RHSFBXSElMSVBKdkJsNk1hR0NObE9zZG9ETFFNSlFBbUdCMmFH?=
 =?utf-8?B?WDB2RmpPY08yTE9PaXAyVFBWcTduNEZ3dlFFVjdhQ1V1ZmE0dDNHdFZKVVB6?=
 =?utf-8?B?RjVJOU10UlZic2lFR3BZQmZtVCtKNFkwbGptRGJGQ01UQ2p3TGxFWWZtdHdm?=
 =?utf-8?B?dU1ieHVZSU9iN2Jsb0xabXpaYnd5aHVXakd5ejg2eUlrcGh6U2dDd2lpVVNw?=
 =?utf-8?B?cFJoUG93VXR6V1lZQngzOC9VMis0L2srUGlkc294NzFOaVZJSGIvSk4vRnBm?=
 =?utf-8?B?aHUxN3ZmMzlTUkpUNWRMeGVQRndLRk91STBNZzh5Ri81Ykx4RlljZz09?=
X-Exchange-RoutingPolicyChecked:
	tsN/NdwQUHc/xXtPga7fzQ/7D50K3NgxxqiHnmGqSFiEbVIsaRjjCnKx8u2y+Vzfk27ymTIfQPbTCny5ZW4dp9dELnH18Kh4S8Sp4n609g1Js2MiTihnIfcLhO3GPMAnevwyhYTdovdwlzjWT2xN1vq/VHL2631et40Tvkkc3xZpqt3iiR6CVIoVSmyLZQpdZ/SLi/d+OCrFEwnbjkQQWaYdjm8E0xWa0qqDMOkzXAjsJFyqTgqCtGdPD1Svw8oeF2ZKlVOBVh53N6zJcm1nOOq4RPkJoIz/I6AtV8S4v/QrPNeXvLUKEYS6eqETxkoZtr1otiuD9OdZPwwvpkynSw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FRnBLyjOKy+4ZOJb4b7JIcbKNjQ6qxRsN+pag7/1PTW1MYXK8ebn7GNsOHV4ppFD1HlVt+BoqZEBufWaBGwdZgFEaPv+jdOZilGZxRMqrFWx9qybRdt7wIF8VDsFBfbdsCyvntRHLER5VLcGmsZaQdOc11SRdBfQn1Y6BBerW2AQhDHnioIfKywAlTajMlxNy8gW6Hbz2qYMb5fjQkD6gI+ng2lh6AvfeSdCnC+bWeo9l2gbqDs/eC/oNhzBEUiCFki4LB2/9O25k0TDfrJ9f/+nh70q830dicUcIiHcAfB87e8Q2VLiMKAGToZsH5VDMBtit8lsZIADCpnQa5MdF6uJptKWNsbKeafkz64A/068hyy+xl9Z/vufJ51QupcW8Mo8RN4r7lqrcWTCy1rG5S8GicR0FKVwy1vGVI5Go/UvpaCICR1evvnasMAJ9m93qZZbbGTUixg5voOr2ER8Sg90WWWfui+is8CmGWybOByuLMfM4bngAYwiCul9pzTrGzwTZtO5IufY87z5tx7SJT6Qtz06ntJcD9lf93pf86KyZVAJgpyOmTaaMgjPTFmLwmGA2mdl0nT5CvTN4eF0/9NhK0IqxdEJXzfoE25vxkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f648605-92dc-47a1-4be0-08df240d13bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5510.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 00:51:09.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0kpQGPtv1LaIemFoO73DVmYpyZtwUwC+D0fkgb5pa/BhwoGm9c/aO7WUEJSzrggMR5GrRzm/eVSTQt2Kydl5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610070003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMyBTYWx0ZWRfXxO0xG0wIJ3t1
 Q0QUEu+C33wReLKomc3xYPAAvp9vFY4GkPbUZyl2gDpI66jI1x+NqR94sO/rzwzW3ngyP+LIz2V
 3x1I5F9hHcH8EC8MZ31gCJ8P2igKGXnbmV281bgJuCNaFbOynBdVX/CISU+nkX5+Ztx5DhbwiSs
 zFF1C7FTpWMtVJX/MvHkypYAYp4nVoMJhRBlRiSfU0UaYvXRLy4VSVpZDrGuM9QTRNlsg/HHjJf
 63vMk5kQW/65zapdH0NRy2Y8v6bDpzRH1kiQcxPOgsQQhXqqOB+jzrIWXtaO6xta4kNex3Ckn9C
 81CAKg6shiEWVMRgli0GX8jxyf2BW56vXknu2BOcqexxHMBc9Glj6QT0mya8xhalCLRFN6qio7i
 ysDmjGci8Sqvd+EehxquB/Kyx2Pg50mcU7kfMeh5DNXsgoLf/ZFFutL7/CP+UMZ2w/PeR7X0lJZ
 yRpDWjzH9B6QYOQXrKQ==
X-Authority-Analysis: v=2.4 cv=QMD91QLL c=1 sm=1 tr=0 ts=6ac59783 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=uherdBYGAAAA:8
 a=9AdMxfjQAAAA:20 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=BoeeIxEzsqvZZbcfIokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: P6U8R-XCFJ1lXc7chfzvJNioFMgTYBPS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMyBTYWx0ZWRfX35GkEkSt3tYx
 IU1ydqI+RAbXvKZHwEp+N+JYaFlNBzkCAH6P+bdkfig/JLsBYikLpSIUFFSfwdvCWobmOqTaQyd
 JztI8QAPZQbL92rOA00tYIngzgDRS04KcUrIeHOZQRvg56xv3g+l
X-Proofpoint-GUID: P6U8R-XCFJ1lXc7chfzvJNioFMgTYBPS



On Tue, Oct 6, 2026 1:41:05AM -0700, Sandipan Das wrote:
> On 01-10-2026 16: 42, Sandipan Das wrote: > On 01-10-2026 16: 35, Michael
> Tokarev wrote: >> On 10/1/26 13: 43, Sandipan Das wrote: >>> On 01-10-2026 15: 
> 30, Michael Tokarev wrote: >>>> On 10/1/26 11: 54, Sandipan Das
> 
> On 01-10-2026 16:42, Sandipan Das wrote:
>> On 01-10-2026 16:35, Michael Tokarev wrote:
>>> On 10/1/26 13:43, Sandipan Das wrote:
>>>> On 01-10-2026 15:30, Michael Tokarev wrote:
>>>>> On 10/1/26 11:54, Sandipan Das wrote:
>>>>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>>>>> ...
>>>>>
>>>>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>>>>> it starts showing up the rotating circle (which shows boot progress).
>>>>>
>>>>>
>>>>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>>>>
>>>>> With that, it boots fine, just like before this patch.
>>>>> I checked current master too - same, +pmu fixes it.
>>>>>
>>>> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
>>>> it. Linux runs a basic sanity test to determine this. See:
>>>> https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/
> x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!
> PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$ <https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$>
>>>
>>> So.. what do we do with all this?  :)
>>>
>>> I kinda see the intention of the original change, but it results in
>>> non-bootable systems (linux too, as I think you demonstrate above).
>>>
>> 
>> Because of the sanity test, Linux will boot but not register the "cpu" PMU.
>> Perhaps others should also run a similar sanity test on PMU hardware rather
>> than making assumptions and failing to boot.
> 
> After looking at kvm_msr and kvm_cpuid traces, I see that Windows is indeed
> getting #GPs upon accessing MSRs 0xc0010200 and 0xc0010201 but it is not at
> fault here since it expects these MSRs to be available as guest CPUID
> 0x80000001[ECX].PerfCtrExtCore is set. This feature bit should have been
> cleared by QEMU when "pmu=off".
> 
> It boots up when "pmu=off" is combined with "perfctr-core=off" and
> "perfmon-v2=off". The missing pieces here are the following:
> 
> https://lore.kernel.org/qemu-devel/20251111061532.36702-2-dongli.zhang@oracle.com/
> https://lore.kernel.org/qemu-devel/20251111061532.36702-3-dongli.zhang@oracle.com/
> 
> Dongli, Zhao,
> 
> I see a discussion about compat array at
> https://lore.kernel.org/qemu-devel/aUEXkDDOba+oZ4v+@intel.com/
> 
> Is this ready for the two patches above to be pulled in?
> 

Thanks Sandipan for analyzing the issue!

Hi Zhao,

I noticed that the machine compat arrays are now available. Would you be able to
send updated versions of patches 1 and 2 with the compatibility property you
suggested?

Thank you very much!

Dongli Zhang

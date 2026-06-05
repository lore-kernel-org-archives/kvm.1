Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171423CE4B5
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639813; cv=fail; b=Fumg3uVaUeryqRqTtGVqFDn9DYQxZ62LyS3s9aTyUmYh3tVHH/Sb/cykJYLKCFyf8ZiBYWqtA9df7asKYW9JtxktS4XSLCfFRxtMCU8LR+rs2+38sxW8K607WnWhxKJn3A1pChNvuLYs4nYez93IiD8H4PKriLgLiw5WRYnILuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639813; c=relaxed/simple;
	bh=d2Y2tNCOymlt06Ha5UpzAJ2BomapJcRfxueZKKadBpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fj1pkowDUF8PCVDR3RfhNbQMr0vcQ5FGO1Lh0gmzxrG4hbBoyWFcq7r28sPLD6dCIBwjAcQynCO5Jc8fKTBllSk58lYdoOWphHGzEyePcq642uYBHPmcxbM93tXGuGLcUicMeQkgw0K1aCZunbSoSNa3/VR+UeCdx+6vNxZFri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nKnLDWtS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4dIMHmM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nKnLDWtS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4dIMHmM"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NbdCL441942;
	Fri, 5 Jun 2026 06:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/PvQRRy9Ur7x26yl+UlPpT3M70CBrhru+Wb4unWazkw=; b=
	nKnLDWtSbZozF7O1/rPRDWTlqPP++AhDc2aYJz8QA8dhnqOokJo2lu1cLR9JPFWP
	xPcS3PIBtGrBDYmvSK7gKcheeEFigyrUA63kakx+z4XEMQLWKbb/02UoktfHtJwn
	6ME2e9W7VSu7I+MzuZihw28MdGLhhv/WyYYxGrGMVcs4sFNPZeRNbXJf8n9+JrPI
	2l3RGuqUI7vmIdgdS1uOgRV/N6wgh6e253WAMFl/LOoSTqDuAIDkF9EUIH+ogTJC
	dDK9YGiOdKO/CYMXetqCCRR+K/g58XKbXIqnPONy0wMBQsk+ZiSmTtxcCuF/i8N3
	wiahdaLmGRE3t8M56M25Bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efptbsevq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 06:09:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65569sTO039554;
	Fri, 5 Jun 2026 06:09:57 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbghfh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 06:09:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYPcDvlY19LiJzjA/mvmQSodNstqH8ryy2ZFi8B6dwVYRb3gVxHlGRWTXSm3JbOy22Iz9TQ7wwqvEACX2Hg7AfEdYa0x8u0dCEE3S2byehCyaqs+TeO1dzk89dIDmqNhfpI04GB62cnJ6mgE6EWFwJtWkmsQUUmEhrRMicW135a3ixqO7XMvafxCFlbBEkLBBQlTNGlItF5Nednd0eZWtTf5OThbavMSsh4VMZu+9uxQvpdNIluI+Oj8mXDiTZNgQ0eN6Bm0ccuifjxt8qJ854Af6XTRtAAFguiAta/9u6IJHvjvJlx9e4lxGP687ttF3I36KUIQxZ5GXS+IhAhhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PvQRRy9Ur7x26yl+UlPpT3M70CBrhru+Wb4unWazkw=;
 b=casyETA+dTIVQhkaNiVoyULsxsD3C6E5v8VWWGfkUveN+0NLZatmQU6Ha0+Ai8UL8Rxgu1Pkuzt3MEoAAKGa04xq6WBEovmCZTxeHItYLAB+PWtx3F7hdaNgdbn/ynwp5IDY4jakzV0vWpsSSN8yyYRz1Mf4Imarurl/LMjDrvlYCTAl2MFyOT4bIEmCgvnPqTPkBPsDxJChJr1KZuEhHNiSt03GpSt7Jhj2czhcL8wsz9rJuJ/wZPnG46YvwsEqQ2tkVRQrsBWxbTiIPA52OKkoloAsMEmrOjx9+7efBeSGmRMpuCmtNfZ5hMAQRPNc8JjBWGvYYBmiSnJmFGk0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PvQRRy9Ur7x26yl+UlPpT3M70CBrhru+Wb4unWazkw=;
 b=h4dIMHmMgIHfIqua8dXKc7mUkQ6kyr2lY0dFyMc3LHuNNSZQaY3nOrKBSQzRIodGbZbdK1wM6YTAtA+LrU7qwI7MLV1CSJaylPYH+T3T8mfWKQZp0N/TzlylA+4oyswoe1uqVtnh27hFIw96rtW+QaccvdFu3GYw5EiFSTOIB4A=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by IA3PR10MB8759.namprd10.prod.outlook.com (2603:10b6:208:574::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:09:29 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 06:09:29 +0000
Message-ID: <8ef34509-4f83-4c7a-b2e6-24015aae88dd@oracle.com>
Date: Thu, 4 Jun 2026 23:09:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
To: "Chen, Zide" <zide.chen@intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
        "Liu, Zhao1" <zhao1.liu@intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
 <CO1PR11MB5091E0F44CAC1B8DAD9EF085F356A@CO1PR11MB5091.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <CO1PR11MB5091E0F44CAC1B8DAD9EF085F356A@CO1PR11MB5091.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::8) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|IA3PR10MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c46eae-6054-47d2-45d5-08dec2c90074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	W5yuSMcqw4sTux2asauqUZmSrZmNxBYq+y4imh4vXCtQo7345iS6WSk4iXlG1GCzB8peIHOJpaGDrGDY9nmZchcMZ4821uZCrdtAQnq7qMWlfXGBH/1AG97kkeJCuYg5MdyfJDsIIXKCzaetReci09MclQXE4MRdNe2V6+D+iOkj3zKHMWDdC3drqAkxGirqUJyueaZyt1Hnc4VCyzsxAoFYeJ0LuEb0Ptxg+xg/Ng6JoY0+z4AB1jOF5/W6MKTn92/5S0gxcrdY1CfHPaXcdUEIBgVJNqBOiGL/aibIvnRpIPZLCLEPUiLm8bgbtaueMN5IXbbFXad8pHBZbIh+fGy9i0MEERBCKjDsO1CuIWrPB+D7w4ZKBrl10PcuoXgQV/SDEFmxMUphdIY8f6h6vdspivlwshck1Z0KWPys/t3tuIVFwcqKs4Km8mYmFsklD5k3/6r4Cif2nSYCh+20oG7oLfo6u69VwPBpbBEhV0FGfQrSZ6Ty743PA6lINwsveYKYlEadNNLpoU/lFO6OJjog94Y1yJ8QpbWeUm82VW3kL0brhDBBqZKzrp9gPGprIU1/JXCBXT/Dq+IiGlFBuWCJmKc5j8f2VZ/b58a4uqTeQ+BXzf6UyKd1aDjDXw2Yjmhc6Tt6CGegyTzsExgROOjHnz1EHXKmu6IY5K4tyQRXghsKoYh40AzGnbIrqmEo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjhjZnhyRmtjWitCRGE1dXdFRVNLOVlPSDM4bEJEWkE3QThlUmh2bVQ0UWFU?=
 =?utf-8?B?WEpaTURRYkkyNE1YSGVvRzgvTkxHUzhLZHFKMElDT0N6NmpBRG9WeDJreTVJ?=
 =?utf-8?B?WTV0Y1hrUCtvM2MxQ2s1ZSsxcTE2VVYzMVFSYkorSDRVL0ZDOWMvV0lFZ0VT?=
 =?utf-8?B?TUZIcEl6U3pVUFVhNW9KTC9lL0pUaW9teUVqeUZoNml5YjI1Tnd2SHpNaHJv?=
 =?utf-8?B?bEFhUW1hdTMyK0dQVEsyeTZ0UHN2TE96Rnl5b0VhRDlxcGdzWmsxZlhvbFlR?=
 =?utf-8?B?WkVFRzh6WUlrZVZveUczWHJCczdFVEd6K0psSVRpR2I1TFBsM0pTYkxvN2xy?=
 =?utf-8?B?SUwyRmZCRXR4ZDBxVU5tN3hHdWpPanU0cWliRGFRSGw1bkY2c2lVSm5CNmVn?=
 =?utf-8?B?dmlwZ2h6aSt6T1U5SWUwY2RuSW1lc2YwRWM3eTdCWjZHbTJVNGxqYnFCT0dP?=
 =?utf-8?B?d2VOVVhEZnAwVWxURGpMUEJvaFpOMElGcVFjNFdKd05sRjhkVWJyT1YzdS9D?=
 =?utf-8?B?SHdXcExRbUtOcW5ueGpsN3U0TTNvT2poM0tMUUYxU1BsU01XTXFrSHRyc2Jh?=
 =?utf-8?B?OERENEtiRkJGOWUzNmxPOFBqMHl3SHhxaENrdEhZVDF6Tjg4ZGZqaUJOMklw?=
 =?utf-8?B?WGhKcGFPb01kN1loUE1zZjBOdVN0cDl3NFdIbGszV2podnNLRUduTWhXRmpB?=
 =?utf-8?B?R2pZaXZvUUdabXQrbEJVYVVQMURScm1HN0IydnJXdkdLanF3cE4vWXphdURZ?=
 =?utf-8?B?VSsxU3UyQWJnajhycDFOTzIxc09ROXBBbXpqeDd4TDZKNHVoT1M1YnNYaE9S?=
 =?utf-8?B?aTRKaVZNa1V5MUJRNmIrQjRhZWM1bElUc0JiSlFQYjRjak5RTUh2Qi91SGxL?=
 =?utf-8?B?SFdBRjNqWDR1eWhEUWtPWGRiWUlOdTZHME1pYktlNkkwZUtYTm1DTm13d3gr?=
 =?utf-8?B?anozQ25EampiRFlqRVI3SVZoQ2pDUzRYOCtJemFqbnN3MmJKY2RLTzNIWHl4?=
 =?utf-8?B?NlRiSXJvUU10MExCNGdoTzFBRHAyWmdLQm9nUTJCaW84MzluVkxrb3oyVGht?=
 =?utf-8?B?aHcwODBXOC9UT1VxeU4ra1oxZU9EOGpRNmx3andkNU1udjErcUZnSzdUc3Zy?=
 =?utf-8?B?TU5NdGV4ckdXdXJVQ2xNczUydFZuV3poNUJnTlVsVDFLczhFTjVuMFJET2hH?=
 =?utf-8?B?RGlDbnJzdFJOZnNFb2RSOTR2MUhUZXlzZnZpenlSMEsxcjZtdFoyRVhVV3o5?=
 =?utf-8?B?dkdUL0tCQzFWYnNDWXpIS01VT00xdUU1VkQvQUduWmVMenJISjNrWU9Jcndz?=
 =?utf-8?B?YTU2dytNK093TmxNWXJ3UlBFUHpwQm5PUE1BaTlqUmFxRmVlMUQ5bGF2ZnR4?=
 =?utf-8?B?RmxQdFN5S2pFY2lvcGpvVmRNMXJhcWlFNUtqOWNXMDR0SjkybUNPV0FLNURV?=
 =?utf-8?B?cWV1ZnM0SlRuYmNWV0lndzR6WkZqaUVlb25pYzBzdk9WQnJWZC8vWm1kK1dE?=
 =?utf-8?B?c3M1dUgrSWJpQnJwSmx5OUM5RzBVMy8yR3BwanNYOXRUeDBaZGR1WE1MUm5n?=
 =?utf-8?B?MFRoQW40YnRVaDdZcnpMbmlHdzhiMHZlRmxGcEV4UGwxOWpUNjVTemRBaHJz?=
 =?utf-8?B?eXhkaXcrYk5ZMGtSWEFBWTJLQlVtRm10VW13RUZFbXF4V0lvVDF1K0VGOENQ?=
 =?utf-8?B?dVJhaEdlZS9VN3h3eUVrMWhKVGZ0Wk5pUUhTWVNpZW93VE5zNEpJMisrNkxi?=
 =?utf-8?B?bUR4LzZrU1AxRm1yYjdzcC9uL0FmWm1lQUZkbWgwTE50VCtmdE1KWVVlT1I4?=
 =?utf-8?B?UUJuL2J3S0sxQ2ZXbCtmc2M3aFMzanV0TFpqU3NnbzBvMzVTVXcxR0FwYmdW?=
 =?utf-8?B?STJyQ0Zhd2JVQm5kdTFSRDVndUt5RE43RlJuS2xTNjdqRlNoSTVSZ1NJTExs?=
 =?utf-8?B?WmJQUHZLVHpvR3NhdTZRVUFvd3owV1h6OFFhcTd2c1JJOUlkenVhdkF5TERY?=
 =?utf-8?B?cmtuQ1haRksvK3FxK1A4RGxDWk05ZFhSWVFpOWNDeVJZU1R0SDdIeEVTM0Ja?=
 =?utf-8?B?Qm9MNm5KanpXM2hFNVhwenBZcTZMYXE5OHdPMVBoUTJaK1VMSysxWXJvdHo5?=
 =?utf-8?B?b0F6c25NdjBhZDA4Wks2MmliUlgyaUhFZjlTT0RkOGZPUnhjY3hSRDBZa1E0?=
 =?utf-8?B?RXJHd0JhWms0RlJjQWVyb2pPSkEwdERLeWxuMGRqVC9jMkhPcGN5U2lSaFBE?=
 =?utf-8?B?NVRuVURhQUdIeGRzQkZIWFJ6dG1zZTNBNzdiblF1dnlwd0tvdWhsdlFtWHJJ?=
 =?utf-8?B?ZU1kM2lEZUo4UFhZUC9jRGVmTTlOYlF2V0Q2MTZOUGtXYmlQaGp0RFVHRzNt?=
 =?utf-8?Q?CSbk+c9XwLvAR+2w=3D?=
X-Exchange-RoutingPolicyChecked:
	lyI+2n13ALO2OlGv/m7gdPZ4zy5LJeB+mwurXbemmHwc1fQEunvhY5IkZxsSECPyyAecR60LM0oej3Hhobwv1rmAjtMMivgyoU7yo1eMpxu15MgYaYpaGAzNIL1mmjpd4ubFQySN+wMgnpGQ7k7OIWxGEpAHgXRtbYmPNaX9vMrVtY2GNd/jAtd/tGCIfzVD6/UeBMyg/xGdLl/atZ/dB/9cCelcp6yjyTstSg7i8l3VIxK9NszslYRc5DEJ1fPiK8IOb6P8G7YH/y4iIba5piNoqs2TOdmInUst8f4AaT8hZ9jnTYLfc0unBQaoZdOVdIbRJAJiOqk/y4NNN9db2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Uxz9L8HfXZh+l33P0UFdN/ujilDU7/w9Nk7Yu5+uEHGU+H9fxSbofA5V4MMQd8ySagyQjn15DnfxeZPe/rcyht+voHxzVCER1qtn7/6oYwNDSdYHy56VPjs649FOVgJrt+MdLa89QrWz4PTqu/dP4ptrbHLfK/VXu5VxxGiinHj+QamQD8TGLlEdV3kuhdnnlr+MJ0pbTzjfaOqrxj8iBx0eO3AB+5JA2s6Fy3kCjB8jkdfjZAs3OhylVrBnjnrG3Xa9gBP5aLMqarzBGvNu83GSK26Fah+ScHh4HckCgou13kNN5uzPKZRXv7mL/XDjqDgc15sdBcJ1r8urPN6o6Cky0FcmkxZN4tzqcTU4hSelmL7Sho8zNxmHzefhXSTYKfbNNFPQVGGn5l4+GVEcsRv6HlVB/LQsK6gbK1mXIUvzM7xa+OJleXmhWlPG1xDGKIYycdMjvuollXQU96MCvGAM/kovENbgL/mQ0aMS84pJDsYok+UbT0+bxQAvJ0oPKWRucRWnvwa4btOBQMDsAxxy5o31utP7Nrn3r7bJsY2P7E4RYElIHy/Nf8+prXDge6mPHs+kr0dqKeaIkYkrZw2r4mkeg/kuDdWpZdCftY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c46eae-6054-47d2-45d5-08dec2c90074
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:09:29.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba5GIY+/SwhMuqIJMiPdcbI/rY9CxJLbQhENt4dirVX7QyPVU7DI3vMFE55ATb4eh0utgOlxOlhXbnMDBsPjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606050057
X-Authority-Analysis: v=2.4 cv=I6dVgtgg c=1 sm=1 tr=0 ts=6a226835 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=zd2uoN0lAAAA:8 a=TJD7A3fHtCaaXPdfes4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ja1yx90FXrE3xDf94gndITMwYJYwPxqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NyBTYWx0ZWRfXwDrQoGi6cAad
 Il/4T37tb8ZxIXy5FMwvnFIGrBepPKLbLNFR869vnqbvgPMQ2EVdt09VuWJvBKG0bGddN/kfgpU
 hDfJ/dEHcSmcaCl83R0L2O70ThtaL2XhdsCbiRz1+YlxEIwQ+PAIw4VC8ZDOjtHnAHTY6Y0MP4x
 iGUWju3DZbo0xpYQgvX6aMNon8iLIDOxK0+1qrb1+Ck7EmzR/DhBYZgebAARhhHeWvW4vEF1qED
 NbR2T12ZzUz6BgtxfF6qQMUmnHLg211NBY5IUUIIhEtznzbywqV/DLsAgjVZKUUFMhHLE99UjuL
 APUPdc5NY6ZcbtLUQZ4yqvpDRNBB7GyD6N3rtUs0jd8hDIUJuRIVWPhMuVmJu0soqnUYN98brRn
 kU0knT2fkFfzVhZhJo4AZ29+JtkuCnMyj0g21QBgjtrr21X/4+A7pb+7Lde3fJBHvPTC1CEA25N
 AuOKmRW5MFBwrKmnt3A==
X-Proofpoint-ORIG-GUID: ja1yx90FXrE3xDf94gndITMwYJYwPxqZ

Hi Paolo,

Apologies for bothering you.

Would it be possible to merge this bugfix? It has already been reviewed by Cide,
and I have verified that it still applies cleanly to the latest mainline QEMU
commit.

Live migration of AMD PMUs will not work correctly without this fix.

At the moment, there is no actual out-of-bounds memory access because
MAX_GP_COUNTERS is large enough. A recent patch will reduce MAX_GP_COUNTERS to
15, which is still safe.

[PATCH v4 3/6] target/i386: Adjust maximum number of PMU counters
https://lore.kernel.org/qemu-devel/20260604025546.19378-4-zide.chen@intel.com

However, if MAX_GP_COUNTERS is reduced further to fewer than 12 in the future,
this could result in an out-of-bounds memory access.

Thank you very much!

Dongli Zhang

On 2026-03-26 9:44 AM, Chen, Zide wrote:
> 
> 
>> -----Original Message-----
>> From: Dongli Zhang <dongli.zhang@oracle.com>
>> Sent: Tuesday, March 24, 2026 7:13 PM
>> To: qemu-devel@nongnu.org
>> Cc: kvm@vger.kernel.org; pbonzini@redhat.com; mtosatti@redhat.com;
>> dapeng1.mi@linux.intel.com; Liu, Zhao1 <zhao1.liu@intel.com>;
>> sandipan.das@amd.com; Chen, Zide <zide.chen@intel.com>;
>> joe.jin@oracle.com
>> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
>> getter
>>
>> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
>> behaves the same way when PerfCore is unavailable.
>>
>> However, once PerfCore is present, AMD PMU switches to an interleaved
>> layout in which selector and counter MSRs share a single alternating range.
>>
>> MSR_F15H_PERF_CTL0 = 0xc0010200
>> MSR_F15H_PERF_CTR0 = 0xc0010201
>> ... ...
>> ... ...
>> MSR_F15H_PERF_CTL5 = 0xc001020a
>> MSR_F15H_PERF_CTR5 = 0xc001020b
>>
>> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during
>> VM
>> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
>> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
>> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
>> counts and env->msr_gp_evtsel[] holds the selectors, so with the interleaved
>> layout we must translate the MSR address back to the logical counter index
>> instead of treating the interleaved slot as the array index.
>>
>> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes
>> past the end. And in the reset path QEMU simply zeroes everything, so that
>> use case still works.
>>
>> However, the live migration is broken. The PMU state is stored at the wrong
>> indices, so the destination VM reloads mismatched selector/counter pairs. Fix
>> the getter to use the logical counter index rather than the raw interleaved
>> offset.
>>
>> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
>> reset")
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
> 
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> 
>>  target/i386/kvm/kvm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c index
>> 9e352882c8..b4e549c62b 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -5239,9 +5239,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>>               MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
>>              index = index - MSR_F15H_PERF_CTL0;
>>              if (index & 0x1) {
>> -                env->msr_gp_counters[index] = msrs[i].data;
>> +                env->msr_gp_counters[index >> 1] = msrs[i].data;
>>              } else {
>> -                env->msr_gp_evtsel[index] = msrs[i].data;
>> +                env->msr_gp_evtsel[index >> 1] = msrs[i].data;
>>              }
>>              break;
>>          case HV_X64_MSR_HYPERCALL:
>> --
>> 2.39.3
> 


Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD2381B19;
	Mon, 11 May 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534848; cv=fail; b=FnaRpSjBlB8lBqSBhvbrxfQGBNNxN6PO8e33ZKmmmiroehyNbeyKjNAy1QV9maPxwosBFZveo2VFlWeQRhd/NEOdsjbRSSDk3k+VeZhtaOU4pAXfazDHFJawjlQSn1uVHLcJy/IZUedLfG5sbCVfMw61y5Q/2bjfcPw3LdPnyHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534848; c=relaxed/simple;
	bh=UZbtYEA34IRPimnfFdxof6tl742gnj3l2znL2kDTNUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTRgpqf7Cvhvitd8cHNbh5Rgcj8CB0us7NqPcE4B5YhB5liqbMvy3j2GbaaYqNkK6oEAebb4F7yOvU+3ZAAsjkpfsHrJXK4ac131pWqaUh1GoXDzbS0xvh/mKK3F5NhVUZ+qp3APpipR8eMwMUIBBm91t2PVHqppRorrg61c9do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IbK0STRS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xhoYX91u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbK0STRS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xhoYX91u"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK8DO43808355;
	Mon, 11 May 2026 21:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KjvPoKUkAg+P66aaJIk+KqUyaIIOKgwnn3WAgz3CZu8=; b=
	IbK0STRSo4j5QifwXK5RTs99NJz/Dg1QG1e1ya7pnA7AJIZNHfUi2ZVI64lYCFtG
	+rcw0Z5pvyEM48BkTmlmvb+3uQLOfiNkndK/1OFOfiWzVatn/+9FaYtsefw/7CYS
	u1xztNZqqNM4OK/YwNtXxZro7dowCGHDA0uhT+I44jHHf05K8Ps9GJTWso36PXh5
	qJXleLCIgfclvngcs9ULzRjyzWo4T5QhRKbyIP9A6GeJ27p9/B8qnmdSBz983m1E
	UIYo6pACB5j6g1AhYpKuj16quJ5zGZs1k7yl3spt5T8vd9yvjz8zvts1BLHDU4P0
	tEmol/bbZV+J3cu4h3vJLg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv1g4u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:26:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BLQGB8018428;
	Mon, 11 May 2026 21:26:46 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne9bj13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:26:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoTEvkfZeAeV/dxzTLxzjzsbRzV9khuDGlECg28CiaBPfghVM129rzXQyM3wrJpIbuG3RpcETgq+ZMgPT4CjOjzXo+TSFVsQoXfEb3jv6/GdFophnwDzY+HYbztsrFh9PdiRZqXQYD3495qbKKvWAGgR45xoayR9BbUWhwqeY79p9EoqCalkB8V8UfCUL5zP1hs8YUtUrEJecmi3gltS8xjKPRT8CFAHrsK6vKsYmjrLl7C4+52ONWaWYoywpOYuxyH5+3SCrv28t0bTecU+ZV8bBaaMGFaTdbvjRTyFEL4tyhS4fcQeF+p+B5ZD0LdpBTvWtWPqNI+uiF5subd9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjvPoKUkAg+P66aaJIk+KqUyaIIOKgwnn3WAgz3CZu8=;
 b=kuQzCCS30ooJuLAJYZbUZCFrtif2ohGn2+AVfdmdrnARUhcO1pw2vqNuQ4BBHJn9VzqidzVBcgIno1/SL3IBIg6ka+ENnSv3phsEfdUBbUFpwt3WeEI/Yv6qOokdx9qxVCjgG0a1fSJbGU98wrN8oZaCcOUYfAMlu8fNvrkkUjYHwzopTf69MsDwu9/Iw5ernZOsdcGwJM8qnbdewTbraL/iS3Rv2m+uAdv1O2VyDpKLyzyzkGgbqzHsJHixFjtiqqeBlVcIHdSymsekJqwwq2d4o+jfWy6eiByZ60WmtDAUuqSzYQCdcTFgXkY2CcyRE7rKfpu3iwUCYk7twG8MEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjvPoKUkAg+P66aaJIk+KqUyaIIOKgwnn3WAgz3CZu8=;
 b=xhoYX91uD0EEEWuTc9VAJNgY0zdsDrToShb3+58T+vBm6i0pT9JG8iFHd86VVBDAPSWjCvw31iTycUDq5NS4k9mUQeerpMM+MfFpWJP8gavxAscrTsDdGYy1TWafIqrwpYTjL+pwyDA2TjGED4LMC8GwymkFhqSpBWoJdp2S3oI=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH3PPF67E073224.namprd10.prod.outlook.com (2603:10b6:518:1::7aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:26:41 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:26:41 +0000
Message-ID: <24295bca-fa63-45bc-95d1-5f45ad1e8eab@oracle.com>
Date: Mon, 11 May 2026 14:26:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] KVM: x86: Reset vcpu->arch.st.last_steal when
 enabling steal time
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        shuah@kernel.org, hpa@zytor.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        jgross@suse.com, dwmw2@infradead.org, joe.jin@oracle.com
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
 <20260505003044.78693-3-dongli.zhang@oracle.com>
 <af5mbWXpG5ofRdJ2@google.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <af5mbWXpG5ofRdJ2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH3PPF67E073224:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dc1a3a-7ba2-43b6-1b75-08deafa3fe43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RATYFQx4YqmTRbguKsLWfdMiCmkSNUKBErWTfEQUfMh9NLPybjulSB9arXbJnnt4IVHYFOXB3Z+E1WNPqOiDnK+yG2R0/gteciVR7ElrW7Sh1aHizzZvD/w+Tq0Z1kIRG2X2tOHUM/b19JFoH0hM5ZQ70KakVUeqBrKSlQYSAHVVZ4fBPTSJmJU+k8RbDSDoH92Cvtua8G+RjDLAsBbFgqejDmLFHglkgceNh2yqb4U7Of3PfUEFHD095Mj5LEuEOGNQSf7xCbDGt+xYR/Oh3+GMwdL2xAOhnyqcdpyAGXdQtr0FzuYyYzNCdHSaxHF2ZN6svyD76+PENaelIckGDJyqGbcfClr2U0wTIb8twJl4AVRtAUNd2/pbOT/BDm19vYKpQVzgWD0C7fdbwdeLu03oJFjLfxoW+b08KgQkTED83AWHM9EkM/6QduYsNLjVslEEZuc4zFZTpRmMOr29OtpaOqYCsW0vy0ZQTUJGiQTrvNYshG4clPgVF7/SqJm5JeSIMWsTNJL1QlX+XtdBeRXUX0hteZPhrOk+LEttiYoheN8sxe8DKPQ2i6z79fY8VwuGguGKbe8MQwxC7wLhalvONfryx6LKxAGYcfRPYqOS3U6r/Ht5GxEIsSRtbLg4XC84Byujhen6qcWCXU+cYILFeKHieHLeJJH2OmcEwIrHDDVwRQQtDgN3wRebg3Sx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDZpRGg3bmlRejYxTC8rNFVTbkZ5TnhzNzhCK21xamhoVFRHTVZpUzBNbFVK?=
 =?utf-8?B?OS92MlFWc2N4TDNYdWhsbStSRlVja25zaTRqY1Z2UzhpRGJPUXRKRkc1TWFj?=
 =?utf-8?B?bzBPc3pxZDkweExCY0kyblZ0NW80eUFFYWppUkRpUUhDLy9SckVjTUFHOFU2?=
 =?utf-8?B?UUxmaWFVZkN1RVhSaWdEak96SFVrWnV3RGttMjFxaHhlalRqVUYvVUpDdWx3?=
 =?utf-8?B?T2dpS2hIVDZNelNTalZRV3RsSndoNlowTUt3UGhGSTl5YnBlSjRIZE5EaVhH?=
 =?utf-8?B?eTVBQzBqcmtqcTBxTjdWNkVMZm04aTByLzErOSsyV1RoMmpvWnk3bTBHMmFP?=
 =?utf-8?B?MHYrMTlpQlNpNmdHYXBUVm9KS0ZySzRZd3daWU5odTdYRVVtcTl3dnMrUnZQ?=
 =?utf-8?B?cTR4M1NuSDJQVmZMOHIyNExDK0lNR3NOdGRqUklkT2o0RXpKY3NwbVhHR0pF?=
 =?utf-8?B?ZkpqTmZucDR4enlmVDRLUU9zYndhaTROUWs5RjJSSkNpK1dJRG1jRHk5Ritu?=
 =?utf-8?B?Njh4Sk1pOVRHWEhHR2RlbmpkdXY0anRYazcxU3o1eEx2QXZzcS80bm5FQmdO?=
 =?utf-8?B?R1FBazdrcjVMSXh4RnRPWDcydkNsTmdPSW5qbDV5azU2dGhBWWplL3VFWnE1?=
 =?utf-8?B?MmhpanozZXptT3l3WncvU01OZjVTMVRaNTRTcnBPMU1RZStNcml4VGZESTRm?=
 =?utf-8?B?WmV3S3JxZW9FcUFlU0wvd0d6OU1NWEF1cWZBZm9yK3RaeWN6TWlPR1ZFMG5J?=
 =?utf-8?B?b2hGbGpaTUl3eVBST3A2MjNYN0t5OHJFdmQvVURYOHB2YlIzZG5kR2lvVXJx?=
 =?utf-8?B?L1JBWm1RamljSGtYb3ptWXRVamRPa1pFUEJ5ZytsaDk0Mm9lVmllQVFWZFhC?=
 =?utf-8?B?YVkybGRvMFUwWVQvY2J0c05LZ0ZLQ1RoTUQ4ZTZJbE5oTVFoTVBFVE9uZ2U2?=
 =?utf-8?B?aW90dEJQVW55eGlvS0hxQ2NCNmJhWjR4WDFXREtJQ3NaZ0JGN0xjekJzV2hZ?=
 =?utf-8?B?R29IYWNvM3JNZGdwOGJXbXBtcnpTNmlPRTl3Z0NkL0JDdCtCTEhRbnlwZVk4?=
 =?utf-8?B?TU9JTjE1MmRaY2c1T092QlF3dnlTUFpndVNkVUR3ZEIyd0FMWFMrMWMxRWM2?=
 =?utf-8?B?SkJVVkhpZlFxcjNoNnhNMi94eWZnQmtSVExUUjVZWVE2cG1pSENZSEIwSHpZ?=
 =?utf-8?B?dSswT2FucnE1Y1hoY3Y0dVNZT1AzYUxESTBEQm1LZlZ4cURpTTRVSVV3S1U0?=
 =?utf-8?B?eWdtMDVnUUZPUUU5bWR5Y3docVNmQzRFbGg2UjE4VHJER0xwWmRLRGpXOFBw?=
 =?utf-8?B?V1VScTRIN282OXpQUE9Sa1VGL0tnbWxXUFVwbXU5YnhqWmdDdC9CTFB6Q0dO?=
 =?utf-8?B?WGdPY3RuWUdPajZYNDltcS9wSVM0V25UNFllVEJtNDVxTVpKRlV6SzI2ek0z?=
 =?utf-8?B?UXpaMTdrSThuWEQ0K3p0NjF2RDNSLzlDUDY0TnN0NXpHbXdxcFpHS2V6VEla?=
 =?utf-8?B?UERETjV0Ymh0eXRxYTNGaUtwUzdEUnY4WXFSaUJCa0ZxV2xSSGNVOCsza3hZ?=
 =?utf-8?B?bnUvRHlBTFVlNzYrSGt4VTdnMmhxbENoUFFHTXQzTkpMS2h4cUFUbTl4N3RL?=
 =?utf-8?B?bmc4eFVWejBLWHQ5dnowU1NEeWhYdng1Vm9QR1ArR1liUFAzVVRnYlM3K1lD?=
 =?utf-8?B?WStUU2c2bnhmcWxNWVg5QmJLdXFPcjc2Um14b1h6YkZSMlR6QTlhelhxSkt4?=
 =?utf-8?B?V0xha1VzR0RJcTlqellzUkRCeFJEVUcwakpIY2FBbmcyWkM4dTI2TEt4bm9W?=
 =?utf-8?B?UzcwYlkvZTNtbVV1aWlVZ29pWExRQ21oZ3VCdWpvVGpSR0VEaVRaTGlBOXZ3?=
 =?utf-8?B?eEdaNkN2cHBjRTgrc0RVVkRYSEtSR1MxaUVuanZERE8rdllVR09MZXlLUEwr?=
 =?utf-8?B?bXhzZ09HRm95bFduVWVsSVAvdDNJQjJrZmo4elZrbkN2b01BSm5OVTIwQm5B?=
 =?utf-8?B?MktVNXFUVzlpN1AxV1VWZzgyVjVsVjA4T2ZCZ1VZY1R4OG5UMGFISmcwbXlp?=
 =?utf-8?B?Q2lyRERGUlRRWHdBNjBUUUZIcWZ6Mjl3elE5aFVwOHJuVXNNSWVNSWM2emhh?=
 =?utf-8?B?ZUxIM0FWS3gxR2VLZGcrWDNBK3psUDJYMGRKQm1PQmpOUWlEWndSaVVjTTFt?=
 =?utf-8?B?K0haazNwUmgyRUlGVWFoQ21hL1Y5cnRtM0FlYU5pTmJYK0gra29IL1hMc0JW?=
 =?utf-8?B?Mi8reVc0UWMwUmlyeUZLZEQ2UUV1ZU1WYlFhOGY4L0Y5dXJNK3c3U3dNUlox?=
 =?utf-8?B?emtDWjB2T0xKbnMzVTYvcVR2dkFNOHc4enhiM045eENYVEJsM0FPdz09?=
X-Exchange-RoutingPolicyChecked:
	p98CjNjPfpNYcQi2ek9Sj3tgNUigLRS+re6r4m8NzJ21AX5P0kOvR8IgGpnTQwXlw8GsSD6Z8/R4gmqlgAkBy5S2RYZeAZTZIP+RaGiEuAgECbFag5AN/O9ISsopu4AbG/NGY3FoXnpiP45nBQiTLRACphgkEGpBufgOUxv5fF+MmEXZMKQWPw5bYyPTfcK20apCRAeb6lfnR/L0P96ejIZTlUdqpFUbSiL/Xm3642q84ojW1kgdfK3UBGAv+FVeUft/kHO/XC3OgIJjoRr5rkptMoEOIqxbKl1I9F625MFSimbJXMf8Y4ZamWrxWqE4Sxy52fSBLIzsykqm80lVJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RU1I1cuE4bXhMptXnXokLPAC2CmYPGAne6y+UIfiRlTpjOjtA6QV3+rLYCE5xuShGJz4xyOLebRIfD25c48lJbO+qRN3676TzRqtDIfXo5Olkx1eF/iy4LFSYuAv9sZsdsa9OclR++SsUEtVndoB1fSpq4FLf5PECDAUdUK3g4KSJ8knmCwQMNcEl0bXF5ZsY5U8yX23LvS1xt5LlHGWvdnTu6QaDnkrIheaPcL2VcSrfK69umWIDLsZweum6UzTUXD99FhySkHTx756HtXKZZys3c5DXrFYgHC3PJi6GdB77ES4DV9pj3TJCvMxdbuwkMawxyyxgpIAlpg+KMOjvapb5R/eeiahGjy48HOMmAnwj9wv8CbgH2v/N+KFVdANffdHRLlx+kDozks0ZDS81lnf7qsZMKpFiUOmRU1adcgKOMK1zLTY1YVHX8Cqj6dze8ZayhGyna4Etr1T2TpDGoVo4JbfjfVt/3Kv49ww0Jz1/X/m0/HUNgnInQ4lmkh00hc6VQFNY/414BwTWt0MtCs5Cj/tJ9URuJEkBN/Uk1nMe9SqtledVr3OO9ZANp6STN34ScR864OPc3LXjFV3kHy4NvXEJkRKMhI48xwU9Rk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dc1a3a-7ba2-43b6-1b75-08deafa3fe43
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:26:41.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KuaU1oRdykA9cHLGkF9iEONmQVmkPMAV2ZXkl/WCF+0QjVXnNUZqB1NZorKBkNZDjuFypsA9kj4FDRdyCLLqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67E073224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605110227
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIyNyBTYWx0ZWRfXzrN4UpgML+Ri
 sdeL5Qwrc4eD0uBxxiMgae35InALQRKZcQAp6pY2g8VdRFevTRbPisKOGGCwWku1Uw/qT9AxfZm
 r3E8B2c8gr8g2Y8k/lb7g904zTAnoGMcDZW5ICdA/eMEe+qsoGdxD3JwcKUOucUVC7BFsrCELh4
 L+5eKifs9YFgkBeAwOt4swQy/W9EJS1RW8UF1zn/XR3R5HOsKSVtbkzAzQwn90qg2jjqdUnywUq
 RfBbK2mfaVOFhmvdELaZTKf7w9MjrlgwH0MPg2UD0LCMEmquPb7exsKfyxAfOihhGCpQJ63852h
 vo2SWVD9LfFBY5Y5QkIJHZHU/ggGYcpZzABVx9p38RaSoojS6hsXWu1SzYEvsLiaXSzEZW6wiEv
 c/mrS1SguOoLSYGpiyGU+BJRGaaLMV+P+dxZioS+TSdikL82orc9fBa9Rav4ewrczS0t5moCw6v
 eCroQcxPgQankjaMlcQ==
X-Proofpoint-GUID: A2rimEd220stWB6aoNHlB4w1xS6pByG_
X-Authority-Analysis: v=2.4 cv=JvbBas4C c=1 sm=1 tr=0 ts=6a024997 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=pu8Ebr6csyIeW2ug2hEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A2rimEd220stWB6aoNHlB4w1xS6pByG_



On 5/8/26 3:40 PM, Sean Christopherson wrote:
> On Mon, May 04, 2026, Dongli Zhang wrote:
>> KVM does not support vCPU hotplug. When a vCPU is removed, its
>> corresponding data structures are not freed by KVM. Instead, QEMU destroys
>> only the userspace state and the vCPU thread, while the KVM vCPU fd remains
>> open and parked in QEMU.
>>
>> As a result, vcpu->arch.st.last_steal is not reset.
>>
>> If the same vCPU is later re-created by QEMU, last_steal retains its old
>> value, while current->sched_info.run_delay starts from zero since a new
>> vCPU thread is created. This causes
>> current->sched_info.run_delay - vcpu->arch.st.last_steal to produce a
>> large, bogus value.
>>
>> Fix this by resetting vcpu->arch.st.last_steal to
>> current->sched_info.run_delay when KVM steal time is enabled.
> 
> This is quite arbitrary.  E.g. if userspace hands the vCPU off to a different
> task without going through QEMU's hotplug dance, then current->sched_info.run_delay
> will also change.
> 
> Shouldn't x86 hook kvm_arch_vcpu_run_pid_change() and reset last_steal in there?

Thank you very much for suggestion! I will hook kvm_arch_vcpu_run_pid_change()
and reset last_steal in there.

Dongli Zhang


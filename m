Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4231EA65;
	Mon, 11 May 2026 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536046; cv=fail; b=nXiZF01zfcvSmOz843KmGmBDikSRiw33YL4HT80cYWXt+fOkaBQBd7XyrqWeP1+8xcH44tNw4t+XkFzrgJQbfnF2F4cTGXuxcf4S3KDxy+E2OzGhBhgLYYkHdBU08YfVHiUGAsavWWWzCVqYDJTZwgBfLbsVzKr2/ngkV8LCEEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536046; c=relaxed/simple;
	bh=e4KGGeSOZI3u2+ZsONCIt6zS5u9HLkHLLIc3fJ9dVkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJcmg89570N8taVQauLLWR1IsHvxGxzLICfWllavhsuYv5tAvrnVdoFzpZnrroD/8YhcVa2qL/HHAUXxlnoiLppD3lLnRJnRRM0X3DmCov46Vd2UjsFyS2WeOkRr08RsJYg0H+2OQINSyNAiOg7x3Ja+V3kKxTQ19gpCNE/pqqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyT9cqnw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uTFZSb3y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyT9cqnw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uTFZSb3y"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6lR52046602;
	Mon, 11 May 2026 21:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Wpn0+fHaEYSHe7fnS+XgGo1EuUXBKmoEBtI02JLUu4A=; b=
	gyT9cqnw6xovS8HECmjdv4RPDhhhvsH8AE28jwVMO8+gmW0v2Dw5KDJImFgb4HGj
	wLtfhCl9vnzdOb5A44J1CCiHkD7c3pLbrSy335uGhTTeoAyO15qfjzDtWug3jzsz
	aXkeB0zU2rwbqUMwSp/RPFZh6NbKUtRG5D4Fc0ie6EJ9sQsE/rc1IXEQ/uQIHFHM
	NtWBEou4BYFivAWAbiXK/J0/W0jun/iPT4z/8BshEufPwR0LvI31A9CCr1nCXNrh
	qiaGenGXJmxvddT1MPlnsEh46MAbZXFLIpMqR38bKIxzsQc0lqH9/5//muLlxHDc
	48SgEF4NVH4istJjbXQhKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv2859g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:46:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BLkIIG010100;
	Mon, 11 May 2026 21:46:54 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne9c79r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:46:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI/xGHaGgQF2kmeA4QLK3SSHGJK+SB6dEE4mTzfA/7TMbLUc7b56uGI+qnuw14/PEE9vttFCkiGV/0ZeOdiiYFfVaEZNbPJJpXYZhgdMtHAH5XqeYixAxLyBJoDwoc154DSEszR9Xe5yU9WBljiHxYfNsbOlsxIHa5WD+WOGsa3rU5+Z91ObXq2oWIJaZYwXQ4uPMRk0oJZC6VkovUpffjAQ2Fx1Vq/FVz0MGmCh6X4vYN0+L6lxVcp/my8NGyIQ398mVCEk7xM72ZMFaiv5VYTU535HEqaw02vEt8z+klauJryL2dOx4AmmkzfJhDdQxnV0OH1yUAFUHW1DUI5NIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wpn0+fHaEYSHe7fnS+XgGo1EuUXBKmoEBtI02JLUu4A=;
 b=tTyZe4PHnTk04qptBRx6thlitz1cb5z7Pk1SL4I+0y+BrnQdJjfn5XM8QbAiJll7TlQ4avC8DjLBL9lYu+XLqWfvxgtlPAgQk1DH0RubyH56G3UBHWocrUOnN97RBE6jE5FVbwZzu3lOy/Z+jIobsm1rnh/A4B8Qxmh71R+I+4z3W1llc617n/i7sHL5di5X31Py0SBwIE2EgqMAAzgT0PfsTdBTFWDNLYtiJHPrD2ocCr9b4MdAiEL5VyKoGvfAweIII5BKh3eUxG7xBt9wfpQo/AFN6EMOQwpBAePHMYy4RWtz96iluG+Alqhu4V7BG40Zl/n06nE7MGGs5Esaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpn0+fHaEYSHe7fnS+XgGo1EuUXBKmoEBtI02JLUu4A=;
 b=uTFZSb3yuPw8dcgV3yHO+Xnm6f1ZutI1nAHnQviRflmBpuWLLXRsYe1+ZY0+A51B0mrr3jJ6glvTphnrwAPKtcGiffmnvneLwm1Vvc2ILWWyNbkOUp5Vk6ikD0+z6QtEgiObGnWoO7mNDTBs98YXfavRdGNFrob++zNev+e3hHw=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:46:51 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:46:51 +0000
Message-ID: <87ac4d82-a121-4666-bfa1-8a279133c683@oracle.com>
Date: Mon, 11 May 2026 14:46:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] KVM: x86: account KVM_SET_CLOCK downtime in steal
 time
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        jgross@suse.com, joe.jin@oracle.com, "H. Peter Anvin" <hpa@zytor.com>
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
 <20260505003044.78693-4-dongli.zhang@oracle.com>
 <09b261dafa3b50d358debe1fb13163703bc6e0a1.camel@infradead.org>
 <2C6E66BA-B225-41E7-A1F9-E6B2DAE0B392@zytor.com>
 <87691b4969fa963b332b0be209361d6f206f493f.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87691b4969fa963b332b0be209361d6f206f493f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cefa49-36a0-4718-edb4-08deafa6cf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lhosTeUZ4/xAEl61+CBDQpDwnCuw13XR5hTD1sj2DXVOt38GT0MW3oSZiXDKhvi0s6lPRHtT4VJapHwWzBLJbEPsGZLCKQtW9W/wMSxaHV/IBLbK+PRetEotcnmKwH2iHLDddSBmNlokDGdOSXoOBn3Qtd3WcM+rigko//9QrTpEtdBp3eIOVLjTU8CJ3TWQkCDqEyVlCDJ4QcJxdwDfC/kOs+Yyf/5CQY4+I6u9VSif5uEzphIlk1mBIkKN2/FncLVsxX3a7xMfHRvSg0vtWgtD3k0nW378duGMaXpo4uZfyqnBsi/UBA6dqMYeCiERD0gXvmodbuiBe6Jvytwn+EpdRyWdl/5agWzpAUR0Ni09FZUU3a499k1j1UB/6FPNB/bKOPvLBr1Lzf/l9zlicWWHw0dRiHqMpNTaGrFMNLI98pMoq6O0JVE3jYIYCiAMT6Z4psb19CB255WYbTUHsRgtP8dvE3lbfl9EWYDTGju2MV8lkCChvsAjmooVS2NOuWTVfc9LOL8Z2wTgX30WkVQhuKZwuvzd7Jm+IUlivyrWbBK+fJG9l8a8TztOvVw2b7RrCLoyw35mBfMam0GcM6huLAZMBhdzGor7Gy3R8C11VQbUpDUQNL/i4fmSsSm2pqKmnJwany/B3z+Kgi28LwWNNh5luxIhmgiM2fsX9A6W8QEynJ1Rgfd8nvS9//A6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVmdEFWSXJmdWVueVRlODBJSFF6RHhNQTVvRkc1MEtwUHpwNXd3UzUwMDN2?=
 =?utf-8?B?WHdMQVVzSFpkS2VjVk8rLzUwZEhlU3hNZEtLZEpjaFFvbE5DaVNmdUZWVFJt?=
 =?utf-8?B?Q2NDcWN3NUlxcUFGNk8vQ0RhV0o2akI2c3RlazZJSEphNmI2dng5K0g0ZXFh?=
 =?utf-8?B?T3VPRCt3VDlsL01ZTE9lSHhSMUNPTmRuRStzbHRHZHhpUXpTSExoRDdDNUlX?=
 =?utf-8?B?OWF4eWVhRVlpV0ZUQXJlTFZ0ZTUwUG8wckhUNms4amNvbUFMWXV5K2dHbkpV?=
 =?utf-8?B?Q29OS1g3VHdZVzRRZ3J1SkpnNmwydEJRSkJGcXV2K05NYXA2bks0TVYzclcv?=
 =?utf-8?B?R0ZRbWFNRjh5K3hETElXTWRaWXZnTVl4RlA3MnJHYStTOE8zMnVGKy9RcXd5?=
 =?utf-8?B?QUlQV2haaUk4Rm9LNm1GN0R6c1VRZTE0eUhJeUdFbDY4Y1k1Z0FXUTM2cFVY?=
 =?utf-8?B?VWFQQ04vaThwN3h1dXcvRTNhbnhibHRxKzVRUlJkeHh6MHVXcVl6OGZmZVBP?=
 =?utf-8?B?VVZlejlYZnFXSm41Ump5Qzlvb0kwbzlTbFdnc0Y2dnF3OE4wVnVJZHI5QkNU?=
 =?utf-8?B?aGxRc2RNaTd5TDJpd1M5L0ViR0UvNmFSY0pVaGx0MjBwOFJrbDY1R0d2V2FD?=
 =?utf-8?B?bVU2WUErVmVXTXNaU0lkaktvbStpTnVIVlB0SlJ4UHVudGV3bWZtQWhFTVJI?=
 =?utf-8?B?RVIvbjZNdUpxbU9LRUhQT2FoQ3Q1bUpId0RVcDRFc1ZVNkdhNEluS0NGazlL?=
 =?utf-8?B?Snh3dUZoRVc5MU1kaTBIZDZjVlV2dlBCN3hMNWdRdzNpcDNwTW9tdUJ2V1FE?=
 =?utf-8?B?ckpjVVJLWEM1UTEzZEMrQm9yZ2lNM1RlQ0o0c0VjQTdIVGpaM3VyWmg4SlU1?=
 =?utf-8?B?MFJMNUpScytSTHJJQllsZERkN2ZGQWgvU0JITWR1NVNtNEthYW1UbWtvaElW?=
 =?utf-8?B?ekdWNDJBQUxtQ0R1UEZGcndDVFFNNjRRQ1U4c0lXMy9jTEgrUXNwK1krektD?=
 =?utf-8?B?YzNmUTkxcnJwWjFldk5RaXV3RmR4QWhoREFhbzZnWFl5a3ViT0VKUVFLb3pq?=
 =?utf-8?B?YUpvYmRvOU05QmdlQUM5TTZSeEdENU80SlhrVlNIWGRhMzVFdWV2aFNPUStW?=
 =?utf-8?B?TmZCam5yMElZeWxrWGlSZnB5ZDRNYUVhUnVyR0F0VHRmQ215bTMyaE9iMkov?=
 =?utf-8?B?dHQ3WGQvYVNFKyt5WnlEWldKRThkbzZSS1MvVE1kY28xczN6UVB4NFU0YkRl?=
 =?utf-8?B?VEJzOXdjM0Jlc3RndEdNTHRZVktBRkJSdkl3ekJTbmFkUllNMWFwY0tsZnNo?=
 =?utf-8?B?N2k3ZDdraWZITjJKQjN3a1pGbDJEazFqV2tIaGdMNmJtbVZPeXg0UTVyUXpy?=
 =?utf-8?B?ZWhRcHUyOFhtSWhVNlllZ1p4RHZlaG9meDQ5MUt0OUZpOEh2NG5ZMlVWbHFr?=
 =?utf-8?B?cmpNSHpPWEl5OVMrVy9LeXhHUWkvQnU3MzA3ZjdZWEhUd0VHRFgreTVGMkE1?=
 =?utf-8?B?ZUFtU1VmUGFVR0N4dEd3cTF2ajlKZmZ2S2x0eWllNytacFhXZGJwY0JvN3hP?=
 =?utf-8?B?QW5reXQ0Y0JZV3ZhQmV4QWdBT1dFNGwxUlliNnZGUGNQR1ZEeXdwdmpjT2FE?=
 =?utf-8?B?TE83MTF5TitSYmJ0bHlJVlpLS3J0ZWlZOUMxc2xlaC9IYnVGRDEvUThRZDJx?=
 =?utf-8?B?M0VFcnNhOTJONmF0YjNxcnlRaTB0Z01WT0ZFNFUzTGVZZC9CV1RaWkFWd0ow?=
 =?utf-8?B?OGdaemJYY1ZBSEVEK0lnQWsrWlVkaWxKaHp3L2lhUVRLTzBTS3lqc0xoQVNx?=
 =?utf-8?B?WHNUN1BqYXFEM1E1OEkyNTFLbjlSVGFiS00wYW5rdVJkQ0lQYTVFUVUvWHlC?=
 =?utf-8?B?TnQxQ3cwN0RLTDNUTnRZbDFWRUV5TmwrMzkzSVgxMFpLTll4bnlsOUtjcU9w?=
 =?utf-8?B?TUxrWEtBcHFqWml5SFlXazUzRFpzRkl4bm9kcS9lckI0ME5kempydVpKTjdx?=
 =?utf-8?B?d2ZFNFA3Q29jQnZNYUxyNk9QZUZLRlA5VXdySXgwM1Nsc0dSUDBMZjJ1SjNV?=
 =?utf-8?B?RUN0SWNDUDUvNDJmazRjeE9oRGUxNFJ0RlJ5dlY2eVZiQkpDZ21XWHZFSy9L?=
 =?utf-8?B?UmdseUNXSmVhejZIVFl2eUNSWHBLSGlFR0dEU2J4cHlFREhJd3p3VzZIam95?=
 =?utf-8?B?QVRFZzRvU2lTSWFxK1pydWYvODZVa2kzeDFPSUNJTlBLUFFLMXVaUzB4R1BT?=
 =?utf-8?B?M0ZIek9QV21QMmw1REtoaEtiVXN4QVdIM3UrVkUwMnZuY3BXMXQyZkRqWlk5?=
 =?utf-8?B?WVo5WDFDb21GN0lzQTl2WEZrdnJwdkw1OFZKWjhMKzhmdGxPd3o3Zz09?=
X-Exchange-RoutingPolicyChecked:
	Tox0yfAoybI04He3MlLIEcjLl6wPb/WKP3iRJm/0ZjCW9YjI9ibsauaaw9DpfXvFNANXEip4biGHvWpLNRLtcJVvqnLDG170M7BvFoCOYjrCR3XAVGvbwqF6yfWw2PDwR3T/k5qyT0CAzbBxwPVvwbsXmX/J+LPnYo1vHJayAMZHyNH7u882oeo37R/nWfjwRfeym47EJTyyshZhmP3R5/GQq1fHL3OrTnq+8Ngjx05YGRXP+sMczusMoXD5925fR5VlnZrNLu6CxTAyBdsStQxfqFGqGrZrvgfV+OlIMoYiCD0aVToDW2nm+iDNDWVg1lVMYXY+vi3AmzNXqO9MgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	94MTIz9790ZBah5ranm489EVIdfTo0pAD/WSOKJfiwBMrc7DI4iNmlDw+ZTkFsSJU7jVan0bQK4iEWv6hOUHFyp7QCgB6LK8le0UBO22/0h1CUuH4/sbqanqPJQOw5SQ3vDkeY427z3AxRRM7R7qFuspwgUp7j+QqJpKblrENnuFsjoOjI91muMkHk3PhXDEr6tf0qBYU9dPIf2teld4ZxpEx6kIFSQdqx2H73R2bZN7h9NJq6yD8sZQbhD9TR1x5qISK6OvJHAT1K5D+YbvnbHk6fazyK3JFNY9OFZU8y32R8d4uY/GfGylcXTvICEV4tB4WSBs3l1yZh0ti2X4S2OdZuNo1JD2UZL+jLUj4nF5/oBxHjyR9vy8U28ZIhOMg+D7wX/TQpZ4DiicAu6BlfOqPurXasnD6BmcIPAC3H2eNV+E9Kms1MWlqiKEcmCkyl5SsUENfDnqZlfE72FPxmYS5nm+CZeZgVHRsX5zM257qZ0ub4KX/R57Ay/eo7bNKq/sADn1D7Mzc/lgQFwU1Rmaec/d60MgcdHqFHzSYN4zM9h6DB7b4lDH+Rlvkbn4L2H6+HlUICw9rz4vCG71p8BTws/600AokkCsqYSOyUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cefa49-36a0-4718-edb4-08deafa6cf48
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:46:51.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6haCfaZSB5UDsjiPVvEr6vABG7RWDuFTKEQg1xFTywisppvMin52rgfE6RYFd5DMtELXlWip3UmTxp5XtVzZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605110231
X-Proofpoint-GUID: cP0Er1TRJ0NuOkDEqMe0GyjgM74eFrNJ
X-Authority-Analysis: v=2.4 cv=ed0NubEH c=1 sm=1 tr=0 ts=6a024e4f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=HrAAjhwmPyKACPmMCgoA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: cP0Er1TRJ0NuOkDEqMe0GyjgM74eFrNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzMSBTYWx0ZWRfXw/Ak/Q5LP5pW
 NaXpnCEKa79VDWdNkE6uZlFlHZV5+wZqMyTBLcCGPfv58NZvB+ff/9emltFN5/zqBo381F5MfB8
 gmPs+os/J5KOYcFLlSadJ/6hHOlswSF9CCKPiWJW2U+5SX42PmcLa15mUFCts248VdIfTDP12Ik
 lcnrl+5P6Ny5LWeJxfNjshufgDU1Hpzky87u+VgEFe/4H/4U6asNSYIoCdXGfyB+LjSI9eW0qjr
 FSq/RAqJR9pETMBhNb6/6DYqEWnzJEuyWsektVc4BjzAdYlRDzDrlhCPzilVcW4CXKhIOMCNGqe
 skcc3zwKY6eDLKgQf+HqqCY8y8qtsjEesvTsB1/ypF1Z1xjKug6yWug+J+BkyI86UyEL3zRmkqs
 lV5BC1GNMzTz+v0fxl5eAWFpJHQe6V3xHw09oFYkL7ILMc4ailF8CTHhdFcIieZfP/PlUvohQnA
 qvEiaX1JvYdZOqxnOTg==



On 5/10/26 1:13 PM, David Woodhouse wrote:
> On Sun, 2026-05-10 at 12:11 -0700, H. Peter Anvin wrote:
>> On May 10, 2026 11:54:38 AM PDT, David Woodhouse <dwmw2@infradead.org> wrote:
>>> On Mon, 2026-05-04 at 17:30 -0700, Dongli Zhang wrote:
>>>> The KVM_CLOCK_REALTIME has been introduced to help track the downtime of
>>>> live migration. KVM uses that realtime value to advance guest clock, but
>>>> the same blackout is not reflected in KVM steal time.
>>>>
>>>> Account that same delta in steal time directly in kvm_vm_ioctl_set_clock(),
>>>> only when KVM_CLOCK_REALTIME is used. This keeps the KVM-only solution
>>>> self-contained and avoids adding a new KVM ioctl or requiring additional
>>>> userspace changes (i.e. QEMU).
>>>>
>>>> Record the per-VM downtime delta when KVM_SET_CLOCK receives
>>>> KVM_CLOCK_REALTIME, and fold it into the existing x86 steal accounting
>>>> path. Initialize each vCPU's local cursor
>>>> (vcpu->arch.st.last_downtime_steal) when the guest enables
>>>> MSR_KVM_STEAL_TIME so previously accumulated blackout is not charged.
>>>>
>>>> Note that this means a vCPU may observe additional steal time after
>>>> blackout even if the host side contribution from current->sched_info
>>>> did not increase during that interval.
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>
>>> I really don't want to see KVM_CLOCK_REALTIME used for anything more
>>> than it already is. Or, indeed, even for that.
>>>
>>> There is precisely *one* place where it's OK to use 'real time' as a
>>> comparator, and that's when setting the guest's TSC. And even then it
>>> should be using TAI not UTC unless you like your guests' clocks jumping
>>> around by a second if you migrate at the wrong time. KVM_CLOCK_REALTIME
>>> was never the right thing to use, for anything.
>>>
>>> The KVM clock is a function of the guest's TSC (see
>>> KVM_SET_CLOCK_GUEST), and steal time is a function of that (as it's
>>> measured in nanoseconds).
>>>
>>> Don't bring UTC into it *anywhere*.
>>>
>>>
>>
>> Unfortunately TAI is often unavailable. One can hope that the
>> proposal of abolishing leap seconds by 2035, fixing the TAI-UTC
>> offset permanently, actually happens.
> 
> I was hoping for the opposite; it's just pandering to stupid bugs.
> Yes, leap seconds are fairly rare; instead maybe we should *always*
> have a leap second in one direction or the other at the end of the
> year. Otherwise it's just building up to be a bigger problem later.
> 
>>  The difference between atomic and solar time is better handled with
>> the already-existing "time zones" mechanism, which tends to change
>> far more frequently for entirely different reasons than the TAI-UT1
>> difference slowly accumulates.
> 
> I have absolutely no faith in a 'time zones with second precision'
> model ever actually working either. Although maybe if we ditched UTC
> completely (and the pointless 37-second offset frozen in time for ever
> like the GPS offset), and our second-precision time zones were based on
> *TAI* we could exercise them from day one?
> 
> Either way, as long as it isn't the awful abomination of *smearing*
> leap seconds and screwing up time precision, nobody actually needs to
> be nailed to anything.
> 
> And none of it matters here for *steal time*, since the *only* thing in
> a migration that should be based on any kind of real time is the guest
> TSC, and everything else should be based purely on that (perhaps via
> the kvmclock).
> 
> And even then it's only for live *migration* to a different host, as
> live update on the same host across kexec should be purely based on
> offsets from the host's TSC which remains unperturbed.


Thank you very much!

Based on my understanding, you have two main points:

1. KVM_CLOCK_REALTIME is not preferred for live migration or live update.
Essentially, the only acceptable use of KVM_CLOCK_REALTIME is to adjust
guest_TSC. After that, everything should rely on kvm-clock (especially after
KVM_SET_CLOCK_GUEST).

2. Regardless of whether TAI or KVM_CLOCK_REALTIME is used to adjust guest_TSC,
the calculation of the steal-time delta should always and exclusively be based
on kvm-clock values before and after the adjustment.

Would you mind confirming whether my understanding of your points is correct?

Dongli Zhang


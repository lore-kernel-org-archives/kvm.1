Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C003A1E81;
	Thu, 12 Mar 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339087; cv=fail; b=uqvjnm/4DlAznNC4vwP5Eo+p+Z82wGZjdd6m/PSYYGRsTD9lDEKW9ysdv12saJjUQfkGGx9YxUAO57Osp61JxD8inkucwLVNEGctGLqr5JsbBDnDVEcAzU0CtQMFvwW2eDH7nUEDHKpaLSoQ4fssq9K9T+Udf7XW//DdL9q8rZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339087; c=relaxed/simple;
	bh=kPLw50rNtlnLoZVehjlNNuObE9Z0uuVPKApLWkLAyuo=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c1Cws9rIt83lysr8aF32Jp8C15EJ1FkCRa96DS5Oi2Q4+rgNmS1aej+kRVlQeWO3Az88uLi1tym7xfbXLrhVOvJKdAZD1XxVxis20SEtoB+c6V71yNmaFKATua3+q+9DzOgb2T3BkHqivc9pji+xXSC/AXxa5JtEKTeI6IBmpMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=cC6xmjpM; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cC6xmjpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3jRrRgTcE4aXUkfhr5dukzTJ2d0Kk27fPmI5enQW2/vJNnM1+wFRtB6jZxkDfhFARyk935JrefBpZVRfimesXttRWDCCIlcCMY+crm35fe7HhSMNuaaIot3hva0+SdwlqN79WOuQFvPch3BYwf+mgNN4oUgs72z8qpGhs/ldiuKUGuccKRivFkJMAAhAunf7rrwJhA2yX3qGSeqZft67gzDLsJkutsOFpcqcWGutjaWBuT2GaNazeGr7mhtvc1sSmvxvgbDpZiW2EspCAcdrfu/2Ea6XGkIk5ybQSQIP09VdB++jNoQigI9RVx+lbGoP6rTuVX2vBEIJdcCv5Ge/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5H9IWVzDb4QRHJpFCtIsMPMtGg1Kv2ZC4mCUioa1Cw=;
 b=K6Ok0MZr+X1lnKXLBNI+wYvx2M1Im65+80Uoz0jSJ1X7NZ+FzVulu7pBx3h7CQBvh0jS80s/WDkiYu/J3hhm2j7k9E30bzAnjM6UIQrZS8aYf29PPIOXDVRhbsWAAgpcpSrOdMUZ2bgRUwaxsAFUMn75QtVTf1tvqs4ik0V0JD4O1R38wsEMan6XMLWQKNA8dH18P1RNa7PHto06ju95x4Tu2mvoxFluNRAtODIXORqGSqmAGt8amVvCkeo5xuZ2XMb3+qeU1iHZdV/d3R1SppUtRjaAebzahMz96O+Pnbua+nVE/1FpCEvTV/pABBNcpQispmHNFdMiqsm+C+8Cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5H9IWVzDb4QRHJpFCtIsMPMtGg1Kv2ZC4mCUioa1Cw=;
 b=cC6xmjpM4HsAx9eqHm5Wb4ZdahZSWjE7e04bu1IvkGAUy2voOnK5K7Y/WMwLeDhm8Gjj6I6XPkQShqQ6OLYEqnMunq9SqO9sqZDTxmMNcg1UG7fUn/Do7GwKrlMr1ft6QU1tZnU6alk/ttRXBpPt4wiGL1yJhR4C1GCHrwL2WVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by BN5PR03MB8077.namprd03.prod.outlook.com (2603:10b6:408:2a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 18:11:14 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 18:11:19 +0000
Message-ID: <e76107e3-b93a-4154-859f-d22de0ee6f78@citrix.com>
Date: Thu, 12 Mar 2026 18:11:15 +0000
User-Agent: Mozilla Thunderbird
To: seanjc@google.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, chang.seok.bae@intel.com,
 kas@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, x86@kernel.org
References: <abL8SW5JS1aV5goa@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <abL8SW5JS1aV5goa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::13) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|BN5PR03MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: d5386355-e7f0-4e5b-63e8-08de8062c264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qVIRtm5EBskOJyilNzu7JixCh56/4MsbpTRpUQ1/xYfSx3Oq/0d0yu3G48FjYJvXF1yBETc+osqhnLWB/o4oGg3Uq6wiG5zJgIsb21XQfZgcKLUmIeHskpoAz8cjmIEN90477WWTPnMYz3S/w+jqQ4sZ+hL7Vpms0I3OcrwtvMnxU55ufntqyCcoqT0NiSqzea7Oqn7AW5OmnVhSA9NngrANf6gqcIcz9PxhUJAD8YirhbVG5LlnKH4bQ7GIcH8E0gouG6+n3R3v0PICTe0hBWKLpAmRwGNuuTZaRcBT1qdN+n8U8jmthI9NvoacVBtDx+lD+KSFoTvZH68+bcHI1ZRj7j3a1NTFrI9E1dQjwxNRoJ9hczj02r2gIffOXscA7kztbn1avOA6UIimDJkR/qrfm99H+Fydl/vM0qmNWTXPPzq9/y3zTvbd3GPHIqWsLrRNYtKUzG8bCLqdXz41JLzFHak/bTwMZB9gPSpbN/0nYY24rm61dBYNt2mpXFZ/4oJuhWLUQt9SphMjlLaIVzHiHsHDRJneDsOL6J/ufjsoi+wxRYa2BcxanaiNAu6BRO+UaAjIvZJlYPiv6UZUNr0jY+bh0p2NJkbJgxI9LNBC3XR0WmXYjr/Ifxmy/p4kJKxYye8XF8oNvva7QTMj02LEOQUyGby1V+YbhjRZUB43KDDPXCGUKabxvOujP4VZhtMsoQOrskgfTD4A7nHzInLOdlcZC9qDwY9X5MxaN5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTN0ZTVtMzJ5amxCMjdCWlp5cGh5VG1SVHR4dVBmSHB4RnlvTGNtY1g1c1pG?=
 =?utf-8?B?N0lZZUhuOTZ2YmlTT0tvdFIvWGZ1ZnFYdjlIWmZXSEV0dHFaR1ZPOFpvV0s0?=
 =?utf-8?B?Nm5JdGFrYUZnR296R0ZxNkRoTjA3dmtoVkNpSjVsWXNrZitnOWhxRkdFVTkr?=
 =?utf-8?B?dEJpZ0c5R2p4M1ZPVXJCQUI2UDRoSERyRFdhUGJXcWJHb1RGUzhPakRBNU42?=
 =?utf-8?B?QkFhY05MYVhNRUpGVFUzc3M1N21sbXJCSEtmLzRKbHV4SHdHSE92NFdiNzJl?=
 =?utf-8?B?Vmh4aXZoMnVoam04VzdJalV6Q0NLcDBoMDdPSW8xeVUxUHFudGJlM2xMV2sy?=
 =?utf-8?B?MHVBaGdjRE9ucU9EUDVrNG4wYnNlYmtMR2txRmxuaUQ5VVVPVWlYOGY4cXhQ?=
 =?utf-8?B?MVJ4dEFwM1FueTNiZ0liKy82dkRnWk9qSkhkL3ZRcWxSbmF3UU1FTm9IYTEw?=
 =?utf-8?B?UVlEUm9BOEZKL3FxbS8wZ3dISTBBWFQ3QzRtOVNFQm1sRUdqV2JlRkFrT0hR?=
 =?utf-8?B?emhRekhLbWJBRmFnT0hpUm0zVnJxTndFanovMjArOG1jRGpNNk8rMmxXbXQz?=
 =?utf-8?B?NURaOWlQbUlKZ1RWQldVOURYbEg4aTBLVTdVVnU0cm1IMkhnUmxpREpKbDds?=
 =?utf-8?B?REVSN0RRbDkwZWU1SmZuNEg2MnBZZFRFWnQreVdzWEp4Z0g4WDhzQ0tSVFIr?=
 =?utf-8?B?NHdUcGU0MXN2akl1d09XVUpCT3I4NUZRYXN5d2JWUnptWlA1Mkd5V1pwdG4y?=
 =?utf-8?B?Sm9zUFpZTWthTjR4RTRXVjFNallIOU0rY2pIWnVUanJQZUE1UThmeDNmSXY1?=
 =?utf-8?B?eUpTemRMcmI2ZHZHUjBIUlJxU3NPTUFib0Q1L0p0T1lsQjdOZFlSRGdCQXUx?=
 =?utf-8?B?cWt0VHBPRWlDSFEzekx1bkorZ2FhdjVnQTUvdCtkdmdtU3E1Y2NiTlJhejB3?=
 =?utf-8?B?UXc5UFpIUVdRaklsYnZ6czNFbUhiWU5QalA5VmFFREhPcjZ6ODFvR2RKMjVY?=
 =?utf-8?B?a1B5cm82di9MVDN6NXN2a3p3c2NGcGN2UFcvUmNSS1ZqREpSUmR3UjZ0REEw?=
 =?utf-8?B?aXRTb1loZC9KT3VQT0NURWM5RmZSRzZ5S3JCSE9yWlBiN2ZWS1l4N1hUb1JT?=
 =?utf-8?B?MEUrLzVvT0FNWTk1SjRJWHVCaUo0V3lFNlhsUU92ZVJJcWRmVjk2dXJBa3Mv?=
 =?utf-8?B?SGliOGtYblJoZlU3SitmT2RDU0xGRVE4MnV6ZVViOXFNZm5pdmdjR0NBS3Vv?=
 =?utf-8?B?SXM1K01DRzVaaFlwTUE3K21ucU9rWW81dXZSTm13TnNWdmdibDNWQTF2c3JG?=
 =?utf-8?B?VVl0SFgvdEJscHo1MVBXcTBDUG5TYjdwUE11ay9NQ1g2ZzdVTmtMbUZrU2F1?=
 =?utf-8?B?K3UvZnlyd3dVaU8zTWFydXptUTRvczdjSGNXOFlLbW1TZkpUN2ZpeEdIZW9H?=
 =?utf-8?B?OUJvdTB1cWdhUzNDQ3NGQTl1RW84Nnc3OVJwR1lERFNYZmovSkFydlJVdHEz?=
 =?utf-8?B?U0RoYWY5bERIZWwwWGtpbVdVZGpuYWVjd2NTYmJHL1ZHOFJEWnJpaFRBbXhZ?=
 =?utf-8?B?N0pWb3lCNTFJbktSWVBZNlZwNTRhdkpQa2NoUDBsZnVBTnk2c2syMUpKZkwr?=
 =?utf-8?B?L0JFYTdML3lOTDRwQUIxR0xQTy9ZaVE2b2V3MmtmR0EvalhENU9ZdVRXTzAy?=
 =?utf-8?B?QU9tdDBMZXhxemk4RHpNQnJnakw5OE10aGU3YzRtVWQxZzZ1NmVadVFCZDBo?=
 =?utf-8?B?THUrdEJmanNSdVF2VTZTRjB5eTJIMTdUR29SZFllVytZUGdBakk5Y2RTbzZy?=
 =?utf-8?B?YnRaTHNpWksvYnZzWmNXWUFoZlBsemdYM2ZSU2ZSSjNjMXByc1I4enRpQzFu?=
 =?utf-8?B?MTg1OC9jUnFkRG56VXVDUGpSVjE1UDlRdDkrSnZFdDdwd1ZXa1ltN1lsaDNP?=
 =?utf-8?B?SXcvM1J6eXZRNkMxSWtVWjJDRkwwdVdyWVE5TzZ0UmZpS3dOTFlnb3JVbEM3?=
 =?utf-8?B?dHhTVU1hOTFsTFZGSHc3cVR1ejlIN21VWFVZTFJDckU3SVpud3IvMjczU0VI?=
 =?utf-8?B?SDdGQVFHRHIrYkMvc3owNDU3Tk5XZ1JQeWtGOU9zUEpzcHorWWhlWVJEOE1z?=
 =?utf-8?B?cWRrdmd6NU05NmhOSjZ6L090d1RUclJ3QWc3bENYT1VLSldiRFVHU2FCUWtK?=
 =?utf-8?B?R3lhNUtVOEIxVC83SzBRUHBvTzMvRkdCQ2ZtZUVXRTAwcjBXZDNyY29KdlV3?=
 =?utf-8?B?M3RLZUE2RGVFaU1YQS9iZmliVlVKZXVNSk9kc1A5Y3J5dTc4WjQ0RjRDTjZu?=
 =?utf-8?B?bWhpSy96ZFg1c1lXMUQ3cDk5WGlhVUFmL1FlZlZ5NG9IRTM1emlscEVRa3JF?=
 =?utf-8?Q?n7xTCnEu4mkd/yzI=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5386355-e7f0-4e5b-63e8-08de8062c264
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:11:19.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWf9yw8x7pwG3cZ/lbyN4fzPDofOavvBQBdywSMf2cUWvIsJjhDXrmCfRMyZHJ4sPymwTRiKWrAra6DH3zd4/OhCmKlZFmd7U+Xe3G6ChnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8077

> Have you measured performance/latency overhead if KVM goes straight to context
> switching R16-R31 at entry/exit?  With PUSH2/POP2, it's "only" 8 more instructions
> on each side.
>
> If the overhead is in the noise, I'd be very strongly inclined to say KVM should
> swap at entry/exit regardless of kernel behavior so that we don't have to special
> case accesses on the back end.

I tried raising this point at plumbers but I don't think it came through
well.

You can't unconditionally use PUSH2/POP2 in the VMExit, because at that
point in time it's the guest's XCR0 in context.  If the guest has APX
disabled, PUSH2 in the VMExit path will #UD.

You either need two VMExit handlers, one APX and one non-APX and choose
based on the guest XCR0 value, or you need a branch prior to regaining
speculative safety, or you need to save/restore XCR0 as the first
action.  It's horrible any way you look at it.

I've asked both Intel and AMD for changes to VT-x/SVM to have a proper
host/guest split of XCR0 which hardware manages on entry/exit.  It's the
only viable option in my opinion, but it's still an unknown period of
time away and not going to exist in the first APX-capable hardware.

~Andrew

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195520;
	b=w4gk1STDMclicqQk2YIoIKnfyD/IhkLSlj5SZBfTpbm2zvEkhLmgVsDogutc2PJ5KtEx
	 iUS4Zh403MMowCWPx5RHLno7wPYuk64sv1+rUrMrheuauKT3/qGTs4TXGJegxXY1khaYx
	 ql+NtspoLPFSAtdynA9T9MZ7yo4hQp8v2f+QoesJRVdF6eGEce4JI3AvN5wHmu9/fDXUb
	 k9GUCxMEZ6xLO0964KvtmN9cGCYet3M5yd7Gt6iVN2tLDT+rvG4wggjN1GFAIRh2yAO3h
	 jdzmoJenT3cJ2PiEKl9Xh7O78YNQUxf767vYz/bSBgjJ+KY614zoceG3Rca2w+hQfQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195520;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/JvcarMLiWryRrHUBFt4iOlI6gW3LQB+YbPwQJ+9S3M=;
	b=b+WlCMgogjGf6p8LZwqdY5uEHVt9EfZZYbjwO8x5XrUUHD5hKqrYnUnddVAwx07gr2cB
	 Etw1oC0agKpCW14bJ3GSdEXjRoQcKwXHaTz01q85qv1n2Q9I/YwdYI1ZKrAiJtqVXvfSC
	 lmKF3ep7wPA6YGZ7Dp8NKBi4ghAHrZhMKIlQu/PsdMiCKWNQaZQ2VORo2MbZeED1mt/sd
	 B6CJRnQei5mFTs5qIV9SbVmziERTXr0+wRnkoDJdLbSOzUbgVJGbdg3L0b5OA6MGOnB6K
	 N31Hc4ThKyxLFRmEI1uMnp1YJsxkYN+nsLhTj3ObWkbaI4DIUq8BhzewjaJobQrQOhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FotCfS9b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020123.outbound.protection.outlook.com [52.101.228.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C01606A320;
	Fri, 20 Nov 2026 17:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C01606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FotCfS9b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeuLbeG4/DVwLB1zDxdKur1APrwPUEOkQ4FSl5BPemc+2JKO0a7WeTzz7zFcKTZXcPmRKSwbyuGh03bbdhhEzEgTM/o3RtdhfCTo8l1gs8qoxbcjLNJobz1jKMwTnGK6jfjtLSHE6tGcDkZyrziSiLS3LR7gluA5AFKzAQE/YAXSv2tHgRrGajjaWtHJFvvTk3+suqyZPZslRwKtdnOVcksUGl1snKfqPMLiBM6KAfcg34MZlym9D9aVLqCkKFeksePhJrsxi7gUmxT//BdbF4y2nuqnCmfl8lAh25hRVf9RLsfil1FglFYlkVdd5L44hixfgD6CQdmzU+JzE3fktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JvcarMLiWryRrHUBFt4iOlI6gW3LQB+YbPwQJ+9S3M=;
 b=AU8Z1Bl9LZ3PUNa8FU2PtgwQtgpRM6XFUnBDj8B04q7j45tA2IgfEXaADuQVvN3bzd4qQyensAsUYKIljmwwgVA1g5L4v2jkmvMirCXoXN5Txf1a/YyfOfcafenUhHAP9Th9/FcAVlwCjuhwTuWYdHEVpXkGdW6haKHppVP0QYpsoN+lt0Zggaf33V15oWtm5z2FhH2HIazzLF6g0DoLNNmOsa5R0zo7twNojDiug97hR/bkcCqnEPXY8vldMIhNbt4o7unTqYr1ZNl4pfzOlcCQdzmeUyvFill3VHoHD0Klv+ihELR/7OF4hBMqWcdjrQ9OAzeL7A/wksQj+WKaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JvcarMLiWryRrHUBFt4iOlI6gW3LQB+YbPwQJ+9S3M=;
 b=FotCfS9bl/BSPLGadUim+VDTmcZyRZ75Bf1zI4HfKuju4zW0ek8sUo59gn0EMWs/2kAq9l749wun2prXJuxLMYGH6qYJy6h/4Bqeixks3HSA5PWhfIQkdiTKoHm14WUzdlcIZBXCksncgQ/WfllEA3kz/v92EQe/DabCI3LAHxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7997.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:475::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 17:25:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 17:25:16 +0000
Date: Sat, 21 Nov 2026 02:25:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RISC-V: KVM: Skip steal-time updates when run_delay
 is unchanged
Message-ID: <awCBn-a_i8k2hkbe@z790sl>
References: <20261118062242.2914385-1-den@valinux.co.jp>
 <20261118062242.2914385-3-den@valinux.co.jp>
 <awB4BxCHBu6nacbO@orel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awB4BxCHBu6nacbO@orel>
X-ClientProxiedBy: TY4PR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ec5c13-4fed-4aaf-9aae-08df472b3e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|366016|7416014|1800799024|4143699003|10067099003|56012099006|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XRBPU8NoiIWjXJ1cSMU8jEghLh5vTXF1KDbmQbgZZXlbTIm00/c38GhjyiRzWmF+DzN3a6xS1/MRHrQl4xY/uRRHYk2zy2BiM7JsHamVENCIhWD3dzSd1q9J7Jattl8Oa55jl0Re/QHDEsTcn6NCtUL68UbZB9eKfIHxIhw6f8qQZitFAhxIOduNOG3snDOokEPLTqihFfqcaLOduoWStrCkbWpCQa3vGEbiDqd7zM84fIlJsLc4Q6Bq9oQi/qP6PygNO+4pQ6aeeRDybzVHtAdgOwtWhTCNNVMICqWEAM44REbFEDBlWhDNM5G7HAqVP3r8FNALNkmzdD2//PxdWzsN6iUjqllQI7faZJTKsQFOLKYtIH3R0t4/j+wDpNIkz2ftiBjvjzuuokxZiPpmNNjEQF951pI/xH4kgIMscOWvB714AIow3YtMwMgnHksQCfF1lKvgKNaNCoHijy1dz94/ibgAe6+sH9N7sDTvrZo7L+JI2YOPI/bU1JEfRoQlaH6Yz04dTRoZ7c7YsZPo45TL64WKx8Q/R9XoKiKSF2rU71saMAc53w7q8v2AXcuoYKDOk/fezGTpfGPKDl9sjYS8YtScFt/H2k9BuTNCq+7v6GCZCa/0lrAwW/Ot79kUABTHsY5+x1s0rnTV8w5eQOmKMQUN689bDpeuRJ5psHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(7416014)(1800799024)(4143699003)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VudRp4caP9n3JN0uAzkYSAKett4fnK9kFVWxuWGSOT1t8keUDEmndnuw+Vda?=
 =?us-ascii?Q?PdVsq5ohtOEy90V2QcP2/fwcXY221Fejy9loJMfXIe8pWRhXoSq8bdRyeICb?=
 =?us-ascii?Q?IPgv3aEYef428xh+pg3gPoLo3LsXXZd0H5K4Y//4AifuZVCISsAOnnXdHysV?=
 =?us-ascii?Q?D3nO/LdtYxvcbnxxSnx5yAZ7Dr39x+LfyQktTm6c6itYFLPpDqn3oko4nBYV?=
 =?us-ascii?Q?/mPZHL68Wj0Y3z7cTX0+I6AHZB15w8I6uqCXWKHsh2R4bCq+89FJ1ucCRtLz?=
 =?us-ascii?Q?+RqOLyFRXQcCejzxPunUmzaBfKtWlmxh8DML4QnutQ1VzY+JMO0ci+TA2r3O?=
 =?us-ascii?Q?b+BQoXlc/EME54IMaPin5NBxXXTC5+fiAAryLEjc02iy84PY4JBui+I2IgUX?=
 =?us-ascii?Q?V0pGmt4YVf/fW8yxzUgJNdIj1CD+2qCrwN2yVCcjuHVCHRWKHbiU/AxqyFpc?=
 =?us-ascii?Q?2vtT+wG/GccnLR2SZHjD54yqhVydBuk1jrK/qcQIV0pLro1swiF6z+dazH3p?=
 =?us-ascii?Q?/XfEmY+IE5KhdLP1IRgzh29+e4VSHgwHA6TY2I6MDW3WrgY7pPl49tJKSvEH?=
 =?us-ascii?Q?4lixm0jcnjhVC1qQ2yZH+BKjrw5CozNXz3uCKIfuI9iehrelC9pLuxBA5pQF?=
 =?us-ascii?Q?as1PJ97G6KD0+TQE0SnIVKJsWRR1jcrW1S7a+IB/zVDMX4CILIbwCHceJFQa?=
 =?us-ascii?Q?d1FpNdNZoPL1D4zdLL7X/qFfKotEdOTw5hsJah0yYw/xMhg8fwikh41OujPm?=
 =?us-ascii?Q?PG3RrwC3VBCw1tUcmTly9i7ShXnWUv95VXzXvuJ6t/AJUeP0Kk8X5xN7C9Hy?=
 =?us-ascii?Q?Uq+QpsiRy4Ordfcmv6vCibYeeBw4ISDa/dfrJkipoVyVq5YCVwF0Utid53vN?=
 =?us-ascii?Q?6+rkzBRaHFmDCriX+BGaLBSvKDr0wBKW1RjokarFgdd1KzETrmThU6OQjRjC?=
 =?us-ascii?Q?qheVORBNsGrboz/ptMUGk1EE1SVfV7uBYgdnTOBfbnNv+iIIGzl9m6hhStFQ?=
 =?us-ascii?Q?4zSo4vFQFVdwrqUiV2reumaEmlNxghh7Au32Ic1yIa4XjUeCwwMDy/+E7Yp3?=
 =?us-ascii?Q?G6UCC/CmySVBuiu5eomwWXLl9ImqxGGDatFQ9DOKtNREE8V96md9S/47xmwN?=
 =?us-ascii?Q?BXvG//F1gKmadV6EhfBzI9cKu8tq6d61BfALuuNLY8OqLqezoJYLJS9othWE?=
 =?us-ascii?Q?IF3hZ9PLLwjoEf6KbuoN7gBznZfOQbF9+ZEXEb160bEoQJHX3aWLgyi33rv8?=
 =?us-ascii?Q?4URcndDswPJMf+9F0lodROt4n1k1Pw+7E5VV7lcB5HklZRAxtFnnHFDo8NcL?=
 =?us-ascii?Q?75A9ADWM/p1ijDELmTUf9OID5ZeSe80TYrzVdfigEa8RNykagqvIRYrTlMVk?=
 =?us-ascii?Q?FF9ebqP9M8q4+HvUSSntPmZ5Z6kJBq/R2Wd2Cdwgf+dpmmfwKd8Ia0lYu0xE?=
 =?us-ascii?Q?ZBecuwKx+WC2Zj0+B0ixBTDWOJ95/wB9/2KIh7TEqKJjccg54iJ2xKtVWkPX?=
 =?us-ascii?Q?RXivgH1Idh31SUxuSQB/zPH1cSMkquc4K9wQ+cmMFWCMYCYIb5MSsoz5/pif?=
 =?us-ascii?Q?iiV0gxPpneVmfaeHv8V+tqs4e+I7yb4JGCgw3y7+PZ5TofKnTxcr3I6IEhFk?=
 =?us-ascii?Q?YUvwZe1vE8DOWfdV3lwPhM3fMDKzhTXtk0c0qOoGBWZz2Np/GfilpF+SdZWs?=
 =?us-ascii?Q?+OTAbXTtlFGEWT3UxzdanG2x7WFyFT6NqKIUUdRYhRbigA24+Wn3byLeDbb0?=
 =?us-ascii?Q?tA8LD/22EQkYTrGvHem8iH3sW3tgk4J+n8sNtJ9aN5vdmwtmrh6Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec5c13-4fed-4aaf-9aae-08df472b3e53
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:25:16.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itFApcfnog+2CuVWkDAL4LDGePN1obPtqizGkCjmNF6S/4z5FuzVSlLnI2CD2Pgjpnw0ch8KkFVFr7apGV5usA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7997

On Fri, Nov 20, 2026 at 05:45:09PM +0100, Andrew Jones wrote:
> On Wed, Nov 18, 2026 at 03:22:42PM +0900, Koichiro Den wrote:
> > Check run_delay against last_steal and skip the update if they match.
> > This avoids accessing the SBI STA shared structure and marking its page
> > dirty on vCPU loads with no new steal time to report.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  arch/riscv/kvm/vcpu_sbi_sta.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> > index cfc6f22c3e33..8b2499876fb4 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> > @@ -31,7 +31,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  	__le32 sequence_le;
> >  	__le64 steal_le;
> >  	u32 sequence;
> > -	u64 steal;
> > +	u64 steal, run_delay;
> >  	unsigned long hva;
> >  	bool dirty = false, success = false;
> >  	gfn_t gfn;
> > @@ -52,6 +52,10 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  		return;
> >  	}
> >  
> > +	run_delay = READ_ONCE(current->sched_info.run_delay);
> > +	if (run_delay == last_steal)
> > +		return;
> > +
> 
> If we move the new check to just below the 'if (shmem == INVALID_GPA)'
> check then we also avoid a memslot lookup.

Indeed. Thanks for pointing that out! Will move the check in v2.

Best regards,
Koichiro Den

> 
> >  	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
> >  	might_fault();
> >  	if (WARN_ON(!user_access_begin(st, sizeof(*st))))
> > @@ -66,7 +70,7 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  	smp_wmb();
> >  	unsafe_get_user(steal_le, &st->steal, update_sequence);
> >  	steal = le64_to_cpu(steal_le);
> > -	vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
> > +	vcpu->arch.sta.last_steal = run_delay;
> >  	steal += vcpu->arch.sta.last_steal - last_steal;
> >  	unsafe_put_user(cpu_to_le64(steal), &st->steal, update_sequence);
> >  	success = true;
> > -- 
> > 2.54.0
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

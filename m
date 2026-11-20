Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195227;
	b=YM5b1e/Awq2W8Vkf/FFGjrV4FyHwT4C9+m7ZtrMjOUhai+/FCWBE/i6i0N4zOjViTCSY
	 3HwiMnj3+p95tdWqXRZUSc1QBNY3t//KwKpFVb+VFu4vgNJ5Nb4MeJO1qtdBZ5S1JSDtx
	 lxcfjf06skjwq7QFyi9ihuVlCjgIqNVhQKE/5R4/j1MM4N9YZxkX87AJPJnQ0KktCnTOf
	 4dEcvbOHkdZD6BDofk3ZAD/Rl9GaRp4mwoq1HinmMVfqfioOalryoyCW6qHkN/42FrL7u
	 08lYqfSOR9SydzrHjJu5tzn6SeaPn3av8emR/RDzfZl0mU0nL2CNCATwacUN6qrErFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195227;
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
	bh=mPHm1Dbd9ef/fbvart5AKZiVPKI84sppk7hd7DntVQc=;
	b=1Ttd1RzLN9kIhQjAJDFeFamWACUSEEgiEsyXtUUaKLXy2of+CuObV/JXv3BlOrMZQHKZ
	 ico6cdUISyKmTKGtf+Yp5vEhjS6XUpb405xln7krH/Pve37tYD0OoTDakBFbkzQAyj+c7
	 zXLfBqAlH7+uXeAp+1hdzMD8Mu9uvQ0le1fYrvUV3GczBY6idCukynZOpBxNJO1MY3Q5z
	 yTuJI4GeEmoViHCwO8SQmoA2ZoGwt3LD/klCjC5OlOltXcX2HEm5QJRRvilcTJ5IxD75I
	 fluJYmn/cfV9PWuoSnvlExQ57EB6fqO8t+usjltAqWFRxjZRb0Bq4NotzK8BEM3sDTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fOnCI2NN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.123
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B260A260A;
	Fri, 20 Nov 2026 17:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848B260A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fOnCI2NN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k11FAkGe4J/abbMxEM2CCyL3I7AJz8g/SYAIL/jabsH1DzppjANQcYR3uWvyu5ZPb6e7EFumCSBMAyaM/pLJAmpW5Clnb8xbaHW+YkQD5dWZA6N5yB2lMQTeRxqpfAoXeryUUiPQBTfrWEvHocRRFZbCBQgD372A0TU2yr25yCGekKJ5um4KG/euIMqc8EMJoYln3YRvbzZA6jGN8xRsO204CyX+IA8hbxdbf3qG6hTPsAw2B1/62nxg+17rKCDoIPFDo5NxqLr7U2b283nPlzJQwbHf6Ygex0l0OXubT0ecWOQhqe6DMa7aBRlyfFLV8FnDbwDfyUoZ36fq1WBlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPHm1Dbd9ef/fbvart5AKZiVPKI84sppk7hd7DntVQc=;
 b=Tcuzc9WcH4i9boXMZr2+wIMNyiicbuNxG7Pf3tSz/UydYWCo/65R7sAgZBSylCPpC0bJccDTTrNfv0T+nVujmvKE2YilB2JvySWo9d7pZomFBqoJk+Bh50Uw5/wWHJIEycdTF2O0zsHZK4hQN7D8uNnEGC8JbtZ+Ai12Hhz/8C21B8fiCy6YWRZwf32oiLpnMPT1aEAoko2sJybtTPs4ZDOsT+h3SyJolRWZqoJ0EgrxTmW7Sc+dRuRHP8r6EvPqJxA7B7YoVw+VEoOBesHugKzOKAQtpIoc147zZc0yiT0Twk1K7WjU70GOTempuRTSlZ7n8xUwIqta8EDDoWfUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPHm1Dbd9ef/fbvart5AKZiVPKI84sppk7hd7DntVQc=;
 b=fOnCI2NNUXhx+0LJ4zu8awljOcdBb2bzlp7ROHx8cB7FKxqJQ/UiyXrRl4lOzEIs+dcE4stogYntAwkDWslQjiwMNKgUwmX8WaeWrj3TIViW308ZpQ0RFJrxeA4kGuvqy9zqesq7zyhTgO4FTf1+dtyW63HmvXoGNiSivGwKwkg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB7342.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:358::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 17:20:19 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 17:20:19 +0000
Date: Sat, 21 Nov 2026 02:20:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Batch user accesses when updating steal
 time
Message-ID: <awB6FpVOpZ9fhMt1@z790sl>
References: <20261118062242.2914385-1-den@valinux.co.jp>
 <20261118062242.2914385-2-den@valinux.co.jp>
 <awB1hZGh3LYztjqL@orel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awB1hZGh3LYztjqL@orel>
X-ClientProxiedBy: TY4P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f98ffa8-cb0e-42e6-f5c9-08df472a8d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10070799003|4143699003|56012099006|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yqFcBeDAvDhk/hQ3sec2VZNN5GCBAxKrJVKJvMD5MGYTSo7h3xjmwIXdH8Gp5M+besUe+gsTyj+d3CjosGVpYtGZotL2YGWUi3Od1CL8+zkGTkOarJxyBG2pTBD0UdqJAP/z8m5tEhc7cWjl+mjm3r9iBn7oKX0lEIwSoe1aEDNWShzUSIkVRK8FqJHkKQ0qByNlFUhBL8uUHEGltBm7OeDrAce/jP+rg/jnTMTXZ6WcaF0pxNLXv/fEuMM+lFsQNOJHIM34/H43JrKJqn7WtX7tS/MvaPFznIHge7arbrb3BW+bKCsjEn9IAuEkisnbVylma7BehvmwUPQ4Hv3DZ0Bv9wQ8v849mjhHbiml8H52DSdbW2JOVgHcJiBCuKhiFLm/QRVQfIgUJV9FxZTqxeLAjclZAlTHITE0mljbeSKs6lfZ/epCgTMWGVmNdDAL5yCeW+bAlSjs17jm3Ds9yOBLwJFHawk7UmHmaD7q6HYMwXyBG4EPIbiFvv4OQkzqGZWSKTjWSlZwrPUrILhnEXuRDisNliojRgaowgpXw5tiKRzlww5BCkX/wtmhQe7Af0NfYb4nroMvgLM0EbDJgbusahqr3lOTsCT94ZfV/0D7B0MXg3t/veSiwtT5wePqSjSRsWyQJ3AtJlseI534M2vQ1x+xm0URks/3ez9xiW4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10070799003)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZwRn7eP+B9u2zYRFUdBMSgezCQlUpvbN3Wjscb1gDI1aaGpbWojA6F42D/6?=
 =?us-ascii?Q?IwpM2LmosNWIqrqGZ9al9hCws0QdUnlpPWyy/3ZjnCYp8tcSLzemPvgfG4cQ?=
 =?us-ascii?Q?mBY0sn2ZycAMrS8HvU8ZpIxhvDPBUTqJ2c5cf4dZOAM76+bzfYrVXp1oWNyX?=
 =?us-ascii?Q?YQi7cw1geYwZ13Vdvrm1cTjQEtOdgvUMQCszHJKyuCAtAjx5nwNWw6tCurci?=
 =?us-ascii?Q?9t2IkXug01oo3gwrvMqzEpalk9GxnKik+X1LJjcZVn2U2VAB8oNGcTpEMe2t?=
 =?us-ascii?Q?hbCG41L4aAsTzoF7lnrSR5sejHkvl537hZQJQN7jkBu1ViViQ/WWxSeGpcLI?=
 =?us-ascii?Q?WRvBEwJBAw4cLdfGZG+/abGamQZTwuYYQIdYRO5Ic4GMRueu4haspyj/Taq3?=
 =?us-ascii?Q?xjDNzVTKPZ0P9Yq+HmSEdk0aMVrNsqPKQOCfxanNDX/oI4C3nHpL8ugkUHKA?=
 =?us-ascii?Q?9sDx/zTdv8CfJFr3PRcXd7s5Vt12aBYi0TiOi/OjdQQJ+ns7ejy2LFzc0bnu?=
 =?us-ascii?Q?HbeOFvRJLcEzFeaOBAW0CBQTFDgl5zvH/FKUlM1OgixK9rsfSoM1OY/Kd4Hn?=
 =?us-ascii?Q?cal6rRKfbxOgFyVaIUVhLgX+2ozYzBDxpaN8cyN+f3/ECyW47IhB8yNJdnfk?=
 =?us-ascii?Q?fv7GKl+lVeDE4s+m0Cd8e1f455TDWPEBAr9l8N+1tzGLq94QPrpCULGs33cR?=
 =?us-ascii?Q?SrAgPLL5fPKqBk3kCciXhlFBzXwKgveaFbkE/w3CEzjH8hvPRDdxG4Ii5Itg?=
 =?us-ascii?Q?FBg+Hovu1CeoX7kA9P58Kmkzd3X596VGHu3N2EumiLGwYTa8Hj/HtN6ox3ta?=
 =?us-ascii?Q?l2o733xOoQkbjWPVHbweIMljA8nE8DBqXs7bjTPxiYuweWbcLUsWmdy2pA7/?=
 =?us-ascii?Q?vTbjr18xUArLh/VNBpCfTy9CYFzqDEslfofWXGWZj/4oJ5pcHFooQpGlp9OC?=
 =?us-ascii?Q?6dT/F0SBzGConpLVB5og/NxGfrnuPVMHkfqNSQ8NrdabiBsHwv+TA81va9jO?=
 =?us-ascii?Q?sXapj9NQoM85Xc7ndp+RnpHbKcVwaoHEN++96sBqbgf2znUggGIEhuxNT1C5?=
 =?us-ascii?Q?oRgnxlsjZuLYFNf1wPGq1JOdfPAR1rpHQJXv90jxJzAXHeD5oo3IoFzScvdt?=
 =?us-ascii?Q?mI9nKkBstOsehOptLe069nzFnni3tC05UwtW1R1CRuIlj+EgrVl46c01Zdmu?=
 =?us-ascii?Q?7G1GRCp0FklmDGeuEo9kb1MNxvnG7kz24CGiyt8Qe1tCR2bCZmAwkXPRDMeD?=
 =?us-ascii?Q?/KMTwoceSG1mnhG4H/x50XnXNrIF3PzFn0n6RYaqfitj+/8BWFgETudh8olz?=
 =?us-ascii?Q?SSgJA6KAHa19qpPI/iTPrJJHOQo6MpbYyvIR9zMd+ClGizC+U6WYH2KwrDI6?=
 =?us-ascii?Q?WGEz7ESEBzcHPBX5f4Zkvx3fZblwH0QH5PA7jwybY8fDIXCxyzd8mx4UluAu?=
 =?us-ascii?Q?Gme708uD9GSw04HZ5Y3GohAhcJbmvFpLZUiqnBjHVTqQCugDNa/hTl196oLw?=
 =?us-ascii?Q?uSmC6guHUmBw6LjxoDPeDmB8iiwv4012aVNAZgcS/eZ/L2Qd51cPcQcID70C?=
 =?us-ascii?Q?3FDNb1FUiW1mFvGu6/mChMjRMJKzc3nNJCdTzFQKC9WXB9sHI/Gb4gSU1TH/?=
 =?us-ascii?Q?PXYkW28mxd4WLF95lvqggLQG5wey4tR+Rh4IHtvFxwM4qLOTxF82hi/UAr3J?=
 =?us-ascii?Q?2anLtrfzwunmJJ0C73TClLfKBgBAWu+oDfYnMgVDuLQH5UazgkimBjAtIrco?=
 =?us-ascii?Q?XP7h9KTj5PAOOmwir4KRQYqv1AZZ8EiFiTdHBH8+sv+1NTnVxN7h?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f98ffa8-cb0e-42e6-f5c9-08df472a8d23
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:20:19.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UA/hulfigJDvQM6FAsTbyZhoKSROs7nW/ryg6qLyViVOuXrOC8kIl+lW3LjLKCuCkmTvvvbvoxUMUEFVddyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7342

On Fri, Nov 20, 2026 at 05:40:29PM +0100, Andrew Jones wrote:
> On Wed, Nov 18, 2026 at 03:22:41PM +0900, Koichiro Den wrote:
> > Updating the SBI STA shared structure performs 2x get_user() + 3x
> > put_user() calls, each of which toggles sstatus.SUM.
> > 
> > Keep SUM enabled across all five accesses to the shared structure.
> > 
> > Note that write barriers are added to order the odd sequence store
> > before the steal-time update and the even sequence store after it.

Hi Andrew, thanks for the review.

> 
> The barrier additions should probably be posted separately with a Fixes
> tag.

That's exactly what I wasn't sure about when I read the ISA spec.
It was unclear to me from the Zicsr ordering rules whether the SUM toggle in
the old code's get_user() and put_user() calls also order the stores to 'sequence'
and 'steal' as seen by another hart.
(I don't think they do, but I'm not 100% sure. It feels a bit like trying to
prove a negative, as I couldn't find a clear statement. I may have missed one
though. OTOH, the new code surely needs the barrier, so I included them.)

Do you read the spec as allowing another hart to observe those stores out of
order in the old code? If so, I agree the barriers can go in a separate patch.

> 
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > To reviewers: please let me know if you'd prefer
> > scoped_user_rw_access() here.
> > 
> >  arch/riscv/kvm/vcpu_sbi_sta.c | 59 ++++++++++++++++++++---------------
> >  1 file changed, 34 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> > index 60e50296a008..cfc6f22c3e33 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> > @@ -8,13 +8,14 @@
> >  #include <linux/kvm_host.h>
> >  #include <linux/mm.h>
> >  #include <linux/sizes.h>
> > +#include <linux/uaccess.h>
> >  
> > +#include <asm/barrier.h>
> >  #include <asm/bug.h>
> >  #include <asm/current.h>
> >  #include <asm/kvm_vcpu_sbi.h>
> >  #include <asm/page.h>
> >  #include <asm/sbi.h>
> > -#include <asm/uaccess.h>
> >  
> >  static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
> >  {
> > @@ -26,13 +27,13 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  {
> >  	gpa_t shmem = vcpu->arch.sta.shmem;
> >  	u64 last_steal = vcpu->arch.sta.last_steal;
> > -	__le32 __user *sequence_ptr;
> > -	__le64 __user *steal_ptr;
> > +	struct sbi_sta_struct __user *st;
> >  	__le32 sequence_le;
> >  	__le64 steal_le;
> >  	u32 sequence;
> >  	u64 steal;
> >  	unsigned long hva;
> > +	bool dirty = false, success = false;
> >  	gfn_t gfn;
> >  
> >  	if (shmem == INVALID_GPA)
> > @@ -51,31 +52,39 @@ void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  		return;
> >  	}
> >  
> > -	sequence_ptr = (__le32 __user *)(hva + offset_in_page(shmem) +
> > -			       offsetof(struct sbi_sta_struct, sequence));
> > -	steal_ptr = (__le64 __user *)(hva + offset_in_page(shmem) +
> > -			    offsetof(struct sbi_sta_struct, steal));
> > -
> > -	if (WARN_ON(get_user(sequence_le, sequence_ptr)))
> > -		return;
> > -
> > -	sequence = le32_to_cpu(sequence_le);
> > -	sequence += 1;
> > -
> > -	if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
> > +	st = (struct sbi_sta_struct __user *)(hva + offset_in_page(shmem));
> > +	might_fault();
> 
> We're probably safe to drop this might_fault(). But either way it's fine.

I kept it to preserve the check we get from get_user()/put_user().
I don't think it's indispensable here either. I'll probably drop it in v2.

Best regards,
Koichiro Den

> 
> > +	if (WARN_ON(!user_access_begin(st, sizeof(*st))))
> >  		return;
> >  
> > -	if (!WARN_ON(get_user(steal_le, steal_ptr))) {
> > -		steal = le64_to_cpu(steal_le);
> > -		vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
> > -		steal += vcpu->arch.sta.last_steal - last_steal;
> > -		WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
> > -	}
> > -
> > +	unsafe_get_user(sequence_le, &st->sequence, fault);
> > +	sequence = le32_to_cpu(sequence_le) + 1;
> > +	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
> > +	dirty = true;
> > +
> > +	/* Publish the odd sequence before updating stolen time. */
> > +	smp_wmb();
> > +	unsafe_get_user(steal_le, &st->steal, update_sequence);
> > +	steal = le64_to_cpu(steal_le);
> > +	vcpu->arch.sta.last_steal = READ_ONCE(current->sched_info.run_delay);
> > +	steal += vcpu->arch.sta.last_steal - last_steal;
> > +	unsafe_put_user(cpu_to_le64(steal), &st->steal, update_sequence);
> > +	success = true;
> > +
> > +update_sequence:
> > +	/* Publish stolen time before completing the update. */
> > +	smp_wmb();
> >  	sequence += 1;
> > -	WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
> > -
> > -	kvm_vcpu_mark_page_dirty(vcpu, gfn);
> > +	unsafe_put_user(cpu_to_le32(sequence), &st->sequence, fault);
> > +	goto out;
> > +
> > +fault:
> > +	success = false;
> > +out:
> > +	user_access_end();
> > +	WARN_ON(!success);
> > +	if (dirty)
> > +		kvm_vcpu_mark_page_dirty(vcpu, gfn);
> >  }
> >  
> >  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> > -- 
> > 2.54.0
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

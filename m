Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA332E72F;
	Fri,  8 May 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268675; cv=fail; b=BxeHoxFy8nYuTFBDagA54K/ogatz/dDuWJVFwPsoDqf+7soIlYUEyS7+KiSN9ypvNwX2OCjTx9/6ZMmyZod+SGiJ6H/Dl/5Y4HLpKIyjGcKL3QILvgI1Xa16FpoYF5fgmk1pgPSwFT/D4U3zg4rXFn2WCl8hSVyPrZ/kUxOMZ74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268675; c=relaxed/simple;
	bh=RgJYdtphQIdAFfohvmcB1JZ3fAaegyb2RBq5M5RZSBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HJ4ytHIWqInsixrTTgvDnwSfrG1y5jkWAsoLo6ZnYcjrE06Sc08q3adGGMFqUcNy6muEG+UTQWI2c5Bq5YBbIgxtnAnhirin7BWE6VEh2mKuYVPX+26beTDsE/Vib+XLy/c1UNaM2ThS9QODDLh9P4u79An5PBFkvqnC/dTuqDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pSVBueF3; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pSVBueF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL/Wz/JoTQrbN0uVca+kp1bvHoOokqG5FwtJjaoMNenm3N7RKT2rQgkeAZt5tahKZT9QDKAfI+fhRpkgUwuCwtdab9AXINtrTk0EqYaVcVTqB0Umgxla5iyDoSytR+ZDUxF1/V9kgKSJCNB417R/PShb+Y0AAZ1saeIkzGLIAJMfqZKTbRD8TAExibbdUb2BTTS40SJGY1uwlaX+TJ+8IQMKH2rCc334jGCl/yuGuhL8BZ76H+nUtg5REXpkJ0GFaSEs0K6UFAyxzZF87tyEVLXZVXiieJtwMjWVbI6ZNdEunL1L3bDYRfjSii+wmTFSx4rVrbxwUSowRY49qkOG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzFVWNYgYLm9mck9aplpC4eC5NUs7gdtQqRshgIUOrA=;
 b=P9/RgqlaLKtgUNCVDnWtNI8+Gi908ChcZT9ZTodfENu7GtsjRn6iM+a5nx8UtqCtHOll6z1MViaqUSQsi6XcGM/tF2bYeJXVnVqw09ux2LTE+lnePpd2m6aCUspbMYZxi4y379/R30ZXk53XQUIAKLm/nPnJAmjclVENTc4ThVztXejzCjqobevHG5h4rFWJIbZcvmmc8FYD7hd5ZrKnBZ3kKCWjY4J+/LfTmDt6vM3r2q0xeHX1zwbnojJj8N+m6ihBgjKQ0Af6ZSWlfC0BNDbRo4ZxfvnkRifB1TmZtsQ74Kas09dLIhYcbksS1E462Jvel2Iyi30RIgkMMWF9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzFVWNYgYLm9mck9aplpC4eC5NUs7gdtQqRshgIUOrA=;
 b=pSVBueF3CizZokLPvnXUZj0WVNnMG6Qu847/4miQOOMHwwS8PpBKQKwiyB1a8QZMAfYa4X/bSabKoMgg1UtqUC8hoZl4eVdU87EhLLZD3oJeY48FGrqfT5yUlfI3RqXPPs6teL0ZVqfGongYjvc7xlZjVwKtcRBHBcVgpcC8VtY=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.20; Fri, 8 May 2026 19:31:06 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%2]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 19:31:05 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: Bug with nested PAUSE intercept on SVM
Thread-Topic: Bug with nested PAUSE intercept on SVM
Thread-Index: AdzGtpiRjeqXsvC5QHu6t6J5p0N2hwABTvkAAAAZvfAF68uBMAAnO5cAAAYbNXA=
Date: Fri, 8 May 2026 19:31:05 +0000
Message-ID:
 <DS7PR12MB8201B1E8622A6901A13A70F6943D2@DS7PR12MB8201.namprd12.prod.outlook.com>
References:
 <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <adVL9nqJhJwvu1QO@google.com>
 <DS7PR12MB820106A839105CD9E9E62328945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <DS7PR12MB82010A5DF5F8DE5830CF16F9943C2@DS7PR12MB8201.namprd12.prod.outlook.com>
 <af4QQFoMU6r7GnLZ@google.com>
In-Reply-To: <af4QQFoMU6r7GnLZ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T19:27:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: a9a01113-e569-4c56-0cf4-08dead385921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|3023799003|22082099003|56012099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 BIhDjC5SjLG9OnDHX6kO/aO89Sp3lse0kUeSJ6woO7FagIxq7rG3yrNRS0a1uUq0ZNus805YPv0fA3pojr3cBsVnsfXqgOERRl8hFHr3GIfqk1uZ6f/j9WOdTfv3QiQosS4/RrJLJyUx3VohRLL4AYUwoBMlJao6X8hn3UDGFby8rUDo6tT0B9k5OqhTpN5S7UiVRTop9dRzmL85r4WFuUnYVExaSMfiN8NoNX1dpSifP3WzeDHHoRoggi/DDmp+YhGdKPeBWcfI0WqcY3F424oMtJcltPpY2tVHBWNdaAAcqKhWX8hqqDjR08rh7UGv8GLiXJQooMv7SQ2TS4UpB9YE9UTV+UxE7oTliN6qg/A0N1OWIGvBu1eTmA/WprKYqiU+nN66saTyIlguXGZbS1IIjUt/m7UyMatwtHPKbzYPxsuwWPPiPYgTkXQbm2DynvjLQf3Q5VuUSQ2yrokdDHYQFh6FtqfWgAKZrLKrIG7e6BQ1B9/DLNjX56MsE9ZvYALbmFy8qh+oKe1RMZIJO6P54m9DK1lAc+J2QU5P1F36O8Bq6WQEqISgFOh8am++pwLg8alyRlij2DmvCG2Jzg1oxIlUFWsASS3uRjG7Ew5ALtIhQve4IdhVQYjW1vuytLeei+VmaH8pv5rmn1uJ/Ou7/KJWtI0dB/zMzsfHm9XU1iMlSj9N3SAoZ7fq26TwheE9OziF1q3oyJPmjwy/Pu3hLgXClct+chUr8ET8hv65EANBeirSvFi9RAn3uEpi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(22082099003)(56012099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?82ctlQXWQLPpRGtFtD6uwJkTjuDgbhQAQm5I7XJixGtsORlwTe/2p5dCvRR+?=
 =?us-ascii?Q?IMAAvoUPpUiKSaQeThKeb70Tq+cBGbhRPsaMfvcEPhztJnexP/Qvkt+zDzjB?=
 =?us-ascii?Q?goCTtt9/b6IoiyVmUv+KfrgZFrqv1CvBBoYB9nzsSPR+qnMlNxVIIis8TwCY?=
 =?us-ascii?Q?mdI5XDoYnIs5r3ky94r2JldJ3mN5kvLDZS+7GAZ9a9X+oqnP84rDNezp8Urg?=
 =?us-ascii?Q?7cwc5ozdApVcagMhEmpTa100zSyXzDwzb25k0NzwBoPv43diDe18M7gps1NR?=
 =?us-ascii?Q?ftdDgDbP6doWoKMw+SzkgmrnuNblR66GmnUZvOovLWph4zYdk9t2Fdw/WfdA?=
 =?us-ascii?Q?CJJs7xAmofaUnbuL//7rc51zTR4VLZCGjbxevZAd8ZHWg4ro0Wk/AN/c64Ip?=
 =?us-ascii?Q?NERHmrobJdUlwQvhXdCrJHPsOs7dQXGk2un4YbqXPxXjKOkubptdu8ag2ZuF?=
 =?us-ascii?Q?pBm21CpdmUmI/hfi1KkwdCvsDp1xnZyijzcnZRsPBsT2WrG3tf4IgrJUvDim?=
 =?us-ascii?Q?GMrDLXLyI9lrRW3Nmdu+uBTy3JbnmjxBzpF3bYd+KeT2ShM7igzcXx2hQ6Ub?=
 =?us-ascii?Q?vU1kEiCyNSaglt3uyneGEhYqvWQqt+soRJxALDfR3eZZ0+iZKG3h0tADW7rR?=
 =?us-ascii?Q?9YtiWydu1ajojYlhoqnGhV2rIaqIPY3F4VChyjPc5NmwGocJUo7eqCReHAuK?=
 =?us-ascii?Q?Qz8udy5d5VmubzAbfoCIJXTVDiB5m+FsB6OIG+sMhmj+DK1GW0uvnzZH8FKA?=
 =?us-ascii?Q?WoEWnGl7VICYSBiP7fftNE84U29iG6CZqrocAAAt816kZUU7mLef4w9xvfIi?=
 =?us-ascii?Q?Eo+uZReeYMTQaGX1Tf4hOGT+kv/w25OaytvDC95e4trcMj85SBcq6vxJP2L4?=
 =?us-ascii?Q?cHgpqZhtR5P9UxiyKAFQDzBSq9uUzK6Uqn7cCkUAF+F/FMnR2k2lRQh4W3mi?=
 =?us-ascii?Q?98muA6RLml1OzMsT3P9nWEwOGoBu5+Tfni/uKE3pSbqFm1yuJofu3YjbVQZF?=
 =?us-ascii?Q?Bh7R2EOYoB0UvyZ6Zz4kiYz+73Ii7RdYDRlNetPeZMl/2A7by9rcPbcEIMWw?=
 =?us-ascii?Q?I0e6+DOmKljH82GzgRuNboc1zDqs3O1j8Y5y7rupS7BdKLmYLriUzpg+N04I?=
 =?us-ascii?Q?JADBFaK+Rw2vwAxOIa8scQiyHY5zzutJLgZEfNyxwnvJqodBiJ+PdWrXrDSN?=
 =?us-ascii?Q?N7OmEafmfALFsDg+NUrzt4oL/mhRy9DlxSiiXUqHUpxcBbnUZOvpfqpWv0D5?=
 =?us-ascii?Q?HWlmVPPeUllm4F2LpPYpbTJ8PDHXm3GlP/SZBSLVsTjAdGoNWz+lySe2gqxC?=
 =?us-ascii?Q?jv0W1nLZ+5GV1bAf5c0gJAq5v5ONlKdmLpvyjj6UEyN16QackDEL2Uax1aPz?=
 =?us-ascii?Q?JD+/Sv/OxnVZiGtq8CKPN0eTynoFX1baACV0rnJAbgCE8Pvl3ccEGGpuYfir?=
 =?us-ascii?Q?svGfw/ECReUNlQ8b0Bwu4G8zf+yHREGwTDCORfUFepnsopdDQN5oGuC7AAWB?=
 =?us-ascii?Q?G34x3Lt2dkjMddLtIZdESKO+3vgnZB6/0do0QthwGOKzXqSOWeRn+X0b/H1X?=
 =?us-ascii?Q?7NpI2y+jheiubWyComGVdQyoUAr5gmVvFvCTuqNOosIWRTLUBD5k3EaG8NmI?=
 =?us-ascii?Q?vYWjN/aOTAGDxIPWNyTuWKa+AZDkFPscSxGwVFfRNINlh4b9LEcuHvE79qSN?=
 =?us-ascii?Q?EfI8zzQ5w0LTjVB1sbK/tRuTocOOxLPJX4f6B9AM+W+A3nhB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a01113-e569-4c56-0cf4-08dead385921
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 19:31:05.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVxhy3i3WdR+kxZFYa4OTIw/LPmZjfO0914HiMH+8JV5dxDYtWDqzwkqPnIgP09G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

AMD General

> -----Original Message-----
> From: Sean Christopherson <seanjc@google.com>
> Sent: Friday, May 8, 2026 11:33 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: kvm list <kvm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> Andrew Cooper <andrew.cooper3@citrix.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: Bug with nested PAUSE intercept on SVM
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Thu, May 07, 2026, David Kaplan wrote:
> > > From: Kaplan, David
> > > > From: Sean Christopherson <seanjc@google.com>
> > > > On Tue, Apr 07, 2026, David Kaplan wrote:
> > > > > Hi,
> > > > >
> > > > > On AMD SVM when the L1 guest is trying to intercept every PAUSE
> instruction
> > > > > in an L2 guest, the PAUSE intercept sometimes fails to fire.  I h=
ave a
> theory
> > > > > on the source of the bug and also included a short reproducer bel=
ow.
> > > > >
> > > > > In this scenario, L1 has created a guest with the pause count and
> threshold
> > > > > set to 0, and the PAUSE intercept bit set.  I *think* the bug is =
that if the
> > > > > vCPU gets scheduled out on L0 while we're in the L2 guest, then u=
pon
> > > > > resuming the vCPU KVM calls shrink_ple_window() which doesn't
> appear to take
> > > > > into account the fact that svm->vmcb might be for the L2 guest an=
d not
> the L1.
> > > > >
> > > > > As a result, it looks like it sets the pause count to the default
> > > > > (3000) causing many PAUSE instructions in L2 to not be intercepte=
d.
> > > >
> > > > It's probably even simpler than that: KVM is completely broken.
> > > >
> > > > https://lore.kernel.org/all/20250131010601.469904-1-
> seanjc@google.com
> > > >
> > > > Paolo, can I finally apply that patch?  I brought it up in PUCK a w=
hile
> back,
> > > > and IIRC you were resistant to dropping "support" for cpu_pm=3Don
> setups.
> > >
> > > Interesting.  But does that patch solve my problem?  It looks like it=
 would
> > > still call shrink_ple_window even if L2 was scheduled out and change =
the
> > > page_filter_count in vmcb02, if I'm reading it correctly.
>
> Gah, probably not, because KVM does special case the scenario where L1
> wants to
> intercept PAUSE unconditionally.
>
>         if (kvm_pause_in_guest(svm->vcpu.kvm)) {
>                 /* use guest values since host doesn't intercept PAUSE */
>                 vmcb02->control.pause_filter_count =3D pause_count12;
>                 vmcb02->control.pause_filter_thresh =3D pause_thresh12;
>
>         } else {
>                 /* start from host values otherwise */
>                 vmcb02->control.pause_filter_count =3D vmcb01-
> >control.pause_filter_count;
>                 vmcb02->control.pause_filter_thresh =3D vmcb01-
> >control.pause_filter_thresh;
>
>                 /* ... but ensure filtering is disabled if so requested. =
 */
>                 if (vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_PAUSE)) {
> <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                         if (!pause_count12)
>                                 vmcb02->control.pause_filter_count =3D 0;
>                         if (!pause_thresh12)
>                                 vmcb02->control.pause_filter_thresh =3D 0=
;
>                 }
>         }
>
> But that's just a bug in my patch, because I very much intended to disabl=
e
> KVM's
> PLE shenanigans entirely:
>
>  : Never use L0's (KVM's) PAUSE loop exiting controls while L2 is running=
,
>  : and instead always configure vmcb02 according to L1's exact capabiliti=
es
>  : and desires.
>
> I just forgot about the shrink case (the grow path should be unreachable)=
.
> Does
> this fix your setup?  (compile tested only)
>
> ---
> From: Sean Christopherson <seanjc@google.com>
> Date: Thu, 30 Jan 2025 07:48:41 -0800
> Subject: [PATCH] KVM: nSVM: Never use L0's PAUSE loop exiting while L2 is
>  running
>
> Never use L0's (KVM's) PAUSE loop exiting controls while L2 is running,
> and instead always configure vmcb02 according to L1's exact capabilities
> and desires.
>
> The purpose of intercepting PAUSE after N attempts is to detect when the
> vCPU may be stuck waiting on a lock, so that KVM can schedule in a
> different vCPU that may be holding said lock.  Barring a very interesting
> setup, L1 and L2 do not share locks, and it's extremely unlikely that an
> L1 vCPU would hold a spinlock while running L2.  I.e. having a vCPU
> executing in L1 yield to a vCPU running in L2 will not allow the L1 vCPU
> to make forward progress, and vice versa.
>
> While teaching KVM's "on spin" logic to only yield to other vCPUs in L2 i=
s
> doable, in all likelihood it would do more harm than good for most setups=
.
> KVM has limited visibility into which L2 "vCPUs" belong to the same VM,
> and thus share a locking domain.  And even if L2 vCPUs are in the same
> VM, KVM has no visilibity into L2 vCPU's that are scheduled out by the
> L1 hypervisor.
>
> Furthermore, KVM doesn't actually steal PAUSE exits from L1. If L1 is
> intercepting PAUSE, KVM will route PAUSE exits to L1, not L0, as
> nested_svm_intercept() gives priority to the vmcb12 intercept.  As such,
> overriding the count/threshold fields in vmcb02 with vmcb01's values is
> nonsensical, as doing so clobbers all the training/learning that has been
> done in L1.
>
> Even worse, if L1 is not intercepting PAUSE, i.e. KVM is handling PAUSE
> exits, then KVM will adjust the PLE knobs based on L2 behavior, which cou=
ld
> very well be detrimental to L1, e.g. due to essentially poisoning L1 PLE
> training with bad data.
>
> And copying the count from vmcb02 to vmcb01 on a nested VM-Exit makes
> even
> less sense, because again, the purpose of PLE is to detect spinning vCPUs=
.
> Whether or not a vCPU is spinning in L2 at the time of a nested VM-Exit
> has no relevance as to the behavior of the vCPU when it executes in L1.
>
> The only scenarios where any of this actually works is if at least one
> of KVM or L1 is NOT intercepting PAUSE for the guest.  Per the original
> changelog, those were the only scenarios considered to be supported.
> Disabling KVM's use of PLE makes it so the VM is always in a "supported"
> mode.
>
> Last, but certainly not least, using KVM's count/threshold instead of the
> values provided by L1 is a blatant violation of the SVM architecture.
>
> Fixes: 74fd41ed16fd ("KVM: x86: nSVM: support PAUSE filtering when L0
> doesn't intercept PAUSE")
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 43 +++++++++++++--------------------------
>  arch/x86/kvm/svm/svm.c    |  9 ++++++--
>  2 files changed, 21 insertions(+), 31 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 961804df5f45..b340dc9991ad 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -160,6 +160,16 @@ void nested_vmcb02_recalc_intercepts(struct
> vcpu_svm *svm)
>         if (!intercept_smi)
>                 vmcb_clr_intercept(&vmcb02->control, INTERCEPT_SMI);
>
> +       /*
> +        * Intercept PAUSE if and only if L1 wants to.  KVM intercepts PA=
USE so
> +        * that a vCPU that may be spinning waiting for a lock can be sch=
eduled
> +        * out in favor of the vCPU that holds said lock.  KVM doesn't su=
pport
> +        * yielding across L2 vCPUs, as KVM has limited visilibity into w=
hich
> +        * L2 vCPUs are in the same L2 VM, i.e. may be contending for loc=
ks.
> +        */
> +       if (!vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_PAUSE))
> +               vmcb_clr_intercept(&vmcb02->control, INTERCEPT_PAUSE);
> +
>         if (nested_vmcb_needs_vls_intercept(svm)) {
>                 /*
>                  * If the virtual VMLOAD/VMSAVE is not enabled for the L2=
,
> @@ -819,7 +829,6 @@ static void nested_vmcb02_prepare_control(struct
> vcpu_svm *svm)
>         struct vmcb *vmcb02 =3D svm->nested.vmcb02.ptr;
>         struct vmcb *vmcb01 =3D svm->vmcb01.ptr;
>         struct kvm_vcpu *vcpu =3D &svm->vcpu;
> -       u32 pause_count12, pause_thresh12;
>
>         nested_svm_transition_tlb_flush(vcpu);
>
> @@ -947,31 +956,13 @@ static void nested_vmcb02_prepare_control(struct
> vcpu_svm *svm)
>                 vmcb02->control.misc_ctl2 |=3D
> SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
>
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_PAUSEFILTER))
> -               pause_count12 =3D vmcb12_ctrl->pause_filter_count;
> +               vmcb02->control.pause_filter_count =3D vmcb12_ctrl-
> >pause_filter_count;
>         else
> -               pause_count12 =3D 0;
> +               vmcb02->control.pause_filter_count =3D 0;
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_PFTHRESHOLD))
> -               pause_thresh12 =3D vmcb12_ctrl->pause_filter_thresh;
> +               vmcb02->control.pause_filter_thresh =3D vmcb12_ctrl-
> >pause_filter_thresh;
>         else
> -               pause_thresh12 =3D 0;
> -       if (kvm_pause_in_guest(svm->vcpu.kvm)) {
> -               /* use guest values since host doesn't intercept PAUSE */
> -               vmcb02->control.pause_filter_count =3D pause_count12;
> -               vmcb02->control.pause_filter_thresh =3D pause_thresh12;
> -
> -       } else {
> -               /* start from host values otherwise */
> -               vmcb02->control.pause_filter_count =3D vmcb01-
> >control.pause_filter_count;
> -               vmcb02->control.pause_filter_thresh =3D vmcb01-
> >control.pause_filter_thresh;
> -
> -               /* ... but ensure filtering is disabled if so requested. =
 */
> -               if (vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_PAUSE)) {
> -                       if (!pause_count12)
> -                               vmcb02->control.pause_filter_count =3D 0;
> -                       if (!pause_thresh12)
> -                               vmcb02->control.pause_filter_thresh =3D 0=
;
> -               }
> -       }
> +               vmcb02->control.pause_filter_thresh =3D 0;
>
>         /*
>          * Take ALLOW_LARGER_RAP from vmcb12 even though it should be saf=
e
> to
> @@ -1298,12 +1289,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
>         /* in case we halted in L2 */
>         kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
>
> -       if (!kvm_pause_in_guest(vcpu->kvm)) {
> -               vmcb01->control.pause_filter_count =3D vmcb02-
> >control.pause_filter_count;
> -               vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
> -
> -       }
> -
>         /*
>          * Invalidate last_bus_lock_rip unless KVM is still waiting for t=
he
>          * guest to make forward progress before re-enabling bus lock det=
ection.
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e7fdd7a9c280..ac21f402c1ca 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -913,7 +913,12 @@ static void grow_ple_window(struct kvm_vcpu
> *vcpu)
>         struct vmcb_control_area *control =3D &svm->vmcb->control;
>         int old =3D control->pause_filter_count;
>
> -       if (kvm_pause_in_guest(vcpu->kvm))
> +       /*
> +        * While running L2, KVM should intercept PAUSE if and only if L1=
 wants
> +        * to intercept PAUSE, and L1's intercept should take priority, i=
.e.
> +        * KVM should never handle a PAUSE intercept from L2.
> +        */
> +       if (WARN_ON_ONCE(is_guest_mode(vcpu) ||
> kvm_pause_in_guest(vcpu->kvm)))
>                 return;
>
>         control->pause_filter_count =3D __grow_ple_window(old,
> @@ -934,7 +939,7 @@ static void shrink_ple_window(struct kvm_vcpu
> *vcpu)
>         struct vmcb_control_area *control =3D &svm->vmcb->control;
>         int old =3D control->pause_filter_count;
>
> -       if (kvm_pause_in_guest(vcpu->kvm))
> +       if (is_guest_mode(vcpu))
>                 return;
>
>         control->pause_filter_count =3D
>
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> --

Thanks! I tried this patch with the pause test I sent out earlier and it se=
emed to work as expected.  The test now passes under both bare-metal and ne=
sted virt conditions.

Tested-by: David Kaplan <david.kaplan@amd.com>

--David Kaplan

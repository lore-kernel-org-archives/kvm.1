Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32825D215;
	Wed, 29 Jul 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288902; cv=fail; b=qE9NLnkrlzhaBXAmIpCMf0zkjeCQZ4tlcO5rRkv918H3I+7oZ6108EI9865c4OkUMHVOTc536Hx3ZyOJJOklJY2lOrHA56eW4Hfo3t9FNrb3v7wLX6OgZAmpsuGVMuExjsTxJRP2XrHEvnsPOM/Z6/jkr1iwkk3buzsP1rTemaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288902; c=relaxed/simple;
	bh=yJzHGpHs+hwJK4Qy2K6iA8hLV3OdmD2vaDzi+U8yV5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hj/3wLjNUL2dC8Ahlh0CWTg5jdVs2o79REi/wHEkLRWLTB6ygyPm0BxsWx0UIvjcqzWu4OBSpxPBGBVy3qiurU4kZ/RYD7nwRH1pNwEjmbzSGHftESKdzd0jIWKwvObYqSaSKXZ/LDAmM2VUkn/pdaHky03KZY36Knn4DOaEbHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhmNusNo; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhmNusNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785288901; x=1816824901;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yJzHGpHs+hwJK4Qy2K6iA8hLV3OdmD2vaDzi+U8yV5g=;
  b=nhmNusNozll24c34Iy0HtdtVJ4xLrQcMgFAI5Hm63sx0l+FOjmL9I9oD
   96fHQbcJ8KFC2w2/M3EKDZZc5tYY5yJuRIXg0SKQ9v0jxZtjQs5lmI7XX
   XfxbcOjo8VKedVockl3itHfK25QxVUGEaIXceatZI9FmOBYvc9inRk+fK
   W1gohAiyasehRH5sYCqpGDi8rr5pUqP5BZOym1/+Nlepv55HfOGmnkSJq
   0OOSbVP5Y7zmAOge2FaCqzcXaHTcUaEHIZ5WASdj4P9/Ry8N2JnuTBgOp
   e2lSWoBrMGfqX0F9N2zkaql/o9kuMz+UTgjoDjDrQqApm/V9GCMzV3yLK
   g==;
X-CSE-ConnectionGUID: A8aXeTSvR3S2Xb010HBarQ==
X-CSE-MsgGUID: 6We2/iYwSpOW2QdooUU1Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85903479"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85903479"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 18:34:55 -0700
X-CSE-ConnectionGUID: lq6/xULTQG22nhmw5Kp0HQ==
X-CSE-MsgGUID: F+YONTMUQkKukFVWZHuu/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="256530049"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 18:34:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 18:34:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 18:34:53 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 18:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTX4xz9S3XQspTldtllB9wppDWkogVJZy60npAmxCz3EsemVS/xtW4TaUOQlVxJrjbmQ60JmwZ/bd279pBETR++5CbuLsbRK2ajz+j8IEFIbXERdlOFnkqLYU/f6bf9rZDq0xeG1v5mP9fFD+F9ARx6xWa/TfVqOhO9FvW3MwtoTsX03qGwzKjyPO7FjmwDydlEwE6lpHFf0kv7yWaBqKHqYRRD3CWxjcETQxPsfLgDWc4W94aId9FDHZqbxIgJ1KjSlR5gzCD8L5WaxvlETO+0oR/yptxiCwu3ZK0NDrf5guZenpoln3RAnR3g7/puRXDge+tEOaFwK9gAPnO11FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JbR8C0ZkfMXpxraZn2+nFOtflhh6pO9OQWqMbU0zKw=;
 b=Hphw5n0dqtNORk9Zpa3JKKIuzgCX9x8ScTQKYIZqxTndLo8hybyiNmo9wgTu5MOZwTuizmCYaBm4OyndpMhGcHKzbuUJEsywKc+B42cVvftZNqywOnjbCmxQsNGR2RAqOL4V+1NQpo76D4VwR/d8g4YBeyD+DudZU83juFS1ppPdpwmAJCRIjJZ4Rm/WUJQn1/NH4Y4aBCFL5NvM8ldKimr+m5j8myuJmLVKIrDUnSBIfq561CEvRj6bHrtV2Zt+BMUW82nW8ptQfzeBZxzaZaWCespSauMuKUCR7tU9Gps7gjDgaaKoXe9aPhNPZ3XgDHizhkmv20FKyCsGYI2C6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by DM3PPFD320E2257.namprd11.prod.outlook.com (2603:10b6:f:fc00::f51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 01:34:51 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 01:34:51 +0000
Date: Wed, 29 Jul 2026 09:34:40 +0800
From: Chao Gao <chao.gao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <jmattson@google.com>
CC: <kvm@vger.kernel.org>, <isaku.yamahata@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
Message-ID: <amlYsJzUurSeYlTm@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
 <aliWoldWX9/9tqNn@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aliWoldWX9/9tqNn@intel.com>
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|DM3PPFD320E2257:EE_
X-MS-Office365-Filtering-Correlation-Id: 705defc6-61d1-4dd7-f6b1-08deed119444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4sdnft7OLcian//D1fcjpBSjFcb9BnLHdnrMJ2fUKb4kg6BsAl4Y5EelE5v//glsnh+OBNbZZJ8hSokUiSoAnJKL31NDFW6XIXtjajZaNp6eDm3qqs8+9/Kbrtn2ze0tW9SKaKMh691ZfkJNjPuLuuQDvygFII989Bb1qne+ZgWjhD0+GLwiV99NDb/e5RvjkRxeleXh1qr1Hg8t0mK1y0lw5dvqV2WDoh3X+HTDWJ6ursFkpz55roDvbnAIV3WDWvoTdaoseOuFC6TwZBNswNMUNhsTyt09CHveDk3FM88CLXKQ4ybbwwzzf1uOUPPSt8cyNCDrKrLVv5rLaDjQMA4dCNOXQnsKjqRN56cLFVfI8VPza51rDziIPmG5Ip3/jdqMGAB7Q+3Wze+OpEO5M5UDI/Q1wqOeOsAdAo+XzkmkK1DG4gscf7OOra1dlM3KjeuhtD6XNGb3n4G4zwCdp4kBovgBRqAuR7Uhy5LSp/mvvuPRufEMS3eYuZop15+chCZTU3CXoPobQTzDozU7a6a1EcRhroRh8RP7yImu9HPNUuXoyhlCKOvFOdfGpMnSF+1trtDH8MwC4vh8px6S28Y7wQitAf8broCaETwzGEsupoh1we1+4KmHrr5j/osF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAw4TK69u5TzidXNWgUFDJQNNhHpgCUgkKVfMwgHeYdAouquEboFP0/aBJcY?=
 =?us-ascii?Q?8JRhITZWZdKwzSR/yNNkZPUdVH4L6It9I6gBLGcdhUMwxrCEUhChx0CV4emu?=
 =?us-ascii?Q?zXMRYQAsooFKp2Z1FvkRR/6+yfHoFnvpDdEZ4YxkTW0wVU9u7bHzJ5CyUung?=
 =?us-ascii?Q?aBw4PBIjj6tnk5t8dW8kas0Qm1nDesI7AVBPR2Q9wxxzR12/6Gmog5gAzCil?=
 =?us-ascii?Q?ROIEVupEi1Wzt/KBNxC0a9G+qxdcNReU4JeFlmktDDau6lvcMCjFnDe57xCP?=
 =?us-ascii?Q?UUWnEOSRyqt1dcjEYMYmNBgJarPbcZR9yKngVuP6Mjn+vqU8BjYx1w3k3fyf?=
 =?us-ascii?Q?HHEFLg4Q9FBGs21dOsIp0nCcfumuQW91RXZXGcOIoJ5+BCyjT8Uv4elw4CNI?=
 =?us-ascii?Q?iy125/OqYNx3K4bQHJG4eSA8OtRdD5kFqt61LIiaDJ3AzqKfO9I+Fp7oZhSP?=
 =?us-ascii?Q?5zXrGNZZCl6yCFmxAg0WESsiUXLhsYMKANf+8uxOlA8Susc14zzi3dADw3sR?=
 =?us-ascii?Q?85a5EZg3TQ/daFZ3e5CgvMWQ5IROCcrIMkHKPBUQ7m2AErdnlHCx8GzacTn+?=
 =?us-ascii?Q?urLPug4RescLtEMwsYvlaw4fIyh0UACfG6KCOubfIjyfWcI8fv7YiHHDoX72?=
 =?us-ascii?Q?lDBJGQZ4/3CODMySOJN4XO3F3uGzum/w45eIf1nTmnuxc8qUc+3/D+T3qs8P?=
 =?us-ascii?Q?vzkZQtkoR3THVAit2jh1uulpbWwUQD092Es9YZuRDhUxnmLBi8u5wY7ipW4I?=
 =?us-ascii?Q?H7yWybDnG9KFXD3Purtu34b4GG41J7UupgKmq2xcSKtfj57G5ldQJxwSzIOT?=
 =?us-ascii?Q?RIR/2KFfi0EaqQzW5/qGEXGgwIb/AsBzStpoU4nLDTEHAGSjy3bWbFRjLrIZ?=
 =?us-ascii?Q?+kDTJhNtuuyTIEMaSYz4zrum6kGuyGTy/jB7EY0KBbYjkszG91mLTofrquUN?=
 =?us-ascii?Q?nv2wtVQa0VhoFHOec3iNmNZ2xvZUwQ6RAE8ACu9NlWB6WXH7GYuazKQff+pT?=
 =?us-ascii?Q?Ri46u6yS2+ecZU7t7KR0mwUuXJgfy0YWP/KflxDia6e94NeFCjdRXblZsp4U?=
 =?us-ascii?Q?uwS9uvZQSitt8jjII6O1rVYUcuXzX8FQd0vIf1bVqq0CpAgoXMMMzwhoPfSi?=
 =?us-ascii?Q?w4V8fG1GdhnxrdCKtcnVRABlCXj+AGTS/70ddW0M2QD0JSjGHIr9BW5Agp6v?=
 =?us-ascii?Q?cafNH+weySpCt/6EeLBL/YUWNH5bmuXuXDizk5CjOBh1dXaALE1zgv1vfhVa?=
 =?us-ascii?Q?mgy8ELQzCoUlcqqaUMc+ey5xNlnF7eNK5TIMTgnhFlyXJWTW90wJZkvbCetr?=
 =?us-ascii?Q?HZnHXwVxg/TVaITooemPwtT0Qw1B3LMQS1P97XsPyRckH4YxrIjN4ndQw1xS?=
 =?us-ascii?Q?QGji4iwoYJYF65hCPxUVih3bW95TgUzSK+h0bfu+TXIAfT6zcp4vNivRrESe?=
 =?us-ascii?Q?TQcrjGkdodlg68nawXS9f/IMxdRnNuKEMGhIsLNJE0hZquVUsiKA6W111t9c?=
 =?us-ascii?Q?HjDjyHmrKmIVFj+X5QWR9W+1l6Aq4u+KxyRT9WQhWb3dO5EmAFBc7CrA6eFl?=
 =?us-ascii?Q?HDe8NvF9czavn0yYgo+cmf33GLefPtJP1SCnPGk12xKswMRJddEfqRmGF08L?=
 =?us-ascii?Q?m8UrfLIJ/CObEqUOqGilYDo3EuSoRPDaKr3LWcsW4PeL5wMPOomii0V82KXV?=
 =?us-ascii?Q?6z4Rh4/ifm6Wgm++J+XeCxO3tArFM+xAfZmu/Rem3c4HHNt9T6WW1QTQ7v0m?=
 =?us-ascii?Q?34SAXLnCqw=3D=3D?=
X-Exchange-RoutingPolicyChecked: NuL0YIVUaQOQgMHSTUpIYA4E1JRgGzvs3MoJmQY2PkvlmYMI/kJouuozeQCLjX/2riHxLFw9RKAQdqXlFk/y9du1iasis6tgt1cmjrDg/uiXCbsCUVUOLjG0hJtm+DHs8e1p3sZlGTHkMy/OKBa7IspezRNq9fUnOdbhPBPLMciV38AeyxXT6O2MlqOfzPu0aVP/NTrE4kG38pz5eVRjiKt5wchJJ7rPEjwX5Ud62DRqA1IxEe+P5ft6c2hDfzU+wI4xcwD5GhiJILJg0EO51+wRp9fykItqjsUoRDc5p8h2P2Y79Emtq9aCReV/91jTXE+n9/qmrr1fdhn910WbQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 705defc6-61d1-4dd7-f6b1-08deed119444
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:34:50.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bn2cxp/HIZNvFYVrr5Qw0Ji78v/Z06xSS9QInWHAEIGb2jtiluBINuHApW6MYXsLiQsdYVw3PcZCsAsIkRkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD320E2257
X-OriginatorOrg: intel.com

Hi Sean, Jim,

Any thoughts on the approach of reusing hv_timer for APIC timer
virtualization?

On Thu, Jul 16, 2026 at 04:30:57PM +0800, Chao Gao wrote:
>On Thu, Mar 05, 2026 at 09:43:40AM -0800, isaku.yamahata@intel.com wrote:
>>From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>>This patch series is v2 of VMX APIC timer virtualization support.
>
>Hi,
>
>I'm picking up the APIC timer virtualization work that Isaku posted [1].
>While reviewing the series, I noticed that APIC timer virtualization and
>the VMX preemption timer share fundamental properties:
>
>  - Both run only in guest mode, requiring KVM to switch to a software
>    hrtimer when the vCPU blocks.
>  - Both are armed/disarmed by writing a VMCS field (a countdown for the
>    preemption timer, an absolute TSC deadline for APIC timer
>    virtualization).
>
>These are exactly the properties the existing hv_timer infrastructure
>was designed for. This v2 series treats APIC timer virtualization as
>an entirely new mechanism, introducing a separate apic_virt_timer_in_use
>flag with five dedicated hooks and helpers to arm/disarm and manage state
>transitions in the common x86 flows (see [2]). I think we can avoid that.
>
>The idea is to reuse set_hv_timer()/cancel_hv_timer() for APIC timer
>virtualization, with two additions:
>
>First, the pieces specific to APIC timer virtualization:
>
>  - Configure the timer interrupt vector in the VMCS.
>  - Disable MSR interception for TSC_DEADLINE when the guest is in
>    deadline mode (so writes go directly to hardware).
>  - Re-enable interception when the guest leaves deadline mode or masks
>    the timer.
>
>These are naturally scoped to LVTT register writes, so a single
>update_lvtt() vendor hook is sufficient.
>
>Second, tracking the timer state. With the preemption timer, KVM
>intercepts every MSR_IA32_TSC_DEADLINE write and knows precisely when a
>timer is armed. With APIC timer virtualization, the MSR is not
>intercepted and the guest arms and re-arms the timer without KVM's
>knowledge. When the vCPU halts, KVM needs to know whether a timer is
>armed and its deadline to set up the software wakeup timer.
>
>The solution is straightforward: on VM-exit, read back the deadline from
>the VMCS and update KVM's existing tracking (hv_timer_in_use and
>ktimer->tscdeadline). This is one vmcs_read64() per VM-exit, negligible
>compared to the exit cost itself. The existing vcpu_block() path then
>works unchanged.
>
>I prototyped this approach [3] for enabling APIC timer virtualization for
>L1 guests (nested support isn't considered). The result is roughly a third
>of the code (110 LoC vs. 300 LoC), with details of hypervisor timers
>(preemption timer or APIC timer virtualization) fully contained in VMX. The
>only change to common x86 code is a single kvm_x86_call in apic_update_lvtt().
>
>I plan to post a series based on this approach and would appreciate
>feedback on the direction before doing so.
>
>Thanks,
>Chao
>
>[1] https://lore.kernel.org/kvm/cover.1772732517.git.isaku.yamahata@intel.com/
>[2] https://lore.kernel.org/kvm/727502c8f79850fae6a8a476a624e5902861db39.1772732517.git.isaku.yamahata@intel.com/
>[3] https://github.com/gaochaointel/linux-dev/commits/43056263022fe57cc9a10ebf2828f0f29611d6c

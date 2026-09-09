Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16835957
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913359; cv=fail; b=WyWTqZx4vQw4v0ux8+DWEbT2MXhQ6ECBe/ybGhny5A9fmog4aowLQzxoNEeAIfDaR+20y+khZ45qRLRLyYockV7DuuF8zWrcIqi3epla8g+lbvKeJplZO2zTC/p/A1Vt28d1+//qTzuqb7rInDIhcRfvKD8JrGjDQA+l1t2eQhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913359; c=relaxed/simple;
	bh=g0xsiU+lpt6RLzie5Ux6rU4N7nCfDcA/bSr1XaThbyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXBB+tFJp41EJhnFWyI8eS6nD12GTgZfbOpfIZdI+sYjje78nfzApmMrhZBXDrpdr1R5E9PU3yMsRW7Ad6sC6LOYx7eT3ZErB4dXZpYupz9QumRbLxTddco6nNqPp+jYVXtrxyShGqyUWW2pYZn17zidN7r7ex22rNBzboI18D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzGhc69d; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzGhc69d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788913357; x=1820449357;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g0xsiU+lpt6RLzie5Ux6rU4N7nCfDcA/bSr1XaThbyU=;
  b=JzGhc69daS/qi1IooyJiL/ZLhHx0z9q3QgaUpVGA5cJYRRc43Qhkd5nk
   ElCf3fG/rvk4DHoaLwcghmu3Jg/lIbIhFn1utuR7vlGRVggYPrmVyw+rB
   zjCkBmd3ApfHls4QVmu8OLyNdDLR5qmAznhSpai8wC3awUUKsPkLqTBUX
   K5BboLHHwM1GwEDv8/2jrKL82b7hWUJHT7QybX3QR2LuaUwOuk/uSX82O
   Z5D6F9oGNwH96YQlNe4F0v3SHlmNeUFeB/Yqi+RtLWBX3B74vV29f2AvN
   jahoEW7vaoNvrgKNoiFucjd87voBOTacS9PsJ1gWqHwi14S0sZFEJnqSV
   w==;
X-CSE-ConnectionGUID: iRz0iJAlRmejlayCNPhd7A==
X-CSE-MsgGUID: fIJAWUtWS3esPkPwjA/QTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99657773"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="99657773"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:22:37 -0700
X-CSE-ConnectionGUID: f1F/5yOrS2aQa0msgaxn1A==
X-CSE-MsgGUID: j2awrepcSoWOjk3Ht0Y/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="309413282"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:22:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 17:22:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 17:22:36 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 17:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm4NK4REQxXQGaa4q9Qr/IXv5hJ0lwGlj57/GE/nqorYR80184cOv//F7Nxs7dDHIrPpZsftZCO1c8+7QBjD91mbb0p/JOzvHMCia1iUcvfmJErt+l93kcm5cCzVTWR7Mte2PUtvKWaYuO9XwRrczu5i8HyqBHIPVa1Khid6gPq8Ix5j2/XK2J7vpYb5Ks4NpdICdFAFgXq0+xOhNrbjH2JIHNopXP++vdZczLZCgRvmlpnzEhIrj6004imC388xBdfsd2LBOKGjChTCxn5N70v5SACOg526qsgaX/pz+L9U87PAS76U/IhU8LbhSSmOwjfi0T9pHHQ6DKjo0zwRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xTDKnlNQ1qQcfgSE8cuOJ7razdifnWElTyRMAQML8Y=;
 b=EdsmR9Izrk9pMNDAgnEpfk34M3NKBqZl7lGOs58pQR7VHBziyTjjbv/rNloe4Z/v5cGCz6NUq6ypu47DEkSoU8lV+TbnPh96v0jnYAMZP0hR94bsvWew/f5ztFUtH8iRQ3yOF8izGA90KXtv+gVkzScCvWk+AXdMImqycJqMQtIx6Oq/MWjJfTUzs+dXx33I/4c96dUr9Z4xHS5cUdKdNLmRbqgpN60zD3na9gTudVHPv6AYhtEe2B6HzliCQgzzVQQtWqX+mtTEJM53rtkfWWQq5E8vMKFd/P7x4BRpSL0WNbcvVQtoyXfYDQ+0xhDocmJesMQ+rNo/kbXvHvCi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 LV2PR11MB968400.namprd11.prod.outlook.com (2603:10b6:408:423::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 00:22:34 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 00:22:34 +0000
Message-ID: <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
Date: Tue, 8 Sep 2026 17:22:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Artem Bityutskiy
	<dedekind1@gmail.com>
CC: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Peter Xu
	<peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Jon Grimm
	<Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>, "Vishal
 Annapurve" <vannapurve@google.com>, Elena Reshetova
	<elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1> <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <ap-SihGd0fk02QV8@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|LV2PR11MB968400:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a31946-d003-4c9e-1804-08df0e087191
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|56012099006|11063799006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6iTJowc2ZyWAXKkJPbdKLvKFSK24Sjyd7gYGux87kvhHd0nGQenctDKYylqWBrfNwi7g49Zj8PTbJl2/EQl06RYlKuEMQNGkO+OGic8nhfCU0LQ7Vr1w9N5SJGFw00tHqYHJx5wTQS+yN1iirJbxX3yq0CAz++ssTGQazOjS2FT9ONp1dNpKYBlAqE+NhOoa29YL5O7m02nZdNFTYPWk4RDAKAk63nSIZYveGlcfoal6JWVJdIKUC6qThHnxYNC1FFOr8qyAjRt1rRnAx0OiniGQzcGnpJaSbZv6uWzSqLrQFW+lbvFJeOB3LKDW6iqfvcbwfv+P/q/FDI6FoAltdCfxVEOmy/u75n5LFE0rtwCZyDGeSJ+FQf5KV/3EVXdvHosJ2GvyL1KddYpBRsPxfCId7GRF6ovsqfFVrs2oiJ9nn6JZA9I19OEBqwnMGjDXn38oTkM0a5JDcYjZkexGbmdyafJya13pBEjISmtQlEmjdMNvbtD1VLyHlTvqCdvX5eKfx22xhQYU9rhbGKDCcfi8HVCmhgHEWeDCHvWn0t4+tahz8oIkEXMY10NUC7ecdePizHlfXLfRmdnPp6SpSG4r8aii6k8L1XZnNxAALv0qgxmwcb/s3YTnnTeiIMtINd8Zqso427ygZJNktIipGqjFFa6wSUrcBXwl+eBDHUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEV3eE1CSlFtaENTOVdGTkRpcXBNL2pGaXpUVWlWNFVyeCttdDhVYzByLzFh?=
 =?utf-8?B?UW5KbHhoOGxpZUl6bzZxM1Y3V2p1ZWppck9NbE5ERVV3Y2J5blNxeTBNc1lq?=
 =?utf-8?B?TnVWWDZKWnVXMGRzanptZnlaQzBSaS93aTFrU1E5UWZEd2dZZGN2QWdHS0xU?=
 =?utf-8?B?enYxcWdSbFl0TGxUV0pBTnRLcGlJcngxVlM0c0Qremw5aXhqb0J3aTd5dE02?=
 =?utf-8?B?R2Q5NjZhYnVBZG5TQk5RNlEyYyt4UUhYb3hjT3J2aFpiU0crZlQvTThxTkt1?=
 =?utf-8?B?QmF6NmJ2bHNnQ1VzRnNsY1A4ZUlSSU5XdmZORXo4YnFRMzBUVklud1I0bWU1?=
 =?utf-8?B?UytwKzY1ZzJLaS9hVVdFTnU3MXpMdXh2U0NHdkdSRnd2VTc0QnQvUmI5YU9X?=
 =?utf-8?B?ZUR3NU5NTjcwUkZQM1VoRVc1dnY0S21kZC9jWnpWcEN1aHZSdGNxMjFLRTVF?=
 =?utf-8?B?WkVJVVRSUDcwTUMrRFh5dkJFNEJnc1MvQmNXUGpCTkk5ZnlzdDNRRDBZWVNq?=
 =?utf-8?B?dkZyb0s2MmpkTGllL2JCSGd2OTZoQ1JQSVdrRTlWTzMrRjh1WWxaNEpvTmll?=
 =?utf-8?B?VWQ0blVlU3Q0QXEwV2M0bitFeUJtdUZESHpVRVBCTU1pandhNzRxNk8vZDRj?=
 =?utf-8?B?U1NndlQvSWdHbnhyNFBpeEpjd0RSYzEzaTlSQ1VwWG5ZYUVZd2FpbEdqb3dw?=
 =?utf-8?B?YnNQYUVmUDNaTTB5U2NLR2hZSmV4SDBHVkVpd2NkVWl3b2R3Z3l0TmZvcFNv?=
 =?utf-8?B?ejFPNlJSU3ZrSHNpTElJc3pid0F3eHVDVDl0cVJWUFFrekkxbllVNytMdE8x?=
 =?utf-8?B?aUU1QUx1bEVYc29HUGdlV0R1eEpLQmZVQVprQlVpTUV4SzRBMmZxOFNZdzlW?=
 =?utf-8?B?UGg5WWhjUkZpM2s3Z2Z0UHZjb1lTT2syQzlnYW1PN3dtVFdyQUNoUmQrMkMz?=
 =?utf-8?B?UEN6a2xuZFplVWx2TkpwRllQMWI3dDRMOExBZWlvU2VhTEFEdjFkbG5GSmt6?=
 =?utf-8?B?eDVINWE3WUdKVmowbnVSK1ovdUdaa0RqdHByN21yaC9HVmhBU2NITksxYWpr?=
 =?utf-8?B?Wnc1aEVGR3NLbVBtTlRLODQ3MnBndXhYbzNpVEhUVHJUMzJLdHo0U3doUUFk?=
 =?utf-8?B?Z0lFQ3c0S3VyWEdLM25TbW8rdkNKNnpJS2ZGZzArR1pqRHVrN2xtNklGQ3N0?=
 =?utf-8?B?WlZxQ1JjU29vZ2VpaU9JTjIvSlV1V3labnN6YVlaLzZzbTVNL3M5WjVaR2dt?=
 =?utf-8?B?bjVqM1l1N1V5OE1lc3NoMXJEWnVlaFRGTmI2Ukx2ZWZPZHlUcXE3YU43T2FX?=
 =?utf-8?B?R3VXTFpORE9jc3dtcjk2dVBuNnZXQnRzU2pMeTA5RVNoNy9oanVUN014Ui80?=
 =?utf-8?B?RWo1NkFHRTlKcm1NbzU2SjVwakhtcVFZcGh4dmJ0eHdkZ0lsL1ZZRk54YUN3?=
 =?utf-8?B?dElicVFZaVJyZDlYaTg0MytRZ01RSGN5OC94ZmRPWUZnQ092NUNYT1MvYWlx?=
 =?utf-8?B?OGs0b0lRWmhJWjhJcDNSRHVkYjNidnkvdWJBZmxYV3JhTlAxTU5HbnhYTmJh?=
 =?utf-8?B?aFlpVUVSaGZiMnFqT3ZhNXVXNDFhTWJvdkV6THg0WGtod3IreFRTSUcwMFBO?=
 =?utf-8?B?dTdNN1UvVkNyMUppM0hhZ1ErZ1BIcTlBWlNiKytQODhVeHFKUEdNUW5EQ2lz?=
 =?utf-8?B?Wm9iZ2s0SjNSMUVEUTBHcFc1QVFxbmVYbWt5Y3BOTFJoemNUVGJhWmtoZmFo?=
 =?utf-8?B?d1pFMS9sM2o2S2NGcnJXUEF6WElncVFZMytKVHc4WUV3QzFxK0crTjZTRHdw?=
 =?utf-8?B?WTN5ejE0ckNaMisyT0FTTDdMMzhkeWpmT0o3NERtTWhZeFhGNzcvenpWQ0VO?=
 =?utf-8?B?RjBNK2FBY2ZnaTNvVEVib0NBb0xIMFJTZHdzazAwZHJUdDI0OUxjQ2VRNzM5?=
 =?utf-8?B?Wk96dUlXVVFpY2VYNDdUa1ZkZHp2dHhGNWltU25sMnNUN0E1UDhGVHpGNE5i?=
 =?utf-8?B?QUFTSVhna2I0YzVGWmFEYmJNYUpGVWcyVHMwVWY2YjhicUJuYTJuUkJTN1FB?=
 =?utf-8?B?alpZN2VXam12TlpDdVJaamNBSTFEeldtL1ZKbDgwdGVFK1IwU0NxUjhrNFRJ?=
 =?utf-8?B?dXZ0bk9yUDBqMWZFTU5TRE5KQ2dHZG5kYkplSWhFNjk1eE04eHQ0dDN4N053?=
 =?utf-8?B?RTlwWjhUOTUzUnMwQUNsT0pPcmxjVmRhTFUvRWZyYUhCSW9vOEJQK3AzT1lm?=
 =?utf-8?B?ZUZFUGxUZW9JcDRpM0tBMWh5Ti9vRG9vcWJrWGhtOFIwbkNFR1JTZ3FLaG9U?=
 =?utf-8?B?WVJFQWZpWllqQlc5V0VzczJ1emZaSy9HaFY5RSt4SlN2U0N0M0dxUT09?=
X-Exchange-RoutingPolicyChecked: ydjt3AcnA5fBoXrZis+r/mT0y5nPe4879lTds/OFiy7t9vglBMAxsOzuM75pYbTomVycflCM1KoHwT9Re+JmTjd8Uw46BZeoyL0TIdAkmtwGdazFCgtWOU8QMILFfIpzZdfCyCG6Wg1nu0DTKH7hhv4CWSB6j4CGd/IT077cmKnJ3AdbiuFArclN1UpNd3AX9wGww+g4HvtMcqqrVQAOrU+cypAOVVDai5j64B/1/tsjQ+oIo/dzowy6ZFBHWZ7tGIMWxCtpkCiiepB7NqdQHXnL5YByaJ+0mmyd8DljeK0+CPz37nPiZxyfcO7ENzw9qry3tkS5d6dAAJMgswWg5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a31946-d003-4c9e-1804-08df0e087191
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 00:22:33.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kQb+fgFNPXWYsQif9i7hMappgN8x25+MFTJqrVHAERYMco7VDKVUAasqObq0rDj6g+1cCf/y0/Z+NnMuw5GIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB968400
X-OriginatorOrg: intel.com

On 9/7/26 9:43 PM, Tony Lindgren wrote:
> On Mon, Sep 07, 2026 at 04:32:33PM +0300, Artem Bityutskiy wrote:
>> On Mon, 2026-09-07 at 15:15 +0200, Jörg Rödel wrote:
>>> The direction is always the same over a single live migration session, right?
>>> So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
>>> and KVM_IMPORT_CMD seems to be a cleaner ABI.
> 
> OK


Just sharing an alternate point of view:

The roles are fixed over a migration session. A split ABI is certainly more 
self-describing, but it restates that invariant on every call, and therefore 
also permits it to be contradicted -- a failure mode that does not otherwise
exist. With a single KVM_MIGRATE_CMD and a per-session role recorded once (more 
on that below), there is no need for per-call policing: the role could be 
checked once when the session is established.

Along these lines: it raises a question of whether the MEMORY and VCPU
calls should be coalesced as well into KVM_MIGRATE_MEMORY and KVM_MIGRATE_VCPU.
As posted, direction is implicit for KVM_MIGRATE_CMD but encoded in the ioctl
number for those transfers, so collapsing them would at least make the uAPI
consistent about where direction comes from, and free two ioctls.

>  
>> ...
>>
>> For direction specifically, we could pass it to KVM on every call and let
>> KVM stay stateless about it, or KVM could record it once and remember it for
>> the rest of the session.
> 
> Yes the "record and remember" is another option, it could be a sub-command
> something like KVM_MIGRATE_DIRECTION.


Agreed on record-and-remember, with a refinement on scope.

A VM that was migrated in can later be migrated out, so the role is not a
property of the VM -- it has to be recorded per session. SETUP is the call
that starts a migration and runs ahead of all other migration calls, so its
arguments look like the natural place for userspace to state the role; a
separate sub-command would need its own scope rules relative to SETUP.
KVM can then ask the vendor layer whether the requested role is permitted for
this VM -- only it knows the confidential-VM state -- and on success record it
in generic KVM state, where it then selects the export or import callbacks.

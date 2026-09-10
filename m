Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A133F394
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002691; cv=fail; b=Ln7QhSRHhXneK4d/9E96RwYsR4+/zJXRipvlRtiir5i2UZ3MV1qk6E7Nxl7DdcUPgnacOtj3fsnZKGYWtBIVNTfmLT1iDVJU1MbFzMg1FS3dM0GM9BwXRNqSqGeTIBRvNkwYcXgun9mUoKrNtDgYyky/6o6qRLawEiKC2NaoAgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002691; c=relaxed/simple;
	bh=3yUpRgdkA5tBZi2Lu7+fA1f/5knSDwNGs1fE+Qia1SY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHxrGg9LsIqXHK9EGNlxo3kXWxsymdgcKNelvc0HVKNcny43JFQxxk3DGL1pAoYiVD8qHuy1b3wMys799MygtD/0JMItBwyhf09RD76Vo8NBuEy1MaTVL7jtPvQuc49hUHoqqHB0Rgly/Xpq8KCea1tcENZj5pGV8yhBzwO/qs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlSOPiUr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlSOPiUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789002688; x=1820538688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3yUpRgdkA5tBZi2Lu7+fA1f/5knSDwNGs1fE+Qia1SY=;
  b=ZlSOPiUrw7hqV87EFUh7eJ4bl5bM3BgZJpteiREEUNLYwaRkEsSLcoFO
   La6lBu/Dm6hw2dy2ue1EcA740p0gwSAdTr1LxutgL3iylOu0afK18CFEA
   I/zK6KocokzV1RdnTKkIGJScojuMZyqhyiKhwx5yVMT7ta669P3RPiO38
   2l/BjeIZBwHwYs6olnFyc0aAr6I0zMjptvb3yTeseo1tdukeuoo9RDM/W
   2BHhxJ5p076dgRbjE6TZatv9vRXPmXadpvDX9ZwbwLr7fep/TsQjK+I0+
   n/0FElpmoCcDRO1AAvBOps9oCc5a7Rs6m4SSMPhAaPnIwqmUHBWwN/cQ9
   g==;
X-CSE-ConnectionGUID: Ir6wlb56RC+OVY8Iubfdrw==
X-CSE-MsgGUID: 92xT6taHQpCv1kkX/piLzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89570027"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89570027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 18:11:28 -0700
X-CSE-ConnectionGUID: coYXQTbFTK6kPK4KZICeDQ==
X-CSE-MsgGUID: m4+3ayXHRCq++5h/XoCQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="309734203"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 18:11:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 18:11:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 18:11:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 18:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb+hj4xqHKumTAV+KTAH0FcFiWdOGVEvp864I2UQBEW8pevoAfxrUZvDyMfRCAot6AdeHO7Kbe+NpbDK+ZZJQgoiHyUXX7TLq/uS4Y0TfG144p/l15gAYNFKCZaJA7jKKcu21ow1K/jn8paaebQIV8hGDIvkw0JpmMMyrG+ggw474LW9IJlrunbvEaNefbbeQTnIthpJqDROMnQVuW5Qjau32HW74W7XmvhpBTfJoLrbT7UKrr9CvUULkD3UVp/lkprLxsC4FbInEBelDUw3zrrGFfnhBAF5C6X03jiDmwT61zvWjmF08/ubxxM+XgGNdt9Rz2IqfWQ3Eg5ULDF/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+8WAiy/j31fyfnzjAM2w5GrAEbJecc9aXBfRye6jrM=;
 b=FG+/AadW31ROLbiR3bXreEwv/WMEBVIEGtapxvFN6V6HMYDxUwEtBMCydF7JeaQLuAjyVG8TQ/V8YUE4txTYDTouiQyT6pfS+L/O63kNGwCcFj7GrYxZVhYh6elSzUhxwfOdiM6vcfSPgOEdNeboDjBrZ9vGQvITQW/dvz/+1EefeR5j0pSSeWej0SmZeEV24hnrJANInCZsVkgMSEUCLPPFpEzv0Zd0wS1kKXXna4zD9+mWsKsX6sPA6D3w/4s+OsknJGNOCxcwM3w73JiOTV+Z7nACK/RgqtJZ0wakb27P/vz9bf/gRkdbi2vQIUWwZUqMKkLIQBYCHl5e7v9emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM3PPFD2F4A0090.namprd11.prod.outlook.com (2603:10b6:f:fc00::f50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Thu, 10 Sep
 2026 01:11:15 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::3aa3:869a:aaf2:c8dc]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::3aa3:869a:aaf2:c8dc%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 01:11:15 +0000
Message-ID: <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
Date: Wed, 9 Sep 2026 18:11:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1> <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To PH7PR11MB8033.namprd11.prod.outlook.com
 (2603:10b6:510:246::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8033:EE_|DM3PPFD2F4A0090:EE_
X-MS-Office365-Filtering-Correlation-Id: cefe8993-5c31-41e8-ebdb-08df0ed86922
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: wXeWP4tN+1Yg0JYG4chjMFTDnqIC4bQtUGb6InlbpHXl0t8ZXtOlKeICmVeK2Zs6Q/YvCa+f6C1946jc75QZPdVH7bUJJd5ClsYxQNOYADCVIxgOlI/9wiPL73Utc74wLuO7VpIXT3oVTdr7fZObRnvK77GUMoOsgIVvsHWAJ+eQkgXcoVx71N29VJAnZqYQGdy1RZLCCFgW5uogem3H5QTtuFk5Pe26ApJzzGeTKRPpVd2GfF/53QYDLKsNUJd01sN6rIqsI2nwYd8mHz3GOzI++lv7E/DuqevDf7lUQ8x5LaPS1XEVpjaGbm5e2g9HaK0ImKv9Fs8JotN4QJB6Qu1FSSjJwUIY6UofFInc3kd+MrrODX6pSgAT/nFmIXQfgby6kzWHbWK/2ddcNTNQrPsMtW6W6Inne70Ma0/BrbjBg3TPI8KcPrqayJL9jPnHr+HcTBQ0W3i0DMqxKadieEayE8ZLhdX2FFnncdbpFAgdN4pR8jt6tT3B0DWGnXMMF/gTi8TCokUZ0GygK8M5zDfAiNt83R3+2ZUF7oBD4XYo3HJr9B1XRF6n91bU9cIUxvBTzaGb0nsekSgBSdnx1ApeNT3yI2wZ+lBkds17/PUqA4pXF/1zXLW/bhJlkQzdxKsqt2ONsyFTi/GBd5uuKtkdIoNrWZo+EtXmTtRLQss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE9rSzNTYjdjMVdGNklTVmdqc1VRYlo5NXJFc0ljQStpT2I1Vi8zMm9mN0dE?=
 =?utf-8?B?OFl3RFRKYS9qTVNvbjhsUlNhWXRuSkxPOFUzUFM0RGVRc0tCdkc0NVJGUDFJ?=
 =?utf-8?B?MVVMTkp4dlhaRC84ZVF5RXU1SER3L2YzaVVZN3VUdkp2eHozQTR2TWZZY1J3?=
 =?utf-8?B?SldHV0JkZGpPUFNwVjRWUHlDOU1FSytkbVhWeW5GSStMcHRxZ1BodnJLN0dt?=
 =?utf-8?B?a0JSMzBFYUFOL0sya0NYZDN5VlNCYml3c0lOcTcvSUxBc2VuWm1VLzlrRkwx?=
 =?utf-8?B?bHlmUDlESmpXOEx5K0hMUXlrcmhFTWErR3JGRUdET1Y5a3UremU3b2dpemY3?=
 =?utf-8?B?RlVLVkJxVEF2NW1wVVVuQmR1akY3eitkaXlKeXluV0RUQ3lJblBoSmtmZXJL?=
 =?utf-8?B?M3NBZXJjVHFhN2ozQ3oxM1RaTzlKSVhPMnE3ZU5QMlkyU0ZCWmI3Y0g4SThu?=
 =?utf-8?B?eVowbW1nb0prdjRpaEpmTWtwUXpVQlJlaDhqN3AwK2VYSC81M3pwWWZkUFF5?=
 =?utf-8?B?VjRyNlhGUWtvOWt2Q2hyY0FKdE5ubWdFQ2RMREZVdzB3SG5JQ2syLzJFanZE?=
 =?utf-8?B?MFZYekt1Q0V1WlFnMHR6bWwvWm10eVhUZFhtemJxODZXNDdGd3JQKzhtakNY?=
 =?utf-8?B?T2YySHViSXNWc25qQnVOZjFMYW1rT05OQytUdUNlU1FGWjlDNXNDWEc4U1ZL?=
 =?utf-8?B?ZGRYcnhCeExqZmJpU0gxaFZOMXRCZ0dKYVdnaUJ6RFU2TVRiSXRhTm0zR3Bi?=
 =?utf-8?B?dVBCMUwrdHlaRDd4eXZjWjI4ZDAzR2QrZzE0VEoxNUw3bmVUTk01YktsWkdr?=
 =?utf-8?B?TTRIR0pkVEZwRXVmTDRoV2Z2dGlYZEJPa1BzdUt3Wk5yUEtiQjFlbEJuVmtw?=
 =?utf-8?B?Z2ZjYWxweFBNYUk2Ulp2T1dpOElRbktuQWd6RW1Ec2NJa3pWU0ZuQk4yTitX?=
 =?utf-8?B?VzBwckszelZaWnhJVXliUXpvMVVadWhoYnQ0L1VuS01vKzdmOEU1OVpBbldM?=
 =?utf-8?B?bDJXZWpWQ245VFc2U0lJc2ZCSmNpcVBrNjlINjdlYkc0TmFGZTNkZWVqM0Fy?=
 =?utf-8?B?enJBWmpEQ2RpeUZ3QmROb0N5dGM2SDllU2hGa1BwbUVJQmNYbSttOXlFSVJv?=
 =?utf-8?B?emJsNVcyeGZpbDMvQTFNenJvaFczWmFFM1R4OXN0dU9iekhIYmZzVzM1Y2NP?=
 =?utf-8?B?R3d3R2NOL1RmNm9pZjFwd3p5UGU3Q015R1lJY0R4N1hXaENlRlBkWjUxQU5o?=
 =?utf-8?B?Qm92VkpVbGJPaEhjbENDMGFzVmlFMUJreC9Bb1lrWVFQN0JEOGlIc3dmZEFs?=
 =?utf-8?B?a0loM0pzZmhJdnJMY0RaRk5mV0Uva25weFhhOEc1NFkvNnBmV3dJYTN1ZDJQ?=
 =?utf-8?B?a0pMaC91RGZ0NHc0bGh4YVFlN2g5NkluN1dtQTloMlgvUWZnZTFoT2ZIOVdI?=
 =?utf-8?B?MlZrTkt6aGlSL3FhSWVacllKdVo1aXFFUG16OXFwbGphcnBQNjJQRTQ3QnB3?=
 =?utf-8?B?Z2cyWjFaMnpPZ2FGTkJoZC9xWG13cmYxbjUxVW9kbDFWM1lXek53Sk5aK0Ny?=
 =?utf-8?B?dlRCcDFyRmpQM0xUS2REUTlwaVd2aDJBa0tQZEpSNVBMYW85TG5EWEFtTDhZ?=
 =?utf-8?B?WURxVjBJUXRuNHNyeCsyc2ViZ3VCVlgyeUNKZ2FSWFdhTnd6VmhwOFVvYXY0?=
 =?utf-8?B?b3doZnVoVUphMTNKNmVUczUxbXJFZXlSTTdqTkR0eVd4UmlieUV5L2tkOGVK?=
 =?utf-8?B?WlJLR2ZRNm5CRk1UQkViY0h4eHJKKzBVbU9VejdrMmJMVDFwQmNzVU9wekFB?=
 =?utf-8?B?T1lBS2s4TFVxakZkNUluc0Qybk5lU1RJMExSVjZPSVhhMVdzZ0dLTklGSmFI?=
 =?utf-8?B?WllVUTdCNTJYSXNpN0tSblR4aWVVOWc4OVpLdy9rQjU3NGdZUE1WQWpLZjY3?=
 =?utf-8?B?QWRhQU5XZmFleFEyblBoOWVieVZkWEVLSnV3ZStHOVh1VnpCN3Vhc1dYR2FF?=
 =?utf-8?B?NGEwbE5FRVcrK1FQU3crK0NSNE9vYnBXaVdFak45a1ZteHhoN0IwR1BEVVN0?=
 =?utf-8?B?bUgrYnU4OVp3R3ZpNjFxeEdGVUUwTS9YOWVINGtXUlE4eGxQaGhJNDNNN3Z6?=
 =?utf-8?B?VWl0NlpuUnRrRTlGa2sreWI0eDBQaEhpNlNmR0d1dGVobXV6dEVjV29nNnBF?=
 =?utf-8?B?UzRKcmRWWkhiT2F5V3FUVVRmcTRuLzMzVWl0eFJQbEdyeWFkcXkwZzNMNXVV?=
 =?utf-8?B?UkdyY3lKbEltVUpkUUhDYlVSYzFCS2Y5eEo5VlJib1owNEZyOGpJOVNValJl?=
 =?utf-8?B?Tnd5SzdRM1JkdnVRU0xsS2RIbWg2OWc2U3hJb3BESUg5aStGVUhSUT09?=
X-Exchange-RoutingPolicyChecked: Dhshy6xv9tFXIipno81Yc/faay4Cn7jMv83tLnCnOrNuUeX6B0830+1vj4v3b/kdky0E+uaNLy5i7CEqSAY5rz9HHqlfNPqs8yCtdUg8m2js3c5lM6NPcyb3qGecBz+peSSW6h7TsPTIdqziDtDrur/N8i13hfL5hhvPQ8RZOzEaaUI/8Ey4Ni2KGGWVTJJrqbAieDM+LNJno43RWrmDa5U8HcYHat59P26TeCVhV43du1VSLdwQDa2ulSn5WOcpzEFwMQ8uZRkzt5OhHOosI4gMpIURBgBnoug9A6JazYgLqXPjHh+OXNiGKn3oNlT5t6poJ6WQGqBVG4xVdQv5Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cefe8993-5c31-41e8-ebdb-08df0ed86922
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:11:15.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjEwshxxhJXje+pmiI3jlx8VSBuRslNXnHzj3fy1Oeb1tp7msIC8UX9WL4DVXFIoeX+aDI5RO3DZJrbiQQ6H6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD2F4A0090
X-OriginatorOrg: intel.com

On 9/8/26 11:57 PM, Tony Lindgren wrote:
> On Tue, Sep 08, 2026 at 05:22:30PM -0700, Kishen Maloor wrote:
>> On 9/7/26 9:43 PM, Tony Lindgren wrote:
>>> On Mon, Sep 07, 2026 at 04:32:33PM +0300, Artem Bityutskiy wrote:
>>>> On Mon, 2026-09-07 at 15:15 +0200, Jörg Rödel wrote:
>>>>> The direction is always the same over a single live migration session, right?
>>>>> So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
>>>>> and KVM_IMPORT_CMD seems to be a cleaner ABI.
>>>
>>> OK
>>
>>
>> Just sharing an alternate point of view:
>>
>> The roles are fixed over a migration session. A split ABI is certainly more 
>> self-describing, but it restates that invariant on every call, and therefore 
>> also permits it to be contradicted -- a failure mode that does not otherwise
>> exist. With a single KVM_MIGRATE_CMD and a per-session role recorded once (more 
>> on that below), there is no need for per-call policing: the role could be 
>> checked once when the session is established.
> 
> There are two occasions the role is set or changed. On starting the
> destination the incoming role needs to configured at least for TDX.
> And then after the migration, the role changes if re-migrated.

A destination TD needs a directive to not initialize the TD and its vCPUs.
It comes from its launch parameters (e.g. QEMU cmdline) which selects the
delayed_init path. That is a construction directive though, and it applies
only to a destination -- a source needs nothing at init. A session role is
symmetric and is what the transfer calls consume, so I don't think the two
need to be the same thing.

> I don't think there are other cases for role change, maybe cancelled
> migration could require that for some hardware possibly.

Architecturally, per-session scoping of migration roles should be
straightforward with any platform: each side asserts a role at the start of every 
migration session and vendor code will either accept or reject the stated role.

>> Along these lines: it raises a question of whether the MEMORY and VCPU
>> calls should be coalesced as well into KVM_MIGRATE_MEMORY and KVM_MIGRATE_VCPU.
>> As posted, direction is implicit for KVM_MIGRATE_CMD but encoded in the ioctl
>> number for those transfers, so collapsing them would at least make the uAPI
>> consistent about where direction comes from, and free two ioctls.
> 
> Using naming KVM_TRANSFER_MEMORY and KVM_TRANSFER_VCPU might be more
> descriptive?
> 
> Eventually these same commands could be used to save the state to disk
> for power management use.

Sure, and the save-to-disk case is a good argument for a more generic name.

> And going back to the dmaengine like analogy of what is being done..
> 
> The transfer direction flags could be KVM_TRANSFER_FROM_GUEST and
> KVM_TRANSFER_TO_GUEST?

FROM_GUEST/TO_GUEST still encodes direction per call, which is the open
question above. If direction is a per-session property, then KVM_TRANSFER_MEMORY
and KVM_TRANSFER_VCPU are sufficient on their own -- no direction flag, and no
separate export/import ioctls.

And if we settle on a per-session property, then SETUP could conceivably state a
role for a non-migration transfer session as well.

>   
>>>> For direction specifically, we could pass it to KVM on every call and let
>>>> KVM stay stateless about it, or KVM could record it once and remember it for
>>>> the rest of the session.
>>>
>>> Yes the "record and remember" is another option, it could be a sub-command
>>> something like KVM_MIGRATE_DIRECTION.
>>
>>
>> Agreed on record-and-remember, with a refinement on scope.
>>
>> A VM that was migrated in can later be migrated out, so the role is not a
>> property of the VM -- it has to be recorded per session. SETUP is the call
>> that starts a migration and runs ahead of all other migration calls, so its
>> arguments look like the natural place for userspace to state the role; a
>> separate sub-command would need its own scope rules relative to SETUP.
>> KVM can then ask the vendor layer whether the requested role is permitted for
>> this VM -- only it knows the confidential-VM state -- and on success record it
>> in generic KVM state, where it then selects the export or import callbacks.
> 
> The role can change, but it can be VM specific for starting the migration
> destination even before migration is started.
> 
> At least for TDX we need to specify direction for migration destination on
> init to prevent fully initializing the TD and vCPUs.

As mentioned above, that is a destination launch time directive that we needn't
conflate with a migration/transfer session role.


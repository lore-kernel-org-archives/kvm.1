Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618A23BD03
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123868; cv=fail; b=oCt0xzc/6Phc26Lq6bvtlojZS+tsCBnlqbZS68tOH7OGJrevW8h9fxmrBCuWV3ghukL8eueNmeas2RkPXfxpt7rkuB5V3UvHJ4bm8CqMQ9Pph6ZKGkGEs1e9mBfB+6e0oPSRd/EsoybUyhBs1s+YNZo++OfCvqJqONQ0JAH/208=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123868; c=relaxed/simple;
	bh=B/DWRfje8WIOge56tmxbAbtJbk1ggv5FFmlGw4p7E8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSViTbPPVWVhI1kHcDZaS1NPC1z0jnIP/p4dK4iB4SkDqAeQmozx4T34X6hZ6pjkqptanNUaSuip5ajpb79yv6ebf4m1d51350wcJpHLWkx4lSrIf0pwYFxh3VKVEFBTmmvUmhmdjULVXdZKMsFPQas2IQ0W6y2NR8gbvnWGiqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJRQ2OBv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJRQ2OBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790123867; x=1821659867;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B/DWRfje8WIOge56tmxbAbtJbk1ggv5FFmlGw4p7E8s=;
  b=iJRQ2OBvoPpw+i+56c4RiwTu7QYMv6Un25AHoy3I59J6/BVWXurOlfyc
   KjrHa+fSeACOgDU9cyi8FAGgVbQqy/HDl/7wcAPkn3ZnvdWMqdCuDKPlw
   u2z3C5/+LMxFILDQqx6FrQ8PLYx/7bV6TmIXWajgBS+0+miAvGOh/i1/B
   x7goYvTC0NoUIcVm+k6RIP5dJvEAd6dRgbIq8an+ANuJPGnP9DQh4cW9N
   GwK6GY33Gp+dtqr5lz6x5KjnZ50V9M0itLE+kTS1vezwYTY3lOjbvfN63
   m/ywhlGdQ3YaM/fPyiZdOZeUIT3hSRUFPsw+gk0zrJjZTk5YrGTitGv/p
   A==;
X-CSE-ConnectionGUID: y4jOI7uGSYCwe7X2z4TjLg==
X-CSE-MsgGUID: +/cQ+Wt8TqKbbv1LNnnegQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90646646"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90646646"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:37:46 -0700
X-CSE-ConnectionGUID: y8CL5D9GQGCrW6WeJrTt0w==
X-CSE-MsgGUID: n2v52wzzQ5ikwYISoOld5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="278122852"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:37:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:37:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:37:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoFRSphWvqcR417mOlNtXXPUL+zOPTTX3Ftqmj/J8Kbwbts8lhmSJruw05FOdPbx62TqQ9egCmc9QzE1/3G6qxKfhlJTjciteFz+TGKkbEiq6t+zpOlMOmRqucXpNJ6h+ilBRlAHCoAICEr8ZhOIUshNY4Ptj4IRak6CUlvhRasviMb57RPj/4CD+aqprjg9hoi514zzs48tkW2oNp2X17rImBo48zsEQA5yPF3usnH2XoLMhiX24nG5cP7OCM6NXKilQc3Y1IDKyXf19uhsySgk78ir+2HGSfxRm8MrXQFxujsQ5pB993f15P4ZBKX/XmCiq08ZVmEs00yUQzlSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b22mFEFuElWzrRObXa9ZTkshdNkE9Cwq67VmoyOctLc=;
 b=oMah719oRIrlhxMiRXcps2nNiDBHYqJ6L374QFyhomY5JRpIc6oy97A/MN+5ob8VVWb973IGMXz3zB7eIfBJRL6KNhIO+WVeAcv8/mShMRo4hzRGXfb3lS2bw5yXGH+ShD3fQa8GQ/JwN553NN8dPrFCeXkvabJTh6dKCsGATDGw3u0QRRH/UWdsTOJSSQaPKuoz71ivDtw02rdNMj2lyRa77bWtwht44FBHSYPavNRqMFQzI39P8zAf8Z9xb4rt2f6B3GP7zC7FMHnMAoxZV2JCRGmYDNzVC0W8uROMGiQMuiNZf6X5MCYEAP0tiJYy58/ahUBHtqmry67JvjMX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 00:37:37 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:37:36 +0000
Message-ID: <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
Date: Tue, 22 Sep 2026 17:37:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1> <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arIfu_A1e6KEokWI@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SJ0PR11MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: a41a4219-383c-4ea4-8c60-08df190add8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 9TUauF1Vi+9Y/4lLqRoICGt9O48FUGw1At+MOTMIgy5vFWSk0eISlq1m3zAP1jT4Aor1X1oY9maYLHmDwm0KUt8NPQd5ApTwIgnhc7Njlzmjh6oYSsaRjgC+yA9NAr5BPuQ/URXZWbzj7IBey4MEeUgEtUgOfL/I56xgiEI7g7CLkT9hfhOlq20l7DaVky7JHtxDqGKUtvBAgGrleYL5wG6vksOUqm1JM//21UG98IrFWDadhLAUd1el7UC+jO1lH6aa3KTp0AjklY2ocdx/Tqosj6IrWPV6lxtQcFl7Nd4xAbA0018y4ZDMqR2xLE8x3+eY3asetF3JyPCfUefWHrL13+MKwPo947i9KnVIbN00JQrHGt4jVM29anYbzjynozVm1LT8FJklFI7tTFv7VrPcek+4nIF5/h6FSlxXIDsWcTs9aJoNU+iaStKpL4p+wnfc9Zj5m23LwdLxn2/cX6jR+LZx1YYpXa9U07oKEnFw1AMCY7c6dqaGA3szPvLgWT3alGRS+vuuastNocCtYgAhYxnfBmqpa3p3rl4EqkAKIxGG7XIJiJJhJXjCvnZRCsS1MYWKOOVFAMZXPuVRZhHULwD6e1m8HkR50vEFEngFQWHeBq2TrhNBnsWuvGMCCT5BdlJppV7rglIJnMxrMsP0t4RK+kx8MpQx8Xf9K4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpocWtFVnJWVGJvWHFkS242WWNaMUpNY3dEcEpybC8xbXIxSFJpQmdKWElh?=
 =?utf-8?B?N0xHcExDSmtsMTUyQWgzZHhRRFNsUE4zRmtMUVZaRmRVenM4akFJOWlOTzdE?=
 =?utf-8?B?M1hiNzJ0RHB1NDhSWU9uaXNkVm1zenlxTkdiNUVaOE9PM2tEcjZuNlFSZEhC?=
 =?utf-8?B?aFhlb21pS0Nua2M1aGhOQkR6THRjWXNGbFk0ZGtLWk1wSDBpN3EwRWxyeFJ5?=
 =?utf-8?B?clh3NDlMQmdDL2p3MWRyLzIyZDlkekdWUlc1Q3FncTQrVXB0OVZrdDlwemNa?=
 =?utf-8?B?UTdnaDV1aXdGN1pRQ2JHeHFBK05YcENIQkxtQzNJeEpyWU5nV2Njd1V5Z204?=
 =?utf-8?B?RTR6ellGZ0lUSFdpa213RnFNa00zUmsyV045cnNQR2NVVFFkQnM5SnNFZlVw?=
 =?utf-8?B?ZWVBdUdsNEV0cW5yOGp6U3M2QmVxZFdibUtidTdIZmJ4SGxnK0l4NmhuTENv?=
 =?utf-8?B?cHo2aGxhOTJ1cm5hUVVjdzdSMkNVc0FUUER0K0tWRVVZalhhWk9tVXUwT09X?=
 =?utf-8?B?TFdMMTFaZ0lnN2VPVVpmM05rK3dEOHBNNWVERHZXckN6YndSZ3BDZW5LU09B?=
 =?utf-8?B?ZDJMRXhMR1hJcW9DNUhjTGFlaW1uYW91R0JzeXdyVGhGUVVSVW44TlF4NXRV?=
 =?utf-8?B?UWF5QlpLQW9VWnJ6T2dhSkMzYTVMS3h1d1JiZkZGdk5RMHNCd0RoRjNNQjYr?=
 =?utf-8?B?RnF1S0VEdVdITkEwQVNDWS9nSFR4bkpIMVFza1JvZnFqQUs1ZnhMaGozSnh5?=
 =?utf-8?B?REw3bWVOWEdYK01xZVpYZmdZdzZlRkJ2L2lPQVNFVWE5eHVubkJIMzdkWTZ5?=
 =?utf-8?B?QVpZYUpJYitrNWFWc1A3MDExdHdzSUhyaXpVeDV0MEZKaGRHWFNZa3p5bWJV?=
 =?utf-8?B?WG8wQitnOHFJV0dxVWg3bXFKQkZERFF6NFVScEhsWEsyZlEwTVFYYVl6RVdO?=
 =?utf-8?B?L09QQy9CTk9nVU9UeENFL1VZMkxaWkM2VTBNdHZIK0gwRXRRZ2ljaFJiT1ZU?=
 =?utf-8?B?SkJuMDBiWk84K0ZTciswNWNkbW5ySjJSbExmRkpBT05Pa0hlUkJlV2dibUgz?=
 =?utf-8?B?TWlqNm1jWDhhQ1IzcndRUThCK1RUU2hVa2tDUEh4bXVBZlNRWk4ybm1jRTRl?=
 =?utf-8?B?ay95YklzSkFXRUNUU0FEbXUxTm8vZmJtaktnQmUvblRhUVdOeU1IbGpQcy9V?=
 =?utf-8?B?Vmd0Z0hUZ2VycHJwb3hYNXdIbU9tWnlDVzV4TStkSGxWQ0cxYXUwZnlhOHlO?=
 =?utf-8?B?bkZVTEZtTmF1MEgvY0tHd1NMa2xxb0F0RDBic1lwYjlLa1d6TWFBOWtqejli?=
 =?utf-8?B?SzBkU1pta1RUK0NaVGVyc2N1ekFsMUt1M3pEYkMzYXNLWjE2SzFpby9vY0I3?=
 =?utf-8?B?WjNRNUhmWnVXWU1vQjBkQXNRSlEwZ1hqYk9WRlhqTUFXUHhFZFQvZkZ1OHU4?=
 =?utf-8?B?aEExRzROTHV4L3ZMKy9YTVcvZGhLQzRGS2JRUUtGM2FBZU1YT2o0OW5ycHE5?=
 =?utf-8?B?aFpSclZ1V3RndEYvdEVlV3VuR2R4K3lKckxXN256enZGNXJCUWFMc0V3ZzNt?=
 =?utf-8?B?TnZpRVRGOUVpTkdmVmJHNW1TTGg0QzVZeEZLL3RRNUE1YmJmTEQyOWhuM3pP?=
 =?utf-8?B?bUdQM2haSmR4b3JMRkFJd2VBVklNb2g3Zm50V0tWTGV5Z1l5OXN5N3lqYkdn?=
 =?utf-8?B?S2h6Q3g0LzR2aUhadTR4MXJGRnFrR0duakRlcGtxbzJVQXZNRGxsYllJNEZE?=
 =?utf-8?B?bGtVTVpuY08ra0dYV1NFL0REMklHL1htVEdTbytvdzlubER5R3VhL1pmY1lK?=
 =?utf-8?B?VnJQQ1VvbmhBNkZHUzVDRU1RdnBuNmNoQXZEZHpIS2Q0bWRjNjJKSEE1QnVW?=
 =?utf-8?B?S3dSdjdzWVN4NEM3L2JIZjRoM1dpazJ3a3lvbFhwbXFZbkE0bXhBWE1SemNv?=
 =?utf-8?B?MlY1UG5nRDhkQXdhRHhvWUdFQkVWYWpqdDdpRUIySGdJcTFVN3plMWZ3QUp6?=
 =?utf-8?B?TjE2c1ZobFN4bDFWMjYvWC9WdUJ5T01KOC9PSWVNTFBrdkxtdkNVV3NVdEw5?=
 =?utf-8?B?V0phQjVZRnJobWxwQzNPbDcxc2VhTGViZ2d3SnJwcEQ2eUJ0T0NCSnp0eWho?=
 =?utf-8?B?VnowcUovNjVmQkRWek1NQkZkcmZsZGJQOGN3L1dFTEtPWTFvQUR4Vlk0b3hR?=
 =?utf-8?B?MXNjbytRei9iKzhrUUJDa016K1llQTRjdWUvT0lCdFRRVXN6NmpNejZaKzc1?=
 =?utf-8?B?eU03aGh3S1B0akFjdENqZ0ZRWnlSZ2hHWjdVa2N2VzN2ckJLTjhpUEEwNjRX?=
 =?utf-8?B?ZHJrOU4wQjI5ZFI1c21USHBJY04ydVhsVHFOTXJ6b3kvRW0rNkhvdz09?=
X-Exchange-RoutingPolicyChecked: Uu3nspJgS309Zhu2BxU59fEOGRdezGV7Iw8mKhCQ2wWBZ2EnIQPxBoY5kXug8fww59lWdPV26POc43Uxzc7/sWtlfPixRNcv9JU3S45M7JyaOK/LgNbX7AVfnJPs5pfqJk/syJQJiXIT6RsoyORI5UrOdSU5AFq1+8fz0grfZAKmMY/w97psaFOCRFXoY41NTAuXX30IlpEEKCf/9EPjX2PuENdxKlYc+FZhZpnYU8paR32iCn+S9dvaKWCmKkaTh38HvywOxxrgBXRn6PDSnl05pBlg/UrC2lrmE//qbZv8MHDkeedvq8Re+6niNusjyVvC9I4pKjI8QhtPOVhPhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a41a4219-383c-4ea4-8c60-08df190add8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:37:36.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8J4ZqTgrw21MuyEZubrjntj7WgOjUKijzl7atZKyV/FEuvohlrIHI/AXTOZXKs+aGHmvQ9JmeRH4z+8ujA3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
X-OriginatorOrg: intel.com

On 9/21/26 11:27 PM, Tony Lindgren wrote:
> On Mon, Sep 21, 2026 at 08:56:48PM -0700, Kishen Maloor wrote:
>> On 9/20/26 11:56 PM, Tony Lindgren wrote:
>>> On Mon, Sep 21, 2026 at 08:58:17AM +0300, Tony Lindgren wrote:
>>>> On Thu, Sep 17, 2026 at 09:33:18PM -0700, Kishen Maloor wrote:
>>>>> On 8/31/26 12:13 AM, Tony Lindgren wrote:
>>>>>
>>>>> I was wondering how a vendor would use kvm_transfer_buffer for a command that
>>>>> passes an input and also returns an output. size can describe the input
>>>>> length or the space available for output, not both, so the kernel has no way to
>>>>> know how much it may write.
>>>>>
>>>>> Two suggestions below. They're orthogonal.
>>>>>
>>>>>> ...
>>>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>>>> index 5f6c1ce9673b7..d9291a8a97bb1 100644
>>>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>>>> @@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
>>>>>>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>>>>>>  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>>>>>>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>>>>>> +	bool (*cap_live_migration)(struct kvm *kvm);
>>>>>
>>>>> Should this return an 'int' specifying the maximum buffer size that the vendor impl
>>>>> requires/uses? Userspace can then learn this once.
>>>>
>>>> OK that sounds good to me. I assume you are thinking the maximum hardware
>>>> specific buffer size per thread? As in 512 * 4096 bytes for the TDX case?
>>
>> Yeah, an upper bound on the buffer size, so 516 * 4096 (4 for the GPA+MAC lists 
>> and MBMD) in TDX. It could be a hint to userspace to size its buffers at the 
>> start. Though it would be up to userspace to decide how to use that information.
> 
> Oh right thanks. I think this is really the maximum transfer buffer size
> Peter asked, not just a hint to userspace :)

It is a strict upper bound. Maybe it's semantics, but I called 
it a "hint" because allocating for that entire size could be optional.
If a userspace driver for say TDX wants to send smaller batches (say 128) then 
it can refer to the spec, do the math, and allocate 131 pages and the kernel 
should permit that; it's not wrong. If userspace ever allocates less room than 
a call requires, it would fail. A different userspace driver could simply 
allocate that max size and be done; no need to refer to the spec or do the math. 
It is for this second case where I thought returning the upper bound would be 
useful. Hence the earlier suggestion.

> 
>>>>>> +struct kvm_transfer_buffer {
>>>>>> +	__u64 address;
>>>>>> +	__u32 size;
>>>>>> +	__u32 reserved;
>>>>>> +};
>>>>>
>>>>> Should this struct include a 'capacity' field (u32) that is set on each command?
>>>>> It would be the number of bytes writable at address.
>>>>> size would be the input length on entry (0 if the command passes none), and the
>>>>> number of bytes produced on return (0 if none).
>>>>
>>>> Hmm so the transfer command return value can return how many bytes were
>>>> written of the input. But yeah we don't know how many bytes were written
>>>> back to the transfer buffer as result of the transfer command.
>>
>> The transfer command return value could return how many bytes were written into the buffer.
>> But in an input-output call, the kernel handler wouldn't know how many bytes it could write,
>> or for that matter even how many pages to pin up front in case it needs to return an output
>> because 'size' couldn't simultaneously convey the input length and buffer capacity. That was
>> the gap that I thought a read-only 'capacity' field could bridge. Of course, this
>> assumes that the output is written in-place.
> 
> Hmm yeah this inplace capacity vs transferred issue remains still. So I
> agree we need to specify the capacity in struct kvm_transfer_buffer like
> you suggested.

To be clear, I think the in/out split for the buffers along with the convention 
I laid out closes that gap I saw without needing a 'capacity' field.
Because out/size could now unambiguously convey capacity on entry and output
length on return.

> 
> To me size is already the size of the buffer though. So instead of changing
> size to capacity, how about something like datasize or len for the input
> and output transfer length?

But I understand that (and please correct me if I'm wrong):
a) You'd still prefer to not have 'size' serve that double duty.
b) 'size' in your mental model already means buffer capacity.

In that case, we could add a 'datasize' field to convey the length
of valid data in the buffer, like this:

struct kvm_transfer_buffer {
    __u64 address;
    __u32 size;
    __u32 datasize;
    __u64 reserved;
};

The convention then becomes:
- A non-zero 'datasize' on 'in' at call entry conveys that there is input.
- A non-zero 'datasize' on 'out' at call exit conveys that there is output.
- out/datasize on call entry is ignored.
- in/size and out/size are seeded with the buffer capacity.

> 
>>>> How about if we add the bytes returned to the transfer struct? Then the
>>>> kvm_transfer_buffer can stay as just a buffer. 
>>>
>>> Actually, for the possible cases with input+output, we could reserve space
>>> in the transfer struct for another struct kvm_transfer_buffer for the
>>> results?
>>
>> Yes, say an 'in' and 'out' kvm_transfer_buffer inside struct kvm_migrate_cmd should
>> close this out and shouldn't require a 'capacity' field. Maybe we then establish this
>> convention:
>> - A non-zero 'size' on 'in' at call entry would signal that there is input.
>> - A non-zero 'size' on 'out' at call entry would convey the buffer capacity.
>> - A non-zero 'size' on 'out' at call exit would convey that there is output.
>> - A zeroed 'size' on 'out' at call exit would convey that there is no output.
> 
> Looks doable to me but with the inplace issue as above.. Sounds like we just
> need to reserve space for a case with a separate output buffer though.

To be clear, this is what I thought we were talking about :)
To add a 2nd kvm_transfer_buffer to kvm_migrate_cmd, like this:

struct kvm_migrate_cmd {
     __u16 command;
     __u16 flags;
     __u32 reserved;
     struct kvm_transfer_buffer in;
     struct kvm_transfer_buffer out;
};

If there is agreement on this model, then yeah, we'd want to define
these fields now, since the struct can't grow later without a new ioctl
number.

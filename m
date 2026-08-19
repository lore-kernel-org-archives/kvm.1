Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55163440620;
	Wed, 19 Aug 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165807; cv=fail; b=tKTNN6w8XhDoJOz88+jF2qFLxJcZcJAaz7Z2VAOxfiFoLYQkZDxS3rV/pnB5A5vvgQvvb9oqgWFJr1ipD9+EyYMcXjegIx2Eq+i/22U6GTnf4on2Mv/0UwnBBMsqb1cEWWjHZFGX1I73quaMbe9ws4u0ISh6fgfo0MsYkF+btQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165807; c=relaxed/simple;
	bh=pifvD9pSvwOMDNZEGAoZTKHcCJZlEkBm6vVYdcUYpwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2wRoQ2v6yzs04Fg9RqOONJUur/NgwTh7GHVHPb8ysON1qswkR6IlWSPqg+xgCsfbEzfB1r0GQTsPQU4j+3TQkYmLMiQd4WIaNf2Yb8JnRP7h8d7aQb5gxm7i1sUUnTZPzSVmSL5DRagHw7Z1C+QCcCTsOl1YSVKMefo2puP+sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXiITdLD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXiITdLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787165807; x=1818701807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pifvD9pSvwOMDNZEGAoZTKHcCJZlEkBm6vVYdcUYpwI=;
  b=MXiITdLDlZdnpp0OEYABAMjwx9QUE1KYvsyf0740Hg1synZDg7VVxRAi
   wywV1XiP7K+hv3HQm2NbAVgOrBHvEiVKFVzJ36r/kaY5eg+hUbqJIYeUq
   itS5CZptXlMBiW1tfrdGdgcp0DdnLSXg7CJE5lj3i75qb2+JUqyrw8GSn
   QMEpU2BLan2KsZLpPdZzsX2r925gi6U2jYCxyONHYgFL++P9evvZkkz+K
   2ZPpZs+fh26/lLEX4ymaCum/TEAiaTnqzvlqR1bsz0t3uL7pKLi8ZR/P8
   uKXUxMwYVKUPeGUdXsCq5rsNiE2gYYakL3nHXjiPRzdX5IpM0BKKGpFSd
   A==;
X-CSE-ConnectionGUID: Crm5sxRZQNys1+928vY8Ig==
X-CSE-MsgGUID: kRxNFeprRnqpDzXwpsxyPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91373949"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="91373949"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:56:46 -0700
X-CSE-ConnectionGUID: lUSy2MusRRCV6VRfR0N9MA==
X-CSE-MsgGUID: UpEUu39dSv6AVYUwS4zvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262995002"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:56:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 11:56:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 11:56:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 11:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw0S/VIKiMqbDrehzv1ttr5h0qAjbJuD/SFG1hb6A9/zT7s89Ms7Fjei+k30B10Xig8pErZe8fVSQfRsPB/3JtqWa/RWmahVx7ewoHVrX3DpH3Ti7ZyBnMe5kCNnS+QnO6zaXqYgg3Tsv/Elfkaq2ynRxgAGzDFTCO2Us/j+GCcjIFpquOHioygxSGD6d7gUeSahSRff49qw6qjfi95lwvr+sKzBixyvyNUCh1RQir6c6aj51EVWEZZhX3mUGASvX0p8DTI64CV8twKeV/mxIQ62jdb/WoffxLMY/h8+Y+/0hke3fjxIbizjBI02Z6GuaON4/iNEXy/8A3bip/nMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pifvD9pSvwOMDNZEGAoZTKHcCJZlEkBm6vVYdcUYpwI=;
 b=TwWHya2lihxrp51BW/Xi59KRr3XmuHyQW16oZEXVNFqWR9HH8SqJnbnSzQbdhXWfz/nADa7PRXtV+6D+jx8lcnUciE2qFYqnUj875omYaGy6hq5A/e8Ki/WwO0DZU8dj/UGtExbOEO117pkyLkOBc4UH/L0enYGkJ7cXI733GZOMcmowZ7FMWKToNgjy3Da1GSVYeQKZDSIZIIeoQueESuxDdHRYD5yu09dqYJxz/BMRmje+kEMLmi9rWSRUakSklfjEfKreNW2vVQd0n/+pl6fQo+3vbZ6ZWZO266dZ+o+I8hHh9ah9rBH5e09I9J2SrZyVY0w00ugjA9fMyNB2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:56:39 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 18:56:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
Thread-Topic: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
Thread-Index: AQHdLD6aIiIDquy/9EahH8lhDbokubakkrIAgAAAwICAAOUSgIAAFZAAgAAcmYCAABKJgIAABDQA
Date: Wed, 19 Aug 2026 18:56:39 +0000
Message-ID: <e5979a0a4d7c24d88f57981aba0fda6d8a5e2f29.camel@intel.com>
References: <20260814224509.2342760-1-seanjc@google.com>
	 <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
	 <aoT_6cnARCAYTrYG@google.com>
	 <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
	 <aoXSKH4QLTA5DTXe@google.com>
	 <4f8428e0784224c55a2026eb32d046a2051193ea.camel@intel.com>
	 <aoX5sbITQYeB7USY@google.com>
In-Reply-To: <aoX5sbITQYeB7USY@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB5801:EE_
x-ms-office365-filtering-correlation-id: 7fec82d6-b897-48b2-ec19-08defe239a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|38070700021|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: AFVj7IDsCpnGRhUWARS6tkyAO27/3IxwUMAaTGSzhCIHM9M0dWegdAJcr6YMRbHiyC8koZhsnxvOMlqO/2CwMJy25/YtERc0JOUjEiCVRlt4EY7w2h1JXq70EsEJ6lz29DMXbOGbOs55vgTyg9BzzG/f2i0Ars8XtvvIuuBRCyQMGT4vwI62q9jCQOFxcrEqiPPH2KZtmdb/Q9isLH29R9d+4nWYKCKnfs0uOFJObaKUiVyrt3Vdrf3ePcQrHjlWGmXbIIBj7yv9VW5Ua0Md6r4vsfvhP8u/tcQNLduqT2UdB64ScO1xpUCo7/1CXe4OeJXfCT7UCZWuT9EySsNvzF85sMKrAW6jGlI0NkloqlbbJqGIXdYuHp9+q27l+lRadVAvmDM+j1c0aDE5d9x8hHuP5rPcYw+Lzmp46ecSoq6beCJECT9eL9jdKGoxAd5T3bDXlx4CQtSFQ/Nq2ipAre07CU31nXVQQkmYO/stsFHJOd7P9AG7Nginawjx6iKxENBtT9Y6mW9sFGo3+N/TPbhRv0Y2IA7dLI95H8te3EQhi+ngQGLT9A3T4k114EgOYtPux5UuPCTDSMRLHj/xzIynopIcF6HajC41PiGOj83cSHGuU099pFra9Wge5bsMliS5G5Ak/YZjpFfpGUwCvKIoXKJN1GaDHsYDExcCXDbPhWGLrmp8AqNOi5dKDP6uloyD3WmQD7arXrJfAUDiQrkr4VVu6tDfAuxs/ZYIYug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M21wdlk5RVRUL2JlV2kxNWc1NElaSms2ZWpCZ3R3R3BBVGZTZTVkZy9HTkFT?=
 =?utf-8?B?czhKS0pNeWlhWHl3YUZZMkFvQk5ONkU4ZlFPa3I4UXc4SkZlVm1sNUQvNlRH?=
 =?utf-8?B?M3ZSSmtIS3FpOCtuVm1xTzdYTUdLNTZaWExOeWx6K04yVDJHUFRYaVNiREpz?=
 =?utf-8?B?M0RlNy9JMXZ2aHZoWDBqU0ZJbEdGVW5jSk4zZDNPTGxDU3owbGxzNUZhRElZ?=
 =?utf-8?B?Qk01ekdNM0Q3REVOclJ1ejBSUlV3T1NjdjJucG1iMDVHTTZGMEpEYXBhSXFX?=
 =?utf-8?B?ME9ONWZsTjZjMjBCT3lQUDJFckxnNGcxYS8wN1hUQ3UwNFZVbkozSXpKdlc3?=
 =?utf-8?B?NkxWRytSNU02eHdHeHFSYjY1eU4ranVwbVYxR1J2M0c3R0dSQnhseTZycS8y?=
 =?utf-8?B?K2dZbW5WY1Z2OTc4SG5sbVQ0a1Rkck13UFRLelZNdG16OExhTmo2bW81OFFF?=
 =?utf-8?B?M3VPdkZCeWdDM3psenMvaTVLeDI3UWd1Yk8wa2sxZXAwb1d1dmlPV0MralFZ?=
 =?utf-8?B?emlMWXBXQ2NoRWlxNHZ1OWw0WnZJT2xDZHJnd2ZlS2NxMVoxcGVpYVNEOUZQ?=
 =?utf-8?B?T2g4d20wa0NuUnFZS1lEY3ZrNFdLUjB6djRBeElMb3oyOUNyUzQ1Z0JCeGg1?=
 =?utf-8?B?Yk5sOElITjBLeHByWTVNeGdDaGFoeGJPSy90ZEpjcGlDNWR0YmQ0RnkrcnlD?=
 =?utf-8?B?VHNRMlhTZGdJaTgzL0VnZEtnWVo4TjJ4eXFNaW44WEpkM3I4QlJWcmpEM3RR?=
 =?utf-8?B?NmRFTHIvV0RkbHJnYkdTZlBrcDNDUnFoeXYwVEVGMmFna3VXMkNuZlE3U2FV?=
 =?utf-8?B?aTI3MjBPNjcvd2s2Zyt1dU9QZWlVVllWN2VXaS9KKzZuemxrNmdjNGdHREZj?=
 =?utf-8?B?aFBEaEtIdUVlclVGbXRuVUFOdFA1NGZ3NFhTbnNRK3ltMVhaa0lHUnZiQURE?=
 =?utf-8?B?UnVnbzZIVnBRRGxVL2tRWWo2M0Uvdm5TTmRXZDB5T0RCSTVpZmx6ZUNhSkd2?=
 =?utf-8?B?N3lwZ05POExiTkRrTzBGSS9jaEZ5K1hEZUFvTkNrYkZtVkdXem9EdE16QkxU?=
 =?utf-8?B?OTZ6Ri9leCswbm8yNVhEbm5yOHpRQjZXZEpVRjRCaGd5NnBkeWQySHVCc25q?=
 =?utf-8?B?cEMwZUZkblQwaTM0YnFJdGl6QmNnZVh0VTZYQnZkVHk3Q1lYRXM1REt4TmU5?=
 =?utf-8?B?TzJXR1RuZ0xRaTdwbncrK3dLLzhpekRMU0x3ci9jNDEyUTdiQ3J4UHZJUDZ2?=
 =?utf-8?B?c2J3QWZUNEw5Zzc2SmFlNTVXUXc4cmdYRXgzdEtIQytkM214eWtxcklGZUty?=
 =?utf-8?B?YkMybE1yS3J6WGtSdmFBaFNqVjQ2NjJFY1lIZ3h3VXNEV3YyQXZ5OG9OUDRv?=
 =?utf-8?B?L2lOb2pOa1RTUUFYQmNjdE44bWF5T1dhS3NSQkY0aDlBTEhnK29UT3UyRnVM?=
 =?utf-8?B?YW5vZXdhRndFSytEVUErakVTQ1JvOUhmeXp3UGpiVTQ5NnN2RWlPZldDdzd0?=
 =?utf-8?B?VXZWb05uREpWL2pwRDdYaHpMNnA4c1M0VFRNNWtNOHhZVG9ucjJzM3B6SzN2?=
 =?utf-8?B?dDF3cy9jWFdDcVhVemF6aGR4bkY5SGJjVWJYTkJOeDd3QnZVdjdjVWdKVzJh?=
 =?utf-8?B?dk9id3Nwc291dzJ5MHphZmNxdlM4eTMvakpOeXNaa0Q2REVuL2lhQTdTTFBB?=
 =?utf-8?B?R2lPcmV2aXFXdjJ5Qy9SYnNOZm9UZ3UwREZmd2dCS29nSjV0a0JJUll0YXJ4?=
 =?utf-8?B?bkVPS0RDbDhwaFVSazRpbE5aRmtqOExWZWI4TWZGWXhpREFTbDJVOUVmNkg2?=
 =?utf-8?B?NktKc2gvYTJmMnpXZU1OQnNkOHpobkF1bzdRdDZhcStBNFJDNDVGS0h2RlNy?=
 =?utf-8?B?MVdiMzVBUktMcFd0cVZObHBxOG9RY3QzWEZ5bzFtYkRtTVU5WGVMSnkrMjFM?=
 =?utf-8?B?QW9YYjhHbDRVZUJlN0FLYzVlb2ExTDZVS3R3bHF2SFBXWm1vaWVQOGIrcnIv?=
 =?utf-8?B?enQvWWJaZXlQNWtwNVcyWDMxZCtYajFUc3JhNVhialkwRDhKZ3l2dDR1di9H?=
 =?utf-8?B?SnRSUzVTQUpGcjB6azJ6Rk9yMHNSb3VLQzhsWEkzZ2ljUlpsOE5KVlFHVmNH?=
 =?utf-8?B?MlZ2NjVoNWtWZGJKckF0dkpLcHZCdlUwTkxxV0RDZzdMcithYktaZW5Nejdv?=
 =?utf-8?B?OWdpZnVqVnJORFUwdXF6Q0dSZVpHbExKandPVHJNcWdMWnA0RkQ5eEpsdUpK?=
 =?utf-8?B?Q3J4cjNlODlaRXNGMmQ3TXluc0NweG1pelMxMnB4SndreE40OU5DTUk5a3hX?=
 =?utf-8?B?emladmllR3dja0RLQzBBV2tJdDRMb2Y0amNPekRyUEhWclRJemd1c3RIMWpL?=
 =?utf-8?Q?5y2Jd+bWjwe2DuVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B56FA59097A234A86B289124064505B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ImiCZ3oOkHsx+GYSziLEUJfGccmb83+C7EOZkpy9bjXEu8hQzBaI+MPFeKpAmWqgzeeCD8NCtcbau3GLof/iN60Jbw0746to0bgSB2POwxJe8kIJzbSWtOI1jthbKc+8Tq5hOWOLC5goaUmRDKUJn5BYYeI9QQQJyXmVt+VmUb/TwC4Klzj7UX+8v77qzcM7yUvi5YQorqDoHJD+ka+6Xly9efLu74IZ2S62Ks2OPZEOJFX7pf7BBUx6ky/9ewMhhACQiqAQKcCm30Sr+o1pcV5jNR5b8cwdNRqBvKiGTeLwUV7i6hX0gRBy+MhGkna3ysYTz4KUM5b79Kw/M9EaBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fec82d6-b897-48b2-ec19-08defe239a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 18:56:39.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuLEY3xLbgtYJUNricRuGX/9zySqUTf4O9PGneMSFv/jepCOiNg766FvUbx5QsHiuurgxZoXlh3OUDJrEzW3Vqu5AFv+5AoVySfl3riY8to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDExOjQ1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEVsc2V3aGVyZSB3ZSB1c2Uga3ZtX2hhc19taXJyb3JlZF90ZHAodmNwdS0+a3Zt
KSBmb3IgdGhlc2Uga2luZCBvZiBjaGVja3MuDQo+ID4gV291bGQNCj4gPiBiZSBuaWNlIHRvIGJl
IGNvbnNpc3RlbnQgYW5kIG5vdCBhZGQgYW55IHVuY2VydGFpbnR5IG9mIHdoZXRoZXINCj4gPiBt
aXJyb3Jfcm9vdF9sZXZlbCBjYW4gYmUgc2V0IHdpdGhvdXQga3ZtX2hhc19taXJyb3JlZF90ZHAo
KSBiZWluZyB0cnVlLg0KPiANCj4gSG1tLCBmb3IgZGVmZW5zZSBpbiBkZXB0aCwgSSB3YW50IHRv
IGV4cGxpY2l0bHkgY2hlY2sgbWlycm9yX3Jvb3RfbGV2ZWwsDQo+IGJlY2F1c2UgcmV0dXJuaW5n
ICcwJyB3b3VsZCBsaWtlbHkgaGF2ZSBkaXJlIGNvbnNlcXVlbmNlcy7CoCBIb3cgYWJvdXQgdGhp
cz8NCg0KOikgU3VyZS4NCg0KWWFuIGFuZCBJIHdlcmUgZGlzY3Vzc2luZyB3aGF0IG1pZ2h0IGJl
IGEgbmV3IGxldmVsIG9mIGRlZmVuc2Ugb24gTU1VIGNoZWNraW5nLg0KV2Ugd2VyZSBiYXNpY2Fs
bHkgdHJ5aW5nIHRvIHdvcmsgb3V0IHlvdXIgdGhpbmtpbmcgb24gc29tZSBvZiB0aGUgZGVmZW5z
aXZlDQpwYXRjaGVzIGxhdGVseS4gSXQgc2VlbXMgdGhlcmUgaGFzIGFsc28gYmVlbiBhIG5ldyBs
ZXZlbCBvZiBhY3Rpdml0eSBvbiB0aGUgYnVncw0KZnJvbnQgc28gd2Ugd2FudCB0byBhZGFwdCB0
byBhbnkgbGVhcm5pbmdzIHlvdSBoYWQuIEkgYWN0dWFsbHkgcGxhbm5lZCB0byBicmluZw0KaXQg
dXAgaW4gUFVDSywgYnV0Li4uDQoNCkNhbiB5b3Ugc2hhcmUgYW55IHRob3VnaHRzPyBTaG91bGQg
d2UgYmUgbW9yZSBwYXJhbm9pZCBpbiBnZW5lcmFsLCBvciBzYW1lIGFzDQphbHdheXM/IE9yIG1v
cmUgc3BlY2lmaWNhbGx5IHBhcmFub2lkIHdoZXJlIGlzc3VlcyBoaXQ/DQoNCj4gDQo+IAlpZiAo
a3ZtX2hhc19taXJyb3JlZF90ZHAodmNwdS0+a3ZtKSAmJg0KPiAJwqDCoMKgICFXQVJOX09OX09O
Q0UoIXZjcHUtPmt2bS0+YXJjaC5taXJyb3Jfcm9vdF9sZXZlbCkpDQo+IAkJcmV0dXJuIHZjcHUt
Pmt2bS0+YXJjaC5taXJyb3Jfcm9vdF9sZXZlbDsNCj4gDQo+ID4gPiBAQCAtMjc2MCw2ICsyNzU0
LDE0IEBAIERFRklORV9DTEFTUyh0ZHhfdm1fc3RhdGVfZ3VhcmQsDQo+ID4gPiB0ZHhfdm1fc3Rh
dGVfZ3VhcmRfdCwNCj4gPiA+IMKgCcKgwqDCoMKgIGlmICghSVNfRVJSKF9UKSkgdGR4X3JlbGVh
c2Vfdm1fc3RhdGVfbG9ja3MoX1QpLA0KPiA+ID4gwqAJwqDCoMKgwqAgdGR4X2FjcXVpcmVfdm1f
c3RhdGVfbG9ja3Moa3ZtKSwgc3RydWN0IGt2bSAqa3ZtKTsNCj4gPiA+IMKgDQo+ID4gPiArc3Rh
dGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHRkeF9zZXRfbWlycm9yX3Jvb3RfbGV2ZWwoc3RydWN0
IGt2bSAqa3ZtLA0KPiA+ID4gaW50DQo+ID4gPiBsZXZlbCkNCj4gPiA+ICt7DQo+ID4gPiArCUJV
SUxEX0JVR19PTihsZXZlbCAhPSA0ICYmIGxldmVsICE9IDUpOw0KPiA+ID4gKw0KPiA+ID4gKwlr
dm0tPmFyY2gubWlycm9yX3Jvb3RfbGV2ZWwgPSBsZXZlbDsNCj4gPiA+ICsJa3ZtLT5hcmNoLmdm
bl9kaXJlY3RfYml0cyA9IGdwYV90b19nZm4oQklUX1VMTChsZXZlbCA9PSA0ID8gNDcgOg0KPiA+
ID4gNTEpKTsNCj4gPiANCj4gPiBObyBuZWVkIHRvIHJlbW92ZSBURFhfU0hBUkVEX0JJVF9QV0xf
NC81IGluIHRoaXMgcGF0Y2ggZWl0aGVyIGFueW1vcmUuIFNpbmNlDQo+ID4gdGhpcyBsaXZlcyBp
biBURFggY29kZS4NCj4gDQo+IEtpbGxpbmcgdGhlbSBvZmYgZGVkdXBzIHRoZSBjb2RlLCBhbmQg
bW9yZSBpbXBvcnRhbnRseSBtYWtlcyBpdCBhbGwgYnV0DQo+IGltcG9zc2libGUgZm9yIG1pcnJv
cl9yb290X2xldmVsIGFuZCB0aGUgbWlycm9yIHJvb3QgbGV2ZWwgdG8gZ2V0IG91dCBvZiBzeW5j
Lg0KDQpFaCwgSSBjYW4gc2VlIGl0LiBJIHdlaWdoIGl0IGFnYWluc3QgIm1hZ2ljIG51bWJlcnMi
IHRob3VnaC4NCg0K

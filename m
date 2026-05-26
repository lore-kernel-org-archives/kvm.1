Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E53D0BF9;
	Tue, 26 May 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813763; cv=fail; b=c8GJhHn7DlJqrp0qid865k21xdaCtIfM+hTStt346blA1yB3StbHjRfin1kYlBI7mZR1rWDQ5plVNoOgtVTbQd9sUEbJFRiX0eFCZQexyEBjH3Xq/w2uvAn8uQkzr9CP10aHWRs28YsOr2fo2RuBVSYB6+YXGGXF7xTvCUtrlBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813763; c=relaxed/simple;
	bh=Vd+11rNweEt7VfT3P9OtE4RUw5FnJCH7RKDSL7iREqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TPeig14MHpuMDWAwu7DJxUVWUcO7C0kZcUEyONIF0ONajdF4i9ZeGjZSNzyfvSRSFkvJ0l2UTsrhlkYVAYg2W9ohOol/+1JEMtXoUTNpE4qBdFtNR+ZZw/Rcw/I+TywIknFnyd2s99OGpPHpws0EG5ckZqJ/hAxJ8cMylfApIxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIteQJAN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIteQJAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779813761; x=1811349761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vd+11rNweEt7VfT3P9OtE4RUw5FnJCH7RKDSL7iREqc=;
  b=jIteQJANqwKp88Zy+lmvIVUtq4xbbrUhtEZm4kSchlw+tuLktArEJ5AB
   8LgVBl6UYPwCPtviObl5yQgqcTuYOvKDcYRgk6bNgVgSoJf3ro2/G/10G
   fyWLubJICHwsuDVWc1bAZSnNLMbecGHmTkj1jwb/SMzMJqONTTe4JaBmg
   6I6Hoc0+4ZHnhEBBw2aGPeEzQCVSfTWqGw++v9aJR+yJHENZwAI0eS6Tw
   raDMBV/2WdUv1HARHoLu1qN3yLKgZg9aWFiDQQkGEF87xrn2tYdZHOodc
   tdZHaiD9je3JXRD/1jxRUJUfdLTwZaHpN89F7FOsj7LLmBEXEw0MLTT6z
   g==;
X-CSE-ConnectionGUID: dZlXeh1sTAOheRUwWdhGWQ==
X-CSE-MsgGUID: oUtjuuBPRgix3z6zF5BBSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90934880"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="90934880"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:42:41 -0700
X-CSE-ConnectionGUID: xtWziRiOQT2GxFBhxEfpPw==
X-CSE-MsgGUID: P5953HYGS1SAx1IvCACQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246942853"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:42:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:42:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:42:40 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3A4xSqjbJDrBfiXrXBKABhp6mOcJUCqmWzDwT+/PYIv3//M91FMFvHQNoUW44VoXXk7LfXP3/r8MXnH+tewu068ASTy7jC1T1LcRncmlYknwWAixhFl2J9+k6X5nXoi1aEYt7tvY+JZf6FDgNEecd5gX2Pz6c8crzAVflze+ecpsfAdDXf+N68rFHYXUHX2llNHsYnLOjWvjaNfkZAyD3WuBrz5JiAVZPZZq2u63SeZZ1HmA9Ao2cQ34cNFPreLJmUV3lxnxi7s4u+jwBfm/mIHvoY3/AXg8Iw3Dxtta+3s8eG+OYwD7RhRNhYTcdfIDSvEmAwx/du/scgx0erEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd+11rNweEt7VfT3P9OtE4RUw5FnJCH7RKDSL7iREqc=;
 b=g2/QItrzgq4xvn04c5F+3iq66QWe9aFb23LySYNhS6GKx3oR9+i6UflPD1e/Vk8xO92um98GyZXfwvh7IJNcTROdtQUdfssFYltje5OBp6mPYDppdC0veJyXmxp0h7Bm9BfUtVG53YLw97+uaSOqVlRLsEWhrfhk+gyI94ldVLIEUTI+7kpyjSe/W0NktOLqiCTUcBAQVfMpmHbigyMSNdn3hQiPFz96+NCk5lgGa82rJqiN8L/rfDtXDBOV4/ANB7jCiovTFivGTiGgkURkSfG881NyvmySRF4EX1q7cuYIyROCt9H18gi9sffmqPSuvwjWlZORlRtu2Lu4tCtXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 16:42:24 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 16:42:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Topic: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Index: AQHc7LhTkBJCRmynDUGCQ1lB6jZxi7YgAfsAgACB1YA=
Date: Tue, 26 May 2026 16:42:24 +0000
Message-ID: <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
	 <ahVghgNAe4JrmlQH@intel.com>
In-Reply-To: <ahVghgNAe4JrmlQH@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6365:EE_
x-ms-office365-filtering-correlation-id: cb530e78-4395-4b35-4546-08debb45c3c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|11063799006|4143699003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: WHfpOI04VH8A1OzT49MYoDc/YyQGvn7WculSePTYg3tjbBa4+7R0NSNdyt5Wh0gr4O1GaFUSEvxQW9XLdDJRRsxTS6p9N7uO6Imo0flwIx+wEdNVckJyb+TDtFj7Nd4JJ5UypmM/RKRF246R4clyFdnzfCsWMI/6z1bKfAhIr1Se9QeozfL8Q+z4zunypxbe9kkZ6u+Vag1eY1+fUibJh3PYMjCCYxUQhkwUz8KasypKZa8zrAM6aTTSQLKojfRl7YE9M7IKsTAyhwvEol9vnPlu5qwxWwxReNuDOdFAnA/ne7ahPskiYFDC1EuKk0MAfPhA/McKRk8OnLMmDoGGjzzuvlfOzplTy8MsrtFRYzWfYBKNOIUwo/Zy5oJNshE7QCnEpkVK7MAqSr6z3HXu0tfgp7oZ8bfo3A3n+5c5T7VLND2K9iAjngxcPgRibelWiFXkSptHAhn9Or7W7pdeS7Be+DXG7IyrqJYMPULfu7Qd1MosgxnXw+mxeVRz8FfW5P6T2okbVZmasABF1c6KZvloCYb4IetxtYM96ffUrf/su88rhnG175kFWgTn411B8TNX0APC0bS6XByB1iLJncDRqoyMtLPy9mso4nkdxlHow30Z1ruID0GFRKDGKujf6lqD/DccuPmDTlzTn8Y7oSDUiQIg1J50qFihSQo36nXjd9rxFlqBwZADNYFnWRjjEmEQoXe0ulaN+ar+H3ln+FfLVnJxh7xfqKVoZ1T4AKJu9cHk+KfiEyCURFex+kor
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHVYTHNTK09nRGowOWYyM0h0U0ZFZFh2MzRndnlPR2pNNGd6K2ZYY3c1NEtl?=
 =?utf-8?B?QndndkxjSXFGa2hNTm10b3VCN043TXJES0tad0hETEpPRWZ3WmZzckk3RTNj?=
 =?utf-8?B?UmZNQVI0enRTSk9LYnJacmx6V0NSaTRlZXRHdXZWVTRQNVNpdHpoUmVzNVly?=
 =?utf-8?B?bXcxbUllb2dwNjVQT0t0Q3BTb0d2eGRXK0RhcnFGSlBlL1Ztak1qcXFabFJ4?=
 =?utf-8?B?SUcyQ2VuSTBiU2pjWDRVMHRuYTB3R0FZOGY5NWk1TVFXU3dDMlBKc05lZlRW?=
 =?utf-8?B?YlN6dHZsZllwUVd5T0plaFpqWC9ZR1gyK3BHU2lyMXNEaEhueWhYYXIyaVRC?=
 =?utf-8?B?ZkhNaStTTGQraDBmZnhEUHN5eGFhNVdjMElPRUpzNGxCUXIwMVhOdlR1WG52?=
 =?utf-8?B?akZYc3ZTMmp4TktoNlJoQUEzUDB6cklFd2ZiMWgrUWtTbmEwRUt2R2VMempN?=
 =?utf-8?B?ODZvVW9reVpyYkFRRkIrRC9YSW9lZk4xYUcxejF0cHp0MWdoeDdtUVJyd1hY?=
 =?utf-8?B?Yk1vaTdCQWhOV3RFY2xhMUFXY0Y5b21OR244MjYrUWtYUjNvc1JKem5Mbndk?=
 =?utf-8?B?L2lwaDgyUXUzV3VvQkVIZit2d0FsQ3VjMDNZWE1JRlVBUWhhUVMzY0cxT3dy?=
 =?utf-8?B?MU11c0xmUjd2MVdyRCtMeC9ablVVbW5sajJmTWsyWVJKakdPUWtQMkJCdVlI?=
 =?utf-8?B?UFdnVTZtWXUrMTBENDliaWlhZ29DemJaYk5pSEJJbFBKdVFYbmdWbUdMRWFW?=
 =?utf-8?B?Rm5WcW9yZFVpbE9kbHdSWmRyV3VOcDE0dDFGcC8vdTFsMm9vbzdZQW55Z3B2?=
 =?utf-8?B?QlhRVWdQQjNPa3ZaVWh0OHNtaVgyRE9EbnM2NlUvR1p5bHZXQ0NERW1zSndL?=
 =?utf-8?B?bFJycjU2bDB2eVdYOEd3TXI1NlpDUHpQUkxpVFlLK2dFUEQ2Qmt6SW5wNlBH?=
 =?utf-8?B?K2FIRHdIOHRYZklMN0ZuT2svSFZmWUtUMCtNb2l1VGM2NU0yZC9qQ1dTVDFp?=
 =?utf-8?B?SmZjeHUvRTZVTVZuLzc1U2w5UTljSDQ3S3lrQ2lWSmV4VVlUdWk4ZkJiUkJL?=
 =?utf-8?B?amcyMGkzU1RYQ1dvMTBod1ZLclBaUHJYZFBYTzVBR2RpOSt4Y0ZQK3g0Ykpo?=
 =?utf-8?B?Y1gzWGRadzlyUC9OOVZJVkx0UlM2c0RGc3ZmSlNzT2xzVVZGSHAyMGhwUDcw?=
 =?utf-8?B?azFaU2I2cFcyZXpYY2RkcHA2QzEvM0M2NGxxVnFIc3BQejRFbFpCWW9HWEpY?=
 =?utf-8?B?RktCREg4L0F3THBIbkFmR21MRDhYUTNWdFdkd0ZHUnpSM1oyeCs3cXpoM3pK?=
 =?utf-8?B?K2hPV09pdW5FajdRcFZnZzZWVUVEOTcxc25DaWlMRzNwdU9YMWcwSG5KNlk5?=
 =?utf-8?B?Z1RTNWsvMEl2VGU3ZFVxN0VLdFM1bHNYNk0vdE5sUlpQd2F1UEN6U2RwcTM4?=
 =?utf-8?B?emZuaXRTZXNrNC85NGRuQzF3a21rU0szbDByQnRFb29UTGhmT2VlcTVWTisv?=
 =?utf-8?B?eXMxNDQzMTdlWDhTNmEvL2IwYVJ0bVZQWUNlWkRuUkMyNVE2QkxHTnNiaVF1?=
 =?utf-8?B?S2d4RTEzV0FIb3FBSUpQWHIrYXcvS3lyQ0F4Q1hrUGZZTERQblQ2TTFHMGU3?=
 =?utf-8?B?bFN2R09tb3FJZ01KQUtteWtOOTZuMk9MMEFJYUtQNURKZ3ZtWEc3MkZsU1Vt?=
 =?utf-8?B?K2tMTisrQmtoN3lxUks1Z3lGQkphTTRBVXVlZlJMUEtmK21lTmFHYWJ6eDRw?=
 =?utf-8?B?SGhzd1NNYzVtWnhXMjVZWlRPRE5zYTB2ajNpYWNRZ3lDU1o2VTFkdkVsL1E5?=
 =?utf-8?B?cStWZlk1ZzZ0bHBOUnI2aU5YcXZTenBvNlV4YVhDazdINlU4ektORDFDblJv?=
 =?utf-8?B?b2dKVXNMQmdGYzVVMWxkL1VTY3Z6cmhBR2ZSMFNQYzdkTUdydDhVemIzTFFn?=
 =?utf-8?B?cFpFREhkTy9pZzlWdGkyNDZPMEpWV0I3bmRySHUxWUlTTUUzUnE5T2kybXJj?=
 =?utf-8?B?VWZ3L0NlSXdQaTBOd1NWQVhJbllCazREUmJ2MFNHZk9nYzZXQ1lheE5DaTd1?=
 =?utf-8?B?ZHdXcGFPZSsreG1ld1YyeTRoNE1CRWZVU2hzbVozYnJicm9WbUpQNGlvQlZY?=
 =?utf-8?B?Z1dWYUN0REl2M0VnRkxXMlRVVHBUWHJCSDNUTVpkczNudlhNTnVaS1ZiNzUw?=
 =?utf-8?B?REt2RXVVYy91VGFVOW1ROEs2MjBGZW9melJBNEpna290ZVRCNHZQbEFuTmRK?=
 =?utf-8?B?RVkvMFNwRmFocng3MG5QODBDano1bHV6RjRxMlZSKzlHS2srVHN3STc3TnJY?=
 =?utf-8?B?bk9tR0xVWFVaOURMSGcvRGw0T1Z5dlp0NDFlZmJ6ZElncnNVSWZUQUw3WU5Z?=
 =?utf-8?Q?iJPXgES9Vhw/ZL5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFB93F394FEBFF4DA2592EDC046B2E7A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WCPgE7qZGFDH0usClNa1wGKa8IFud0fuqoEcBtLrzK/Wqe5RCwUE+bFsVjuaWX5up00AdGrqaJCrT72PaS4n4z6iq0BJe/0Z0MbgsrapIlPBH7LPq9MyZC3+8GUB7QqPbgIbjUl0s7K4u2fnjIDAhX0PYw1cq2jug3ow9LjofFAyadIDjy1Iaq7+yn2F4w4A+xrtsjb8xpcEU46pYfXf6g3D5vGK+DtNZtK1TPJJLOgsTZCvisJE7mEj/yLx9v/xuwihk7IT9NFzgpetFp16gHTznSpD7njJQjF+4U7qCKS5jQlEQaD6N8FcOPP7P3RXff78zKnY4RSP3lJWgi5TdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb530e78-4395-4b35-4546-08debb45c3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 16:42:24.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieot7+1kNrKvvJcnfV+mPy7RkglZcTjemZea1b3L36RZuo7Se+XQTmE8QKz+RCJ5z2EiUlfMxNZzRCr+M7ppiSGHv6ApyOPdr+yGc4Yghyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDE2OjU3ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiAt
CXNjb3BlZF9ndWFyZChzcGlubG9jaywgJnBhbXRfbG9jaykgew0KPiANCj4gVGhpcyBjb252ZXJ0
cyB0aGUgc2NvcGVkX2d1YXJkKCkgYWRkZWQgYnkgdGhlIHByZXZpb3VzIHBhdGNoIHRvDQo+IGV4
cGxpY2l0IGxvY2svdW5sb2NrIGFuZCBnb3RvLiBJdCB3b3VsZCByZWR1Y2UgY29kZSBjaHVybiBp
ZiB0aGUNCj4gcHJldmlvdXMgcGF0Y2ggdXNlZCB0aGF0IGZvcm0gZGlyZWN0bHkuDQoNClllYSwg
aXQncyBhIGdvb2QgcG9pbnQuIEkgYWN0dWFsbHkgZGViYXRlZCBkb2luZyBpdCwgYnV0IGRlY2lk
ZWQgbm90IHRvIGJlY2F1c2UNCnRoZSBzY29wZWQgdmVyc2lvbiBpcyBjbGVhbmVyIGZvciB0aGUg
bm9uLW9wdGltaXplZCB2ZXJzaW9uLiBCdXQgZm9yDQpyZXZpZXdhYmlsaXR5LCBuZXZlciBkb2lu
ZyB0aGUgc2NvcGVkIHZlcnNpb24gaXMgcHJvYmFibHkgYmV0dGVyLg0K

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB55B1EB;
	Tue, 19 May 2026 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160608; cv=fail; b=QP117TJ8442P1jtlDQO7WzrTitXRH3Us52wtby3YmSnr7cwH9vOTPF7s8OiKMD2zt0F3QPgNC14qN3asYGSAc1QUSINv9ljYQVCT8Jz/+TWZ3WZv5kzxXAxnCDk3Cfdt0UoiAbe+SHcGsGSeLFV85zONLTadieDIABbCEK4M5Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160608; c=relaxed/simple;
	bh=ZAJ+DT7C3XMsA/YFre7t8jvPe2nMOR/sslfcNla1POE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGLHS1JlxOVWh3IAXq3cvxUTH8wbJyK/sCmHvIHVwmHMoqw+87HaM2BldgTdsq7yAzHvyRX75l3fvHaBCjk1Ll03dOJCA64h1j7488xaqqusL/ctjB/gwEIH7GcVBUGnYJP6US9KrUTuQ5p3FROfOJDmZA/QbcnTnl+2UuJUs3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcJht9Ai; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcJht9Ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779160607; x=1810696607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZAJ+DT7C3XMsA/YFre7t8jvPe2nMOR/sslfcNla1POE=;
  b=QcJht9AicQVmB0Ti+0d9gCNnEvtPelOSsav5F+uh1H5Q6qN6Cyu5nevc
   tMyMIRoiM+eW5OeproaM18x/cjxvoqV1IpZ2yIV1JaCD47n2fNjhjXvCd
   9Gxhp7Hixul+nTh3rPH6fLBf8BiYKboEDbhV4Xi71ROFp7uEYJt9XzTPR
   lhUpDa+N/KA1X/Mi5BKP8PcVgRUoF13eHdYuHk2dd77UryV6ffeRLgpzW
   hulCQcQN4wTGn+LnJuZaOoXLhTOA6y3yACin30gPqMgtiGA11He94ST6p
   D9/OB0NTKrvmFTWLpMrWoatOaKfRcvTHW5mjqrbjNEb6nv4dbjH5UNj1i
   A==;
X-CSE-ConnectionGUID: 8Cifu0TYQ/Ooqzj3z9DNLw==
X-CSE-MsgGUID: U9d5HvsqSsuhPgBNw/HAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80148977"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80148977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 20:16:46 -0700
X-CSE-ConnectionGUID: kOUO/B+SSg6KpnJKCaOY6g==
X-CSE-MsgGUID: ZdVbI+DfRo++9yNUJX7y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235181246"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 20:16:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 20:16:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 20:16:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 20:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXHXkoKzWXOagklpPEuSKbmMklIfByyJT3nb7arD9QZ/5DP5RQwhYYv4RH/H5BkcVmAoVGyphQml7b/OTaiUfN8X63lhQnVOrYir332vtEA52XgjM8G0WnZbL2MrW81QMHBoEUvWhyujUSumdWleLn+MBpzUYCXItcDMUNesjueACCJQHox57C6pK6seD3xrmWqsrWd0/LbeCe7HU5ezn1ApjNjQ9nF9pP3uR5MWKcpf6x6nkLSgGxPLi0R54A4oaB3sv94+7Hg718gAg5038erzhXOXYYctACSEdbNOCjJQKkEnqZ+O6SRINVYOxtZvtcXCWwn379jKEtZcldd6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAJ+DT7C3XMsA/YFre7t8jvPe2nMOR/sslfcNla1POE=;
 b=Vy/h/rEHd1CBiBWReDmZiiUORu5u9uaZnVHqBM4sjEitGLJ7N3PCWO6NHyHtAC2/dRAkqOn6CyQT6vgGUyCAZiFRs/Rouoegbgso+fBMkKsiKQYguKrPSQTDivPvRbWaDOHbMbPll8U6fDoVcKGjQ072WcdMHhSEmVEgFJCh2w5Hku7hD43gS1c05T83kMrbjLr1zeeICAXgQC6eInBeMCftZRWUlPf1/v/cugMsubC4nnyqiHpw9PeP/pYUzHk59l2Dm1JcPIlyZnxn++6SqLEkAfmvgD6F9v68DV70a4O1i5goE9RJ3RqnNfZfOPdZHhYrCZIKV47c0fXQ/pmN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:16:35 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 03:16:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 19/23] x86/virt/tdx: Refresh TDX module version after
 update
Thread-Topic: [PATCH v9 19/23] x86/virt/tdx: Refresh TDX module version after
 update
Thread-Index: AQHc4urd06UoS/lZ0UiZZjjRIlgikrYUtfQA
Date: Tue, 19 May 2026 03:16:35 +0000
Message-ID: <dbfb8fa01ee6035576c6cb2f665372323117a63f.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-20-chao.gao@intel.com>
In-Reply-To: <20260513151045.1420990-20-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7842:EE_
x-ms-office365-filtering-correlation-id: 085978af-f99d-4f92-342e-08deb5550896
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|4143699003|11063799003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: wGMzdBqZ0IVzeSj/s+WA8VuF8owXLL+WMAA4PCzi/e3JBaotUgDzzy8xK+UCELx8kT4m33KLpWqclt+kNARWIZTZixRuDDAnXL7DwS/y+fmRg8zNErfFUxZ2ExNNkSETFb79xHsK8z2vA+QqgjhtPpSczlUp/vzjhzKnZ/74kz/gkwbz4589kOKM8fECsgd8e16rDVMSB62s6BZiaTG04NcwkwVPVazpHjK13W9oxVEbwylgWBIsj6gUgsUgwY6ySHWDb9/MTj0ga6S7iegmKkXUuL2GDHWXSY5Ycx+qjzdvOlT4BXBxjYYgdiNeYJPnooP7QkhCZOiq6YibmBGpP7rlBDR3a7AYITSumaKhNk+TAMJc1GKH7cpNre0pptAWKiPuLHVq75RyVnBpybiEIHwDIEf5ioZJybKHw2z5sda2CZlJUFAX52fDamEvGlk/bb8mNyVIkuF8vnR6v7TJRNFmXGaOgrr6+ArHwm6j1h77CrblkkmcIIrl6sMStTEqfrIyeIRzfHrgVb/HhYGuAgtlfVqQ80UgwYHTTcV7fgv3cB3dL+tMSHmwgSH2KfccCiddQuU6j7+eZ1OvFzFz5LXP/w0gAw76Fcfku76rSytjdykqESI/h5fOKOM/F/RmEb5FRKG655YQ33tA5rcMa1scvaGhdSLAScOAD4P0whrvREFYEo9UHsFXN3zevo19VXjtnT3sfJMsK1bcOSXYpoqWymNf29xH/BzijvJPr/Tvu8Aqla/ijPFCd+pLAmmG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(4143699003)(11063799003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajJ0bU03K0dQNUF3elBWWWJVVU9XMVFUaGlmbTlTQlJWUnRaWGVMcHdLc0FD?=
 =?utf-8?B?VW9oRHNxM1BRMjU1bFUyY2JlUkQvc0xYVE1UTzc1QnNtMGRkOFAzKzBuKzBs?=
 =?utf-8?B?UjJUdEtEZ2cvaCt2czBNRmVndEhJZnNSeUdHM1Qxd3lnUkFJT0Vlc3VDdkZ3?=
 =?utf-8?B?eTV6VDRSVzJ0Q3NsZ3hrMzFzYnVCS2UxUTBweFJOdlZIMGkwQU5zSzExdTBw?=
 =?utf-8?B?dFBvelJkRHZXVFVhZU1oN3dINE5PekQ3TTM5aFVRUitvcGRxRDN6K1BaaHZK?=
 =?utf-8?B?aVN5T1VGRVdVKzhtZjFlTk8vc0ljTkhnRVF4QUgxcERjWkpMVWtvRlZQRHBz?=
 =?utf-8?B?V2lFNmxoQ1BoYmc5dkhsM1lmVTBQWmtRZTJoS2JOK3hlVVJzRkI0R29lZlNa?=
 =?utf-8?B?UUQ1QksrT2xiMHBya0Y0MWtWV0dxQ0JTY0p6Ym1uWHBmcmE4czI5WkxZVEpL?=
 =?utf-8?B?ajVsVXkzVlFvME1MVWx0TTUvY1NzdWRuWTZNeWFBa0Fia0dhRXFQKzNpZkE4?=
 =?utf-8?B?V1QwSmlsZWh4Sktwa3VKRHcvRGdRMmp3VHhrVDUzblpvYzdtdzdJNDQ4SUhV?=
 =?utf-8?B?aGhDcURqa1RibU9QMG1PY3BTUmZPamZtTXF6TEM0YmI2NUZIdlpMbmMrOXdW?=
 =?utf-8?B?WUdDeTNFTGd4QW80SitMaTNMZnZQbU93NWJ0WHlBUy9tOGxYY2o5TEltUjhX?=
 =?utf-8?B?QnNYT3ZQMFl3Mm5Nekkrbmc0MVpVOFlWVzZIaXNDWHJDNGVobStLR0FpdW1t?=
 =?utf-8?B?MUNxUzdtS2doNnlNRDFaWjRhT0xCdEIvdVF3MElaLzA5MzYwSmNNUFpGSjVP?=
 =?utf-8?B?UzhvMFYzR1NjVzkwQy9YNEJoUHVBdUM3ZGhyNThCclZGVVM3TWpaQVB1blIr?=
 =?utf-8?B?NWRJNlpkbXNHMXRXTkptWDFLNndKRVdIME84WVpKZUY1WlpkaWNWb0dvc2Zp?=
 =?utf-8?B?bUhIbTBSYjBVSElWOVNtRFJrTW03clBnUDJMWmtCTUs0a3pWSis1V2FXcDVD?=
 =?utf-8?B?c1B0dDFMN1cyWHhlMzFKcUVUQ0l0ODZrVVFWeGtVK3BCL2N4eWR3bnRkdXl4?=
 =?utf-8?B?NmtLcktKWnk1S0w2ZkMwTFU1V2pEeXNWcmtlckh4ZWZUcElEUXo0WnVOZSto?=
 =?utf-8?B?VWtwTlNVRkhmMTJxblpZZ1NlalY0NTE0VVRVeXdmbEtmdzZjZ0xITFh3VW1r?=
 =?utf-8?B?RDBMM2FoTnYyTFJ5bnFUNEdqbjY1cy9adWpBQmh5eGZWM3MybmlnZm8wM0dj?=
 =?utf-8?B?RnpmaGtma3lVbjEzbzhac3NtQ3hFNXV2bWdUMWRFNTY0QVdEemp5djhBblQr?=
 =?utf-8?B?REJrRFRaeFp6TTVxTmc4cTJYd0wwMllYUWNKakpHR3ZRZUxoWTNGVDgybHpQ?=
 =?utf-8?B?T1pnQ0p3ZWhKMnJLcEk2YkJGYXI0RGhIRjgyRCtEOUdrRmEwZ2pWcmszWUtI?=
 =?utf-8?B?K0hNNmhmbVJTOXJBNHVvS1M5dldUcEJZNXZjbk9BcTBVMDBLbWpBV1J0UVNT?=
 =?utf-8?B?eG80MVZRbUx6MkQwZVl6ZzFFK2g5SkhnMlEzK3lpUFZ5OTFQditKMjZoUHho?=
 =?utf-8?B?ZENtcWgwbTA4VS9BVDJ3a2JvSmFPdTNYY2xvSkJvREFjUmd2eUMxQXYyWXpo?=
 =?utf-8?B?QjFiUFZDaFIrTFh6K1hZcVVqTzh2NFlpRzR5eCtsYTQ1aUpWRlJ4bUhoT3pU?=
 =?utf-8?B?TTVjN3ZDcDY1SDdtRzV0ekh5TjZ4TGZJQm9tWUpROTRWMjRpS3oweE15MDFx?=
 =?utf-8?B?b1ZVNHN2V1NoUHhqOG4ramY4MFRmVmNJTnNlVk01cUtqTHpyVWU3MnNBcTlS?=
 =?utf-8?B?b3Axc3kzeVZtSFpQMlI3WkRFZTB5akRaa05nY1J3TTlGbmp3czhzV09ZVnR0?=
 =?utf-8?B?Q1lVVHlEK2VEczZVMnpNY1VReG9IdzlKQkRla1NTUG82NlU0Wi92QlJSZW5V?=
 =?utf-8?B?enBZdHFZQU9XbVJ3SUwzRjNOSTJaRUVVZUljUGVmVGhOa016M2wvZmpHUWlR?=
 =?utf-8?B?S3FaLzJ1NVJ3RUl3N2hLWFhFWWk5MFRYTVlsNkFRTXVvdGUyaWRFcHVNMHB1?=
 =?utf-8?B?R2kyNEJrUEE3eVNhbE4vekUreXlaSXI2dDFIaXhxcVM0R2I1bUNaNEQzSlhY?=
 =?utf-8?B?OFc5dlZkQk1hdHNVOVlmalVHLzJZN2txOG4yN3VicXd0WWZZVlF6cCtxZUk1?=
 =?utf-8?B?V3J0aDhkN0dybVdkTnNJbjhNMmZsNGRieGlaMGxSSGpQbUoxRFZORWx1T3Ry?=
 =?utf-8?B?UFF3UENuUzlzVHVSTllNWmR5a1kzYXE3NWcrNFRlRkxHZDdQQi9RV2ozNE8z?=
 =?utf-8?B?UC9kMERWWTJLazBYWUdPZjYxWThkSENGSHZzN2xvY2RZM2hBeHY4cjQyL0kr?=
 =?utf-8?Q?wj43wgghJxtW3Ruw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C08B0F07C656374097F07ABDAB705EE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fry+oDnjTjDV+2JmijS3+xUuoQFi+z/AcHbfbqFx2tQwgw9AD3jpz129bqpP8sLeFvJullvecCn2lWlo71Af9IiYlM6/Hk8deyaRq5wQEW9ecMObsw4gEIY29h06DvHnJ/TytVz2W/DVhFNlV9MgMgLTrTkT+9/UC58Plz9tT/o5tr3bA7u4Csifc6nmobrRt90ifh7VEx0AISV4HbJbOrHVDNCIOuMeCHLM5ctxSCh2kEtzefWXvsXIRJVJ7GAT9L9/LyjIwp2o2j9bVL0W15TXMK5QP4ixwJuCoRljG9VpMRsST3Ic5/zJ290qcvz4g1dqtHSenkSK5bcewYgv+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085978af-f99d-4f92-342e-08deb5550896
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:16:35.3541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: on1lSpmT3OZ3RC7nnuO1ejh35KODVCDwcINQvpaaWXdQcEuIQ/G3+S2xP5ZnG9GKRD2t0MU6UH/aBPFCL4BQcHFBl/TlkhtOvZFAPBZl8iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA1LTEzIGF0IDA4OjEwIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IGtlcm5lbCBleHBvc2VzIHRoZSBURFggbW9kdWxlIHZlcnNpb24gdGhyb3VnaCBzeXNmcyBzbyB1
c2Vyc3BhY2UgY2FuDQo+IGNoZWNrIHVwZGF0ZSBjb21wYXRpYmlsaXR5LiBUaGF0IGluZm9ybWF0
aW9uIG5lZWRzIHRvIHJlbWFpbiBhY2N1cmF0ZQ0KPiBhY3Jvc3MgcnVudGltZSB1cGRhdGVzLg0K
PiANCj4gQSBydW50aW1lIHVwZGF0ZSBtYXkgY2hhbmdlIHRoZSBtb2R1bGUncyB1cGRhdGVfdmVy
c2lvbiwgc28gcmVmcmVzaCB0aGUNCj4gY2FjaGVkIHZlcnNpb24gcmlnaHQgYWZ0ZXIgYSBzdWNj
ZXNzZnVsIHVwZGF0ZS4NCj4gDQo+IERyb3AgX19yb19hZnRlcl9pbml0IGZyb20gdGR4X3N5c2lu
Zm8gYmVjYXVzZSBpdCBpcyBub3cgdXBkYXRlZCBhdCBydW50aW1lLg0KPiANCj4gRG8gbm90IHJl
ZnJlc2ggdGhlIHJlc3Qgb2YgdGR4X3N5c2luZm8sIGV2ZW4gaWYgc29tZSB2YWx1ZXMgY2hhbmdl
IGFjcm9zcw0KPiB1cGRhdGVzLiBURFggbW9kdWxlIHVwZGF0ZXMgYXJlIGJhY2t3YXJkIGNvbXBh
dGlibGUsIHNvIGV4aXN0aW5nDQo+IHRkeF9zeXNpbmZvIGNvbnN1bWVycywgZS5nLiBLVk0sIGNh
biBjb250aW51ZSB0byBvcGVyYXRlIHdpdGhvdXQgc2VlaW5nIHRoZQ0KPiBuZXcgdmFsdWVzLg0K
PiANCj4gUmVmcmVzaGluZyB0aGUgZnVsbCBzdHJ1Y3R1cmUgd291bGQgYmUgcmlza3kuIEEgdGR4
X3N5c2luZm8gY29uc3VtZXIgbWF5DQo+IGluaXRpYWxpemUgaXRzIFREWCBzdXBwb3J0IGJhc2Vk
IG9uIHRoZSBmZWF0dXJlcyBvcmlnaW5hbGx5IHJlcG9ydGVkIGluDQo+IHRkeF9zeXNpbmZvLiBJ
ZiBhIHJ1bnRpbWUgdXBkYXRlIGFkZHMgbmV3IGZlYXR1cmVzIGFuZCB0aGUgZnVsbCBzdHJ1Y3R1
cmUNCj4gaXMgcmVmcmVzaGVkLCB0aGF0IGNvbnN1bWVyIGNvdWxkIG9ic2VydmUgYW5kIHVzZSB0
aGUgbmV3bHkgcmVwb3J0ZWQNCj4gZmVhdHVyZXMgd2l0aG91dCBoYXZpbmcgcGVyZm9ybWVkIHRo
ZSBzZXR1cCByZXF1aXJlZCB0byB1c2UgdGhlbSBzYWZlbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFJp
Y2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0KVGhlIG9ubHkgdGhp
bmcgSSBzYXcgbWlzc2luZyBmcm9tIERhdmUncyBsYXN0IGNvbW1lbnRzIHdhczoNCi0tLQ0KPiBO
b3RlIHRoYXQgbWFqb3IgYW5kIG1pbm9yIHZlcnNpb25zIGFyZSBub3QgcmVmcmVzaGVkIGJlY2F1
c2UgcnVudGltZSB1cGRhdGVzDQo+IGFyZSBzdXBwb3J0ZWQgb25seSBiZXR3ZWVuIHJlbGVhc2Vz
IHdpdGggaWRlbnRpY2FsIG1ham9yIGFuZCBtaW5vciB2ZXJzaW9ucy4NCg0KSSdkIHJhdGhlciBo
YXZlIHRoaXMgaW4gY29kZSB0aGFuIGEgY2hhbmdlbG9nIGNvbW1lbnQuDQoNCklmIHRoZXkgY2Fu
J3QgY2hhbmdlIHRoZW4gd2FybiBpZiB0aGV5IGRvLg0KLS0tDQoNCkJ1dCBJIHRoaW5rIHdlIGRp
c2N1c3NlZCBvZmZsaW5lIHRvIG5vdCBkbyB0aGlzLCBpcyBpdCByaWdodD8NCg==

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B43A75B6;
	Tue, 31 Mar 2026 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954001; cv=fail; b=KoJ6VQPrXGFAYPQk5v32axezZxLcM0svVNoSVaSvgj1idBSavosyDLOtsmVkWLtB3/Ti1GCmqvBm4Z/LG5YMkuZpjNQSQkMv2OQx63wskCBKGZrokQ4TUZjmtHczNHkoCrWz5qVeVqzKOSI3wfZbdTBi6wE+aFD65CYHKpTTw6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954001; c=relaxed/simple;
	bh=1buRfSr+j1NIbzyvAb50OCki/snAQT7ofpeo2T1Rzq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkOyfApQ+29cU+5NEpAK3H6XsKjM3TEO56a2gw3zY3C6VJnoa5JKkyG2HkrmBGczwz9kCHlfXB/OK08zD0IGBFexDhbiClhRx9D3m3LxXIfFMJBO3Pv2hJKLKJXka2bZPLQGSpiiDu7wRl/xTaWRNWBtaZKE/DdcDPmIuoCqM5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+w0jjr4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+w0jjr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953999; x=1806489999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1buRfSr+j1NIbzyvAb50OCki/snAQT7ofpeo2T1Rzq8=;
  b=O+w0jjr4He2F6cY7W3BnTajWzHWzDShlIwduH6P3f5uIYMw/uf0EeBHE
   MkGBS+Td6olI5dBE2fM4VGKF/cHxff3ZmKy8kvvItE2yw0Ww5Szn25Rel
   6lcKUy4nG+NwSidhMrS1vp7OhgcBMQocjSuTiG9l4DwHGFDDylT8trQB7
   yV/L1VUrOQ7sefdE4EhR7bvdmgY68GqUU6vAUWN7r7r4vQGdVF5wxk2SR
   6HWvXtBZTULNgUNkTp/VV8wQPvFcKQcx+PQLcUvs1qV2gFZwpL1goKB8c
   kdm+XJvWxGQpB6vuNXIGoKjFNrMaLhp7GVkemcbNGZF0hhoUVPLLF2uZq
   A==;
X-CSE-ConnectionGUID: ysdkIhVyRVmR5DWpPITo7g==
X-CSE-MsgGUID: wmF5jqlHROieDMl50qq3OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75849948"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75849948"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:46:39 -0700
X-CSE-ConnectionGUID: QPm4vNGaRsGb8ZPrni2tMg==
X-CSE-MsgGUID: ga0TvU6eRAeYKbBFwxpOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="249374895"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:46:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:46:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:46:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGmfHvWPfdpcuvuEdi7bP1dPc6eAxoDZoeFdWQBhqn6WF0MROb0+vjcN0ZPoBFt8hYR4q/bSnmLiKeqWIX3YQcd5Lw0ko7SGH+nA/EW4z4IomUT4xtqjPaFvZELbb046aCx1FQfxBUBVL/OEEYg/MqWvA7XuDGMLYFX6oyafDA5M/dlVFAxaVF45F4VAkTUeQgNGJpiD89aygWMxpfqQ7f9ps5vgNCY594PKnbgP26yt69FSbnFJDlCBhRD04Va751vUD91r69PIDdXYcpOm/Afl24lS5T/rA/7vDmugFq5758iWx2IfDwVK9TfZ6J6C7QLzd4efB2ILnqnpmAnTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1buRfSr+j1NIbzyvAb50OCki/snAQT7ofpeo2T1Rzq8=;
 b=BFUs1NyaNVFHoO2zd7U/gvTbUDh8Vn4B27/Q3RzqkSvYfsqqwi12s6mmwojD5WuGXHRvu0Lru7G6drzOAD6qwsG1ve8oq6HMThwVhY9YeH2xD8wi+yqtlnXcvGorcz31nWNePFfgObEIv7G/lMlM5PiXICEvZheQ9jyGaZNEJyc5av/ZnztYa6pvkCC15MaF56Y7pu4KqpPCCpMDI6Ll0ijURdSGPSPnkSfcMA+O4ivHtF0lXa/OKric5OcoLZBhaGNFyMVNTzPGmvsSdVHNT7v0UULNwanFZ51MTyjf7kBCaKdEqnopCBbIC4p2EfrJt9HowpGTFsOOQg+b942+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 31 Mar
 2026 10:46:36 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:46:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Thread-Topic: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Thread-Index: AQHcviZXQ2RPKLhQb0GPww7HVEzv77XGqbWAgAHRRgA=
Date: Tue, 31 Mar 2026 10:46:36 +0000
Message-ID: <7c580a45c27440852ddb16465bf8a9acf41381fc.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
	 <acofvYU6zlzeF6wf@yzhao56-desk.sh.intel.com>
In-Reply-To: <acofvYU6zlzeF6wf@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MN2PR11MB4725:EE_
x-ms-office365-filtering-correlation-id: 5cfaef4e-8994-40e0-12a2-08de8f12c81d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: fcL7HoxLXOUBA5Y9vrjaLxAcoV9v1qV8FS3IvD8cdp2G9BU+v8++/t3JaZ4M3nWacvxkKae+ufI0+VM+7/XTvyX6NoYz2nkXt8tEdGKf9LJ8xuNQH7E9lLJx6R6M5GrrsP6weN5cafp2q/0S4s2PwKCQXqZWdDIOsLsBLYbg/m5QBJM3bTmIUnBmK5QFzmSeT4AfLkzV6YbopoDVGJ+OPQ8t1V4vHyNigKyGS7Il/+lbuKISM2OT5RD97TC5Dt56i7aGITGEIoZ+FGxyY+LOllc4zFylKy3bueaZntXB9rMywhrHmHIWM7gUbJwXmoHzF38m5R9qquorynkiMbt5jDVL3P47d3kecV+IVifGE2M3rQtepAUucr7PLUAw680YOE6ImGsmh2plj9yqg64o0up8s4fvZgX35MTbCTFt2m/1exLhbjs15wxBZB5mRk1d4H5q9vWhyiqX+kh/eachqi4RG/eIIxThE11qQxn7bqq9sY8hwpDE6+8d0Sc9eD4QpDWA69aBXMkSt+cJFg4vSAHQH6ZvGE3UpD6ktfleqAkHTYBHceeOxixI7BeQA4cPBnSUVeNwShlvqJWw72ZJcYwngQXgS1ffmTmFuREZDRkpAHNhc3oH5Pt1WQn3nmjb35HE4uPyd0b1CLZ41xzxt4s02MYIP5Ztc2r+Sb9TTorNCS1eRuISZlfkFh2A6/IYXpd8AYM6ao6CQH/dfzOtLzsMKuS2cr2CVvtBvECpzcRmxjLpryGMSN6FDnmFK/iPHQPrgAezCfegkBScc4Yug6AOjUJ/Bwk3wBZvlEfJ9ds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUoySVNBcEVwS29VMTJlZk9TL1FXSEh3a0ZqS2E0NVJHM2p1VnNqZGtRQzdD?=
 =?utf-8?B?azFMM0laRFpUdWlWcTlFZVVTdGFNdjFOUUVYVFVuWWNKQlFEQ2YwVjZkMW0z?=
 =?utf-8?B?K3hqUzN0L2dzZWZTM2svUVlwTXdWN1N6cDVjQUJFOE9nOG5GOUt6RzRDM3JT?=
 =?utf-8?B?K2IyY2JvQlA3TndLUWNSTExUQ0Jwa2dna2E0NWNJWEs5MTFzRGNwOFIwcmJl?=
 =?utf-8?B?V0RqMTBjeHRFYzFvK1VCVXFwdlo4QndFWkNmMjQ0bVVRb2JvQTZqVXdFbTVl?=
 =?utf-8?B?RUhvLy9WbUZuMEg4MUpjOFU3YmJWaUNmYTRrYjQ1aGp1L1gzRGg1NE8vaVE0?=
 =?utf-8?B?ZHFIMEJKazFMdXhjNXZWakV4YXNsbTViTEtwTVJaS01hc2hERGx5UWlFUlE2?=
 =?utf-8?B?N1RzYUQ5MlRlYmtNNmZzVmpkZ2lNZE9mOWoxTlZtaXYwU09FeDNQK3I5Y284?=
 =?utf-8?B?TUdKRndoMGdVZXdDZ0JrQ1FIOHE4RHZUVDVXVzc2MG5QOWNlYzE4aFkzQ2xI?=
 =?utf-8?B?c0w5R3YxeTllUk4ydCt0OWo1US9VSVB0bkcwd1RaZC9rcUlPdTNTRndaOVZo?=
 =?utf-8?B?K01JUlBQaWhFYTlZb0Q3blVsdUd4Rk93Ukt0YmxXcXptTjUzbUpWR056bEFQ?=
 =?utf-8?B?ekg2cCtKVTZPKzY4TEZvMG9KQ1E5ZU54RnVpaUhENVdnVGxBM2VjRXpGc1Zr?=
 =?utf-8?B?NndtS0xjNHBxdWEwenlCUFZmR2pBMHFkaEhrRitRY3FGQlUrcXJiYkxPU2h3?=
 =?utf-8?B?a0tRa3I0TE5YQ3BVYnJmeHlrUStmbWlPVzh5NTVqQmhMWlF6WUk4KzMwZUF4?=
 =?utf-8?B?c3FmRUE4QklhKzdpRDQ2TGFaWXUvRzhoREtsZXR6Z3JYNkc0TVYxbjBtRGph?=
 =?utf-8?B?ekg3eDdvZ1lsWWxhNWFrWW5MTC8yNDAyeHpucHZsNzlpb1BSMUMwV3oxbThE?=
 =?utf-8?B?cVBJanJBQ0lWeVlKTE93NWJBTnV4bVJWMDkxUG4yTUdCL1ppNzFEWVZoVmt6?=
 =?utf-8?B?YkQwUEZGaUxFcTltN0N6SDRnU0x6V0MrelJiTWlaSjFzek5kSmZ5ekNSVXI2?=
 =?utf-8?B?TFFRS2pvbDJ3R0tiT3FvanZPci94MDg0aEhwZTZVSGowUVhtZkRxZVJhSHc0?=
 =?utf-8?B?MzBZRXlkbnlSc2hhaVQ2WEVrWFh3eWZsSFJGYXE1anlVV2dUTHpOQ05vanB4?=
 =?utf-8?B?OXliQ1ZoRVM4SCtCNEQ5UCtvSzdUenpFTW9xY0pienFLMHZvNkQrUk9nUjlB?=
 =?utf-8?B?RHVYeTVtSlROZHVCWlE2aWoyY0JGRnpieWhLc1h6WC9KOHJzUmxZK29Wb2Mx?=
 =?utf-8?B?djI5R3F0RHFpYkRXd05nU2hSdTc4UHBocnRpYUM0NUtJVXIvb0VvaWtjTXpG?=
 =?utf-8?B?LzhUc1hzdlUyZC9IR0MxTVVMY0FNclhJQlZXdkNhQzlSZVozT0wwZnZWUU16?=
 =?utf-8?B?aGJPNzE1OXJHaW56K05sQWtVc1UyMVdNWnpBOG5vc0RHMHR1TEpILzA2Z0Nr?=
 =?utf-8?B?TVYrdWo1N05wWUluQjFHTWZWWTZzTzJnZ2NMZmZqSFFjK1gzL1htbFBoRXl3?=
 =?utf-8?B?SDhCeHhmVU5iSUFkZG4xWWVaRmxNLzYvRkM3U2V0RWJTdTZGdFJreTV1eEJj?=
 =?utf-8?B?M0NteHZWdkNiQXpZZDkvR2V2V3BjSEl1RENGMzF4YUY4UFZIYWxRT2hyZ1Fh?=
 =?utf-8?B?a281QzVrZ1B4Z280YTFoLytUeUZzZk83VnRnY3VLYVkvakNsaXU5WnFidytm?=
 =?utf-8?B?Y1FVSnl0U0tUMzc0VmxDMFBpaU82MnIyYjMrNE5RUnc0NFJ5QUVCMTc5ay9U?=
 =?utf-8?B?Qm15anlVUHArZDNXZytaRHlaQmttSlNBVDUvYzlJOEJQQlVQaVErWE0rTEJL?=
 =?utf-8?B?ZDJPT2hIRjBQR3EvTVN6NUpNWldqM0lKVU9RL2pFMmprVWwyRFUwUFBmQzNx?=
 =?utf-8?B?c1A5V0ZDZmhPN1J5VnZNT1RjeWxjTVRsU3hpQkdMckRiTktDMFhMRmhBd1pj?=
 =?utf-8?B?YUFjV2YwZHpzNGlHZS90WmtoWDhVZ1MwdGpRaHhnZXJydW14UWh4a3NkS0c2?=
 =?utf-8?B?RFdlUEk4WG9tVWF5ZWxhTTE0c1BTcDZ6QngvVUJSSXplaXFpbG9uWitkajBw?=
 =?utf-8?B?TkxTQlY0WlRNU0pDbDNhVDVFUE9SS0VtNjZFaWRiVnJnZjhmU1lmRUhHTGJS?=
 =?utf-8?B?L1BLYUdOeVMwZ0tOVlhxYmZvVk94N0VKclhHdm9FaHdlZFdDS3pzQ2F0ZlM4?=
 =?utf-8?B?R3Z4YUVsanNCd2UwTHYwQ0pzWFlGMlhQcEozZ2ZJZWpOOVQ2K2VyVnQ4cGgz?=
 =?utf-8?B?ZkYzVTV0aDBlWHVvYzAvQWNka0xacjY1S2s3eDNsQU1KdGgvK2h1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334244247F3BBD49B0D11A6029C4E9ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tw5FDXeNL6+d2Ag0GKj5oEO3iKcT+IpVtH8FIQJ+EUOfapFlnPYlJWXhiF7w3ZHMV7hk2rUsX0UDfWCbjLQZjdRsHLKyns0kRS1I6vNGSvo4lgYa7TR+2gzFSiS7IBjEGwOBghqWchWOFZFFTTlMAL7KgEDggbx62ev6gg3LEbLmVYCOkGLmhVZg5c4BZprA+ulbuDSplzIAMfJxPUwsQqC3rW0hrPw5fFG/By5OObRZZLQgaRorUNIpqLmwLmFIAdUYphaNgdHasrHgUPA5WakUE7Zby90f0WPLHEPmN+59KEMe6KRtS+ehuKmMiR3UApjPog3F17flBg03cKIAig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfaef4e-8994-40e0-12a2-08de8f12c81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:46:36.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8Zi0aeOoyXkfI8UWkJ+tnQNvyUov258LI0CWHbymrCGy9aOaZqPoSwGiEIVoeCuszvRhaoDI7lp09hxy+2b/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com

PiANCj4gPiBLVk1fQlVHX09OKCkgdG8gdXNlIGluIHRoZSBsb2dpY3MgZnV0dXJlIGhvbWUuDQo+
IEJ5ICJpbiB0aGUgbG9naWNzIGZ1dHVyZSBob21lIiwgZG8geW91IG1lYW4gIndoZW4gdGhpcyBs
b2dpYyBpcyBtb3ZlZCB0byBpdHMNCj4gZnV0dXJlIGxvY2F0aW9uIj8NCj4gDQoNCk1heWJlIGl0
IGp1c3QgbWVhbnQgdG8gYmU6DQoNCiAgdGhlIGxvZ2ljJ3MgZnV0dXJlIGhvbWUNCg==

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A234C6D;
	Wed, 15 Apr 2026 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776295973; cv=fail; b=kCFF4gAym1/7s83TINp1jn119ETNSxEGBLzma7OcnRXflYpEK+ixQ20V4INq0N9d2pyYbkPwaaPY167I1BtZN6HN0Gt1GO9YBeRbT/odX+xuMcNIvBk4qQD8bJQ/03kotHzJ9CeV+3CyNc878XxQqTp83X2bON0DJVYr+66HcWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776295973; c=relaxed/simple;
	bh=i9ZmKaCI7dvpiTWDektYLB6X1QNg7y/VY9Djl0Kc59s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mv5ISGGNA7a6oKjzMWluXPC1LPRwLlIVICiVVNI1pPsauLr4HWZUOzw5gZKRy6AT74ibk0ipiq16OOg2sMRfKd8Xf1MMbu5GxaK4gh5JcWpV2u8Y30u4TzMh/q3QmWlS/O1F1G5zbWyf1qhkPtqy6sm8xbrV8D2+nVAP54PC04Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUz/HFxa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUz/HFxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776295970; x=1807831970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i9ZmKaCI7dvpiTWDektYLB6X1QNg7y/VY9Djl0Kc59s=;
  b=eUz/HFxagiPASqWS+e2SKxorwGKK3lyFN/f4UiBmCadSXDqzoXcAnDLt
   a6frKdE9fz9PzOrVNS3obTAyC3dU0iAPnKEa+5dxf6UInnPYrdWLLR/8j
   ps6pxJ0IqXGIOKsSpb4cYJKtqkED/XUVSteKfK9pBRwPvz94GrXiMDt8T
   0XluTt5/t1mqh+0rhPFgD84QyKWF1gS6eFQwFyqy3ONlX9OCFZxFq72AP
   X+NnvLnrHCug0fvTeeJIPxVQ0DW9lo21QPGoRd98A/5887QHTBFf0wEAF
   dHp0yPjz4OoXj5zryo8BeHsRPgmZkIEUz705qvhBEzQ/CpvFzpbzBWk9i
   Q==;
X-CSE-ConnectionGUID: yNsH5WfbTpybibUEm3CLjA==
X-CSE-MsgGUID: Gs2vc+eoSM+fTO8HkTczXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="99935715"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="99935715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 16:32:50 -0700
X-CSE-ConnectionGUID: GCa44wNWTymQ05mQYnh5rw==
X-CSE-MsgGUID: 7zsh+Os2QcKdLr+yoDQa6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="260988765"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 16:32:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 16:32:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 16:32:49 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.48)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 16:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLBF4eCqZ0NuUyrRvgZAOt4NcTN3wT5oE8hrnBJP1BxrFDNccUXg0pKwVkRciAxfSvMjBiOv3Yaj+zLxMJM6EgJvJO7A0VmjPa6AYClyhpZqeCtSrjPhc0PDvTXAvPDgSQ6ROlITWSDf1cVAiXgrdqnDixv5bETMGwYQbqc12bEtxHtHN7JxWJY+AkMm49aT+X0kdc7WqhI1Eg2iB8kCfhR9IPCqJlvA/LoFgEsjO08PTefPIwlWwhHeuQTKWD2Ph56KSR/gNJA0Lz9Y3beMVJW7tS4LfJrhIjhzgsDFzmPglJuDkirBWiTPFtLgPQJpKe/FvbNbJnZJ1sg/zjEUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ZmKaCI7dvpiTWDektYLB6X1QNg7y/VY9Djl0Kc59s=;
 b=PWyi9lujF2Dzjc+SrPsjehvKvHKDobimlocqSuuEpzZAUNU2mT134faYgGp7PwNF31FPfad5hqmzOdUwePC6t04/rN+qvq6hVvQXWJVuDPXByzKQd5bgZvKKjx7g0GdRO/GilsMR1DyowPqmgT3B8oX0MIqVhQWATB/yUho3icAcQFEdMgP6CrY2gHorlVQd0HBf2bNLBxWuE4s77xv18JulMQGmrZBnPUwsYrXt7c5vFsazFBFWBIGq4nKHIZVBPZ/ORTI1T2pXVg6/HR5BczhPxGRMR0NqX4DY2T+DXxzGDfXgby/wYP5JmrO2HhVBFSaU/Qn6PD88MrSx+r2mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Wed, 15 Apr 2026 23:32:45 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 23:32:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
Subject: Re: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Topic: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
Thread-Index: AQHcyHyrzjYXYTlHnEikxTOUo3JIB7Xc7m2AgAPA1oCAACASAA==
Date: Wed, 15 Apr 2026 23:32:45 +0000
Message-ID: <9f4a3dfa2d3fa2a81161652d81585b779a182866.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-5-seanjc@google.com>
	 <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
	 <aeAFMwBTUCdeq1JS@google.com>
In-Reply-To: <aeAFMwBTUCdeq1JS@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS7PR11MB5989:EE_
x-ms-office365-filtering-correlation-id: 4fbfd070-f214-46bb-561f-08de9b474bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 0oyHdksLtLUQFzG7MrnT5RPE0m3rfKo1685v0JJO8gyXNeWRISludrkmAOLFTVbE/C3S69QfNGOEp0QNuB6ey2qI7uQgA4SdELUQ3NiUqUHG2bWR2c7iBVq1h5cmZJjikSu4SAgw5aAH+C+XakbKN/XpU52nSxKU4ex7n5MNqwKQNNDgl7+Yz7fZTfyHLs41OyoEWRb40PVpTQbZpUutoawl6aoiQE0VtYXCXYWwj/pzrUhB79/tgDr359qXD8fJ2342H5D6CSJCbTOfoDryzLHpcydYuwvmC4YLz4ES38uXdzeufE04mhGJqweeT86OVxtTNRqYId2q0LD16M0Mvw3SRDVH2S/Rfxb7IzKTlcyIXikESa6rdfSQA4c+q7oPcJTtpT7foRxLgJqVU9O6NSz8R3hUV94nIL6Y5/gqC9Zix4d19LWhMG6u94kbDGTlAJ4rtvHP18P1VKJsc79VenQgD3sMMbFPetaZk4qY95hvwcguJN/QomoRnwoQ2ZxFtkHtOypiCoATMaT038YxMh+ntQ5p/fC9cBj9fafco9Z+J7dHoDclrmV35ehy7iAq0z9yJu7YMaRFtzhI9dhRedVxWuskK5I+D7Rvyg5Q198OtlI+qotmPN5mjk8E4huOegc4+YDwYQVGT3OZeycmuzt9Wy9cIWJAREMbAmDacdTixxONn8xD8DJQYoDYaPy2PLa2Orq5NKAa/4ap7s3cmMzFSUZUOibtUfazQTiGuIOHYtr5JoZB7loyVURqcyjVwjVhVmcOsN+wRezcarGIpvRRcHE0Ww8gej0GzuItf+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkYycGtlQ3pYVUcwUHBSbGtDZVNqYldScWtJcXNJSkpITGxQazJBWUF5cmoy?=
 =?utf-8?B?SHllUVJNTkM1WFVmWWI3eG5ndFd4V1hPcURTeDZ4cVd1ajVNaW1DMWJYcHpR?=
 =?utf-8?B?eE8zR1JmYzl0eC9haHBpeTR1MnZweXlDQXh2WW5VenNJL2hTeHI0US9xK3pP?=
 =?utf-8?B?LzJyNFliQzNhUTk2bHB6aHhZNFpLRFhtYkFBQTJ6QWhRbys4c29OM3M2bUdw?=
 =?utf-8?B?V3hBTVhRWXhlUzJCamNiQmsraisyU3pkUWhuTEd3SGl4MmVXTnVLTEZiMkkz?=
 =?utf-8?B?ajZ4Wkg1aXY5QXRCa20rcVRNeHZldFJ3NFpkTFVMZDFuNTBuOWkybzIxZElV?=
 =?utf-8?B?QnlBbDR4U3FHY0lrMUs2MU14eHdkZG9JRXAwVmZMM3ZVWlV1enNBL21mU29t?=
 =?utf-8?B?NVNya2UzdkN3cy9NWWNxejU5N1JNd0F6QnQwdWJ0aU5IdVJVeTR1d3dHK1Bq?=
 =?utf-8?B?czI3ZkVwK3FmUFE4bWx6SVVBNURCZFpSRUZVd1lxeHJ1RnNOYU9YakZmeU5z?=
 =?utf-8?B?clA0bzJLUkgxWXpuV0l6bDdMUFcwUXl6cWRBaU8yZm5pS1ZLb3NjVFVNL1pv?=
 =?utf-8?B?RTFvaHZ1RWZ2WU9MQTlBWUw4V3V1dkcyLzY0YlhMOHEyUzk1V0xqNFBLKy90?=
 =?utf-8?B?RmJkSWdvWFJpVmJuaXdQV2pnbE0yR25BcW5wYUxCSDZBYjMxMkg4NlNmVHZt?=
 =?utf-8?B?cng4VE5LWnhZakg3VlRVenNUVjRnYmtES1R2OHJIb2VPT1pSVVQ3bHBlbTZ1?=
 =?utf-8?B?MDA0czJPOUVGM2MvWU0zVjAvNVJUYmdZODMrd3lXem56dmVMMWpJMVpHRDZt?=
 =?utf-8?B?dW9YdFRzNktya3NkTXAwdVRreTJka2ZCc0Q5R2t0YkFJT3pDbXh2aGdaOWg0?=
 =?utf-8?B?c1BvcllqQjV5aGMzVHptZVRTT1NhNjBBWVdTZURXUlZWQVJOQmdKUWt4MnZU?=
 =?utf-8?B?d2p5UHRyUHgweDZXbjdpc3dhOFBMYWlEV1ZiajluakJUSSt3QmJFL1F6RUU1?=
 =?utf-8?B?ano5Q1F2WENpN0wwQW9ZMy8xYjJMYVlnUmFJUmxUaVJnOHN2em96a0NPREUw?=
 =?utf-8?B?UFRGS1d4T3daRG5qZ1JmdHF4WCt6dWppMm5UQS9MS0tpMGI4dDVuUklkVnJ5?=
 =?utf-8?B?RjhiZDFwd0xES2ZiVGQzRmhCeWpSUC8yY0JSRStJeFJ1dUhCVVI3VXVIT3lw?=
 =?utf-8?B?aVQ2bGFiYXdubmZXVU8yYk1WT0xLampsUEtJdm5GYkJWOWJsZVpoNDhpOCsy?=
 =?utf-8?B?NkU4dVN6VXN0VzhCdkRsZDhFa1NoM2oxVWQrZHUzQVhKcGpmSE4ycmhYSm1O?=
 =?utf-8?B?L0lBQjc4T3BuL1hjeUYyUGl5Z0JLOHFodm8rcGRENTZKR0J3SjdnbFRGQWtq?=
 =?utf-8?B?VFFpNTZJVmxaV1Jla0l2bU5ERVh5MjQzZTNpQ1N5cWtPYkppUURQcnp3N3Nj?=
 =?utf-8?B?MXRnUlFNeTF5R1ZjRUVKWmwwZytwYXJ5WUx2d0xRZnQ1QkFQR0szVGVybUVa?=
 =?utf-8?B?SHp5TEZYYXIyeVBWU3k3bk81b0JObVFYRGRYRGprL0xQZlo0bWhoK29leUQx?=
 =?utf-8?B?WVRxZTFrcWthN1BOVzArbS9JNHJ3dFh4QVlTclZya1FuVmFqZmdoZDVURjRp?=
 =?utf-8?B?VGZsd3lRK3ZRRFZrY0JpNE1FbjgxT1VjNE1FVm0xV1V2Y3gwWXcwd1BadGsy?=
 =?utf-8?B?ekFXaklxV0JrK3pBcDU3NmoyZ2N1cmVqRXdwUDRjeVQzMC9PRStWMkNPaUhy?=
 =?utf-8?B?Z3BjTWdFbzFVN0RuVHN6UTZDYkxMNHplQUQ5aWxLanZzMUlWT0RlVGY2dG51?=
 =?utf-8?B?cHYxWmRxYVNFd2wwck1BeWtML2xQWUxrVVY4UVFESFNxV3IzZVNhUjVNc0FQ?=
 =?utf-8?B?M3c1ZVJ4bXByM3UwdlVLNjJ6M1NuUXBpbjJvWktqa01ER0llZGtBOUFNT0Z5?=
 =?utf-8?B?SU9TNG52NElHOWRsTU1vMThPYXF6NytTUW1pelNuaTJYNGQ4OVpHNU9mamhB?=
 =?utf-8?B?YlFaNFVKVGduNzhlaXVIS0J0Tk9tNVhkWVdpemhUNDBUMzZma052c0tWczBy?=
 =?utf-8?B?UTJNRDFxUTlYYnY2ck1wdyttVFNuWlZNVTZEclEyMFRENlJoQVY0UFYrSDRi?=
 =?utf-8?B?VGE5c1VoOUVTYS9ZL081QktKM1c4aE9zaHBXcE5MaVY5cFFjczFMd1U1dmFn?=
 =?utf-8?B?NWlCeXhiaWJCcVJlbjE3YWRUc29BTjE0ZUpLY3hyb3RxMEF2Z0p0R2tQcHlR?=
 =?utf-8?B?dm0yZGdHWEZKb0RLb1V0R2tJTkN4SmljMjlUaEJGUDhOalJaTVQwL0pDRjM0?=
 =?utf-8?B?M0Y5Q2VsaHJBSWZpajhveEo2Z3JZV3d1aENuc0ZuL3lYdWZHaDRHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F3DCEBC7E41E5458F568960C447FAF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nZUpQ5oA7ZDSxFkzzPh3q4WFLaQssif2icpTf6vuns7o7XhOwFMfD46kgme/Ka5LDA74+eDq12emR08HihyrLI9aPqFJ/xGZYsQm8pQrzJy9hFuSyAerGUz1ASwvyfNAfXaPspTlC8MY3PmpiRltwP74IUqTqfnVIeXZXkLh8hbRz5U5Ug0ePF7EtBRfhMX2xcD5WMfxJpR+35a9PA/juJ85lQXrefwZc0i+sZ+Ev6Q0mEpPVHig8meG+qCs0ZmZ+5YcH/YMIj28HSxQKTT0YSFwfT1ewoLE7iouKXuxIo/hk4ecJjp43Y/1VjGT5VmPayEr2idhmjif34/A1TwWCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbfd070-f214-46bb-561f-08de9b474bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 23:32:45.1961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPZQFpHKR4BmXzGBRouYZUVa6sj/Mc7ZwrcBBynstky575qX046uH/oG7rvY+h0RHVxbJy2w9juRjATynhCGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDE0OjM3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEFwciAxMywgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wNC0wOSBhdCAxNjo1NiAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IFdoZW4gZ2V0dGluZyByZWdpc3RlciB2YWx1ZXMgZm9yIEVOQ0xTIGVtdWxhdGlvbiwg
dXNlIGt2bV9yZWdpc3Rlcl9yZWFkKCkNCj4gPiA+IGluc3RlYWQgb2Yga3ZtXzxyZWc+X3JlYWQo
KSBzbyB0aGF0IGJpdHMgNjM6MzIgb2YgdGhlIHJlZ2lzdGVyIGFyZSBkcm9wcGVkDQo+ID4gPiBp
ZiB0aGUgZ3Vlc3QgaXMgaW4gMzItYml0IG1vZGUuDQo+ID4gPiANCj4gPiA+IE5vdGUsIHRoZSBt
aXNsZWFkaW5nL3N1cnByaXNpbmcgYmVoYXZpb3Igb2Yga3ZtXzxyZWc+X3JlYWQoKSBiZWluZyAi
cmF3Ig0KPiA+ID4gdmFyaWFudHMgdW5kZXIgdGhlIGhvb2Qgd2lsbCBiZSBhZGRyZXNzZWQgb25j
ZSBhbGwgbm9uLWJlbmlnbiBidWdzIGFyZQ0KPiA+ID4gZml4ZWQuDQo+ID4gPiANCj4gPiA+IEZp
eGVzOiA3MDIxMGMwNDRiNGUgKCJLVk06IFZNWDogQWRkIFNHWCBFTkNMU1tFQ1JFQVRFXSBoYW5k
bGVyIHRvIGVuZm9yY2UgQ1BVSUQgcmVzdHJpY3Rpb25zIikNCj4gPiA+IEZpeGVzOiBiNmYwODRj
YTU1MzggKCJLVk06IFZNWDogQWRkIEVOQ0xTW0VJTklUXSBoYW5kbGVyIHRvIHN1cHBvcnQgU0dY
IExhdW5jaCBDb250cm9sIChMQykiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3Rv
cGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL3g4Ni9r
dm0vdm14L3NneC5jIHwgMTAgKysrKystLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rdm0vdm14L3NneC5jIGIvYXJjaC94ODYva3ZtL3ZteC9zZ3guYw0KPiA+ID4gaW5k
ZXggZGYxZDBjZjc2OTQ3Li40YzYxZmMzM2Y3NjQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vdm14L3NneC5jDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3NneC5jDQo+ID4g
PiBAQCAtMjI1LDggKzIyNSw4IEBAIHN0YXRpYyBpbnQgaGFuZGxlX2VuY2xzX2VjcmVhdGUoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiA+ID4gIAlzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiBleDsNCj4g
PiA+ICAJaW50IHI7DQo+ID4gPiAgDQo+ID4gPiAtCWlmIChzZ3hfZ2V0X2VuY2xzX2d2YSh2Y3B1
LCBrdm1fcmJ4X3JlYWQodmNwdSksIDMyLCAzMiwgJnBhZ2VpbmZvX2d2YSkgfHwNCj4gPiA+IC0J
ICAgIHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9yY3hfcmVhZCh2Y3B1KSwgNDA5NiwgNDA5
NiwgJnNlY3NfZ3ZhKSkNCj4gPiA+ICsJaWYgKHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9y
ZWdpc3Rlcl9yZWFkKHZjcHUsIFZDUFVfUkVHU19SQlgpLCAzMiwgMzIsICZwYWdlaW5mb19ndmEp
IHx8DQo+ID4gPiArCSAgICBzZ3hfZ2V0X2VuY2xzX2d2YSh2Y3B1LCBrdm1fcmVnaXN0ZXJfcmVh
ZCh2Y3B1LCBWQ1BVX1JFR1NfUkNYKSwgNDA5NiwgNDA5NiwgJnNlY3NfZ3ZhKSkNCj4gPiA+ICAJ
CXJldHVybiAxOw0KPiA+ID4gIA0KPiA+ID4gIAkvKg0KPiA+ID4gQEAgLTMwMiw5ICszMDIsOSBA
QCBzdGF0aWMgaW50IGhhbmRsZV9lbmNsc19laW5pdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+
ID4gPiAgCWdwYV90IHNpZ19ncGEsIHNlY3NfZ3BhLCB0b2tlbl9ncGE7DQo+ID4gPiAgCWludCBy
ZXQsIHRyYXBucjsNCj4gPiA+ICANCj4gPiA+IC0JaWYgKHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUs
IGt2bV9yYnhfcmVhZCh2Y3B1KSwgMTgwOCwgNDA5NiwgJnNpZ19ndmEpIHx8DQo+ID4gPiAtCSAg
ICBzZ3hfZ2V0X2VuY2xzX2d2YSh2Y3B1LCBrdm1fcmN4X3JlYWQodmNwdSksIDQwOTYsIDQwOTYs
ICZzZWNzX2d2YSkgfHwNCj4gPiA+IC0JICAgIHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9y
ZHhfcmVhZCh2Y3B1KSwgMzA0LCA1MTIsICZ0b2tlbl9ndmEpKQ0KPiA+ID4gKwlpZiAoc2d4X2dl
dF9lbmNsc19ndmEodmNwdSwga3ZtX3JlZ2lzdGVyX3JlYWQodmNwdSwgVkNQVV9SRUdTX1JCWCks
IDE4MDgsIDQwOTYsICZzaWdfZ3ZhKSB8fA0KPiA+ID4gKwkgICAgc2d4X2dldF9lbmNsc19ndmEo
dmNwdSwga3ZtX3JlZ2lzdGVyX3JlYWQodmNwdSwgVkNQVV9SRUdTX1JDWCksIDQwOTYsIDQwOTYs
ICZzZWNzX2d2YSkgfHwNCj4gPiA+ICsJICAgIHNneF9nZXRfZW5jbHNfZ3ZhKHZjcHUsIGt2bV9y
ZWdpc3Rlcl9yZWFkKHZjcHUsIFZDUFVfUkVHU19SRFgpLCAzMDQsIDUxMiwgJnRva2VuX2d2YSkp
DQo+ID4gPiAgCQlyZXR1cm4gMTsNCj4gPiA+IA0KPiA+IA0KPiA+IElzIHRoZXJlIGFueSBjYXNl
IHdoZXJlIGJpdHMgNjM6MzIgY2FuIGhhdmUgbm9uLXplcm8gdmFsdWU/DQo+IA0KPiBZZXMsIEdQ
UiB2YWx1ZXMgYXJlbid0IG1vZGlmaWVkIG9uIHRyYW5zaXRpb25zIHRvL2Zyb20gNjQtYml0IG1v
ZGUuICBFLmcuIGlmDQo+IHNvZnR3YXJlIGxvYWRzIDY0LWJpdCB2YWx1ZXMgaW4gNjQtYml0IG1v
ZGUsIHVuZGVyIHRoZSBob29kIHRob3NlIHZhbHVlcyB3aWxsDQo+IHN0aWxsIGJlIHRoZXJlIHdo
aWxlIHRoZSBDUFUgaXMgaW4gMzItYml0L2NvbXBhdCBtb2RlLg0KPiANCj4gV2VsbCwgdGhhdCdz
IG5vdCBzdHJpY3RseSB0cnVlLCBwZXIgdGhlIFNETS4gIFZhbHVlcyBhcmUgb25seSBwcmVzZXZl
cmQgZm9yIFI4LVIxNQ0KPiBvbiBjb21wYXQ8PT42NC1iaXQgdHJhbnNpdGlvbnM6DQo+IA0KPiAg
IFJlZ2lzdGVycyBvbmx5IGF2YWlsYWJsZSBpbiA2NC1iaXQgbW9kZSAoUjgtUjE1IGFuZCBYTU04
LVhNTTE1KSBhcmUgcHJlc2VydmVkDQo+ICAgYWNyb3NzIHRyYW5zaXRpb25zIGZyb20gNjQtYml0
IG1vZGUgaW50byBjb21wYXRpYmlsaXR5IG1vZGUgdGhlbiBiYWNrIGludG8NCj4gICA2NC1iaXQg
bW9kZS4gSG93ZXZlciwgdmFsdWVzIG9mIFI4LVIxNSBhbmQgWE1NOC1YTU0xNSBhcmUgdW5kZS0g
ZmluZWQgYWZ0ZXINCj4gICB0cmFuc2l0aW9ucyBmcm9tIDY0LWJpdCBtb2RlIHRocm91Z2ggY29t
cGF0aWJpbGl0eSBtb2RlIHRvIGxlZ2FjeSBvciByZWFsIG1vZGUNCj4gICBhbmQgdGhlbiBiYWNr
IHRocm91Z2ggY29tcGF0aWJpbGl0eSBtb2RlIHRvIDY0LWJpdCBtb2RlLg0KPiANCj4gQW5kICJs
ZWdhY3kiIEdQUnMgYXJlIG5ldmVyIHByZXNlcnZlZDoNCj4gDQo+ICAgQmVjYXVzZSB0aGUgdXBw
ZXIgMzIgYml0cyBvZiA2NC1iaXQgZ2VuZXJhbC1wdXJwb3NlIHJlZ2lzdGVycyBhcmUgdW5kZWZp
bmVkIGluDQo+ICAgMzItYml0IG1vZGVzLCB0aGUgdXBwZXIgMzIgYml0cyBvZiBhbnkgZ2VuZXJh
bC1wdXJwb3NlIHJlZ2lzdGVyIGFyZSBub3QgcHJlc2VydmVkDQo+ICAgd2hlbiBzd2l0Y2hpbmcg
ZnJvbSA2NC1iaXQgbW9kZSB0byBhIDMyLWJpdCBtb2RlICh0byBwcm90ZWN0ZWQgbW9kZSBvcg0K
PiAgIGNvbXBhdGliaWxpdHkgbW9kZSkuIFNvZnR3YXJlIG11c3Qgbm90IGRlcGVuZCBvbiB0aGVz
ZSBiaXRzIHRvIG1haW50YWluIGEgdmFsdWUNCj4gICBhZnRlciBhIDY0LWJpdCB0byAzMi1iaXQg
bW9kZSBzd2l0Y2guDQoNClllcy4gIEkgZ290IHRoZSBzYW1lIGZyb20gdGhlIFNETS4NCg0KPiAN
Cj4gQnV0IElJUkMsIHRoYXQncyAianVzdCIgdGhlIGFyY2hpdGVjdHVyYWwgYmVoYXZpb3IuICBI
YXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMgbWF5DQo+IGNob29zZSB0byBwcmVzZXJ2ZSB2YWx1ZXMu
DQoNClRoYXQgc2VlbXMgdG8gYmUgYSB2aW9sYXRpb24gdG8gYSAiYmFzaWMiIGFyY2hpdGVjdHVy
ZSA6LSkNCg0KPiANCj4gPiBJZiB2Q1BVIGlzIGluIDMyLWJpdCBtb2RlIHRoZW4gaXQgc2hvdWxk
IG5vdCBiZSBhYmxlIHRvIGFjY2VzcyA2NC1iaXQgR1BSPw0KPiANCj4gWWVzIGFuZCBuby4gIE1v
c3RseSBuby4gIEFyY2hpdGVjdHVyYWxseSwgdGhleSdyZSBhbGwgb2ZmIGxpbWl0cy4gIEJ1dCwg
YWdhaW4NCj4gZ29pbmcgZnJvbSBtZW1vcnkgdGhhdCdzIH4xNSB5ZWFycyBvbGQgYXQgdGhpcyBw
b2ludCwgSUlSQyB0aGUgYmVoYXZpb3IgaXMgdGhhdA0KPiB3cml0ZXMgaW4gMzItYml0IG1vZGVz
IHplcm8gYml0cyA2MzozMiwgc2FtZSBhcyAzMi1iaXQgd3JpdGVzIGluIDY0LWJpdCBtb2RlLg0K
PiANCj4gVGFrZSBhbGwgb2YgbXkgbWVtb3J5IHdpdGggYSBodWdlIGdyYWluIG9mIHNhbHQsIGl0
J3MgdmVyeSBwb3NzaWJsZSBJJ20NCj4gbWlzLXJlbWVtYmVyaW5nIGhhbGx3YXkgZGlzY3Vzc2lv
bnMgZnJvbSBhIGxvbmcgdGltZSBhZ28uDQoNCkkgdGVuZCB0byB0aGluayBpdCdzIGJleW9uZCB0
aGUgcG9pbnQgd2UgbmVlZCB0byB3b3JyeSBhYm91dC4gIEl0IHNob3VsZG4ndA0KaGFwcGVuIGV2
ZW4gdGhlIGd1ZXN0IGlzIGJ1Z2d5IG9yIG1hbGljaW91cyBBRkFJQ1QsIHVubGVzcyBLVk0gc29t
ZWhvdw0KbWVzc2VzIHRoaW5ncyB1cCBpdHNlbGYsIGluIHdoaWNoIGNhc2UgYSBXQVJOKCkgaXMg
bW9yZSByZWFzb25hYmxlIEkNCnN1cHBvc2UuDQoNClRoaXMgYWxzbyBtYWRlIG1lIGxvb2sgaW50
byB3aGV0aGVyIGhvdyBWTUVOVEVSIGhhbmRsZXMgR1BScyB3aGVuIHZDUFUgaXMNCm5vdCBpbiA2
NC1iaXQgbW9kZS4gIEkgc2VlIG5vdGhpbmcgZGVzY3JpYmVkIGluIHRoZSBTRE0gZXhjZXB0IFZN
RU5UUlkNCmNoZWNrcyAiZ3Vlc3QncyIgUklQIGFuZCBSRkxBR1MuICBNYXliZSBLVk0gc2hvdWxk
IGV4cGxpY2l0bHkgY2xlYXIgaGlnaA0KYml0cyBvZiBHUFJzIHdoZW4gZ29pbmcgYmFjayB0byBj
b21wYXRpYmxlIG1vZGUgZnJvbSA2NC1iaXQgbW9kZSwgb3IgbWF5YmUNCmhhcmR3YXJlIGRvZXMg
aXQ/DQo=

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1322CBD9;
	Mon, 15 Jun 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491737; cv=fail; b=syTs0YWb9eXpOmoa4PLhU7NMtwDXevxrQBqp3VMV1Hhp5aqwbBWlEKMWQrhzoTr3wL9j6bGweS5KXFGf/3NkR2YZSW32BPp+mckdOSQQkVAKS52ETsct4raRka7YlFR86SkvYUJfsPfyZINuxtT0eI7yG5wn3+C7NUHgzKKXJ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491737; c=relaxed/simple;
	bh=SYa3f3Xh3cO33lo/TzWN5Kbrc/HvUD3YQPteOc8E1fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIfsbjToSSR875Un9qq5j2cofPNCSL6Cbo7KPN1UgeHPrtfeO1rYOekZkIoXh3Dzt3oTHBOxqFiHXSfEf+qSVznPjGF3ldE8t0ZN2d8NdoMDAdy0RBej4gnhdKZD1vVLvUrqQptzlIzJsUSdnA0m+Uq2yxMRMslmf8Fm68k13jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGXDSLdt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGXDSLdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781491736; x=1813027736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SYa3f3Xh3cO33lo/TzWN5Kbrc/HvUD3YQPteOc8E1fg=;
  b=QGXDSLdt5u3FLlxfemn9yVLFogxZ0kGY9AuX9qU4eD2ju5snSSaaI9md
   ASHA0LVixs9Qc95OD6JIGSsY+cKWZKNtRgUlD06troWb0xznL7IsxmMx6
   l34/WjYEykOYkhg+HnJrTuEKesUcgV/rvuDOnCo7zoX3OG7nBBaBLyyNH
   oU2PJUeG0Q2x8XHIMqvQ1w7YtehAPZeaiWV/wev1f07f09FjbQ3XTFzJb
   btlI24Ea8wpKy5C+lDamrOEdnhvbavQIEhIFCQhwHKIm6DGqtPhevBM8i
   SBDI+IuCsjn1Zsmp+YQYP6hPC5Tn8U2bD592BzqAwKyQrm0YB6ijKZps/
   w==;
X-CSE-ConnectionGUID: MCR9Co9KRmGaQr0Fdryf0g==
X-CSE-MsgGUID: HAr96tYaQCKtidTy6WtPaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93718067"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="93718067"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:48:56 -0700
X-CSE-ConnectionGUID: NUDMqwf+SRqqjsTGJJQogA==
X-CSE-MsgGUID: 1UGj6BuITvKOFatIBOBJ3g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:48:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:48:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:48:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:48:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALbAnPLzklpwpZonsWccLHQfhggwV+9VcOrxXU62d9JNNYuYiRNdxdMnCR0LWh8m+7nDS4y7XRKemE6rPDUKfwlOLmDoqgkkRlrzws/yowIEUJppsw8M/FzIZBJGsahyHmwmipR4dsotZ5VoAFywPQZfhFkz45koyiWGMSFc+CQegT8m7qJ4j3LCLsIVMUmSgF01k0mXbRCP0zMbQjWKjrJOxWI5CD/ZLXm7tp0cK2yHxpeImtky0oGIPRWGXlfWl+R3uevNMFgWn49Nf9wRxKwQvbU2jCYO0Fnt6pfgK4r7ZlXn7NxPLUh/sBY+iJ1OKIb1goDWnZJLY/SMYY4R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYa3f3Xh3cO33lo/TzWN5Kbrc/HvUD3YQPteOc8E1fg=;
 b=yXMBzr4XHrN2YM26a4KwOG13kVoHgANR1xIYdFikpm1Jvj2DoM0qOGeKrcdH2cvTpH1dEgqkJcRlzpUYLn48X4Pb6RXFpPgj8YrOEdnONb2X+e/PVqlJ7UsWfBILSAh0TZIwEyduozo+sUEcsqT0lD+aFfxIiCMgWV0MOyaGw33VYsN4wTV1+ykQ96CmDVCnVzCWsD+VRR1jorsfr+6Lh8VzmBEGIolIgCMwpgKgqqY9Mx9PFSIeGjX0puVu7wBXZlha5gaDLS3fhreU/63bRmR8TB9aWoO0VFLg00q3KTObEIDdMidMDZbFHFzO+rKwCgqOxfmSV4WkfGvRzTChyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 02:48:48 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:48:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 19/30] KVM: x86/pmu: Move "struct
 kvm_x86_pmu_event_filter" definition to pmu.c
Thread-Topic: [PATCH v4 19/30] KVM: x86/pmu: Move "struct
 kvm_x86_pmu_event_filter" definition to pmu.c
Thread-Index: AQHc+sgqkLqVHHPgZESvqI2Qwf2t27Y+7WgA
Date: Mon, 15 Jun 2026 02:48:48 +0000
Message-ID: <3f8b7d8a9ebaf16ef2efb38af3dbe98f5dd37d29.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-20-seanjc@google.com>
In-Reply-To: <20260613000329.732085-20-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SABPR11MB9937:EE_
x-ms-office365-filtering-correlation-id: ac8dcd59-a427-4f7f-d00b-08deca88a021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: jgPibrH/mlHaF6kLhJtzz2JLaMxgPQsGpbGhKZr6GfvMRjAvAO+B2dWA2Er6Lk1nEZcn8Nu6QZ6UZgYWvg4D6y3/8eZ8gJv1DA6qMX+LTxZvVzoSIPcT0J5iGkf+hrhodmRKqOflRgHp9lzq/B8/P5GSUqc6iYukrvsNCAT6JU69rTf+Vo7vpqmNUtiR8NVlm/qubOcMS8OX0pTYUDSQVIPR+39QCcXvGUiwFheK3t+X5vatu34MGMcGrcOrMdJ/EfARG1g2r/nEf0ojAbtO33zj+q/UsiLK+GR5DCUmb978weDOdrJhMYVJOY5MG9UAtl4e2mFL4vl9MT9Np2m9WrRV4OYMC+MZ5SaVJEZLE4vdOqvaR2v20UDXuic4/3O0ze1diOU3ju8oMAOsnRH4/rU3IvTO6sJO2DqyfMidRtmSwcv9p4DGFD19oXN8V9jq2q2JVKHeNGZAMPhsmwXTdjZ4xTBTRyG+hoJ5WFT8pvst656z1jd1wq3s96++PQk83396rjoMiYvfQo8lrf/xfbQ5yF7K651psD0nATJExuCFmz31/USoBt9wPUAfy1KEgeDzsXUQruO0ozWiXLq3gp2jxObwf8zFDjmDyedG6altE6mbBP6yTyBN5zgAVbC2B4Jr7CfUnMlj/EG7P3W94SVwQbtYcR1NGS73ZRzSDdF5zk+xGrFZb4eRUvNqAer+r8GmhTLul4IBK4EBp2vRYP1vckYlffq4jDF/DfmI/OP0x+p+70G538Yof8Q6pfyN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWUvYzhjSlhEWTRhQm5mdlVxZjVrbGNoL2RjWG9EUW9JWXRqSHhjaGhLeW9P?=
 =?utf-8?B?NXR0d1VUbUo3bEVuWmEyVkQ4a21aVjhOOXhKZkRmYVV3RWo3Yi9laEd0VE0r?=
 =?utf-8?B?ZWRZQ01ONm03dnRxaGh1SVJvNUtleWh3SWtlelJCRjE2MllXWDM5Q0FuQm1S?=
 =?utf-8?B?UlEyUnQ1SkZFdmFpZ2NoVHc2Vm1UbG9BM3ZxMDRKb01iaklmQlhJMUtuQTdW?=
 =?utf-8?B?aUh4L2pPMDNHWlRGYUw5RnFBOFVpQ09ROWxRTzdMdWl4b3V1ZllucjFwaG9G?=
 =?utf-8?B?VEJ4S2R6N2RxeFB1Q3J4QVpPZHZaR0FNU3NzUGZvcjR0djdvMzVNcGV2aHQ1?=
 =?utf-8?B?R0RRZi9CUTNGTEFETlZ4ajZpTmJKU0xzRTNPeWszSGZQYVFiYmMwYU92Rk81?=
 =?utf-8?B?UW1HUXNQcGI1VEkwNW5YR1doaFZ0UHZGRTBvRWlnOTV0K045blBhNHZITjdG?=
 =?utf-8?B?alBuSDlNZTFKYkFLSFRJZ1FjVTEyVGl4OHZzTVlFYUhLaVNPNFJLWmVTSjhx?=
 =?utf-8?B?Wjg0NEM4c0p4UmRQUHJhbkxiSzVobU1vMnRjYnRUcHhNaHlXMlNvKzYzQmFE?=
 =?utf-8?B?VGxwbmJMUlZ6WE5FdWJpYzk4VHBRVXRFQ0xxOGVWZXZsanE2Z242cnc5RW94?=
 =?utf-8?B?cWVmZnJsa1YybnFpUGdwMmJNam5JQ3VreUlWeWc0RjZBM2xvUVl4dElKL04v?=
 =?utf-8?B?eFc4V3BzaEVwNlc0Zm9KRUJwVlliYm9JN1lybVAyalhkcnRpZXFHN0FmSkRW?=
 =?utf-8?B?azlPK0VmUFlnZDAxQTZjazlIeDZ1amc3ay9yQ3FzeDRYZHlzQlV0WE1RZWxz?=
 =?utf-8?B?TVNzSHYxV0x1WXJaZGlLcWIyeEdKK2h3SHpXKzVhc1ovQzlmcnNIbkhaaERs?=
 =?utf-8?B?ekVPQ3lKcnkrNE5DMnVrM1h6WFFsTFhBbUF6RHROUklaTnBUUHdnam45ZTAr?=
 =?utf-8?B?eTZUN1dkTWhqQWs2UWdQWlZscFlRRFh6T2ZNbU5qYXF1Y1hRdThYVWZFMFFu?=
 =?utf-8?B?Y3JUeXkxR2swNDJmS3hrc1MyODlmWmtSckppdXR1QmdUYjRRQjdLeVJRNGM1?=
 =?utf-8?B?a0hnNlhQMTR6NzZvZjdPQ250NHhXeTM1VGo4aEZnQW80Qm5TWitlMFArS1ll?=
 =?utf-8?B?TUR3ZEo4bWY1TUd1NXpYbjFNdEhRaXJhUm5SajZmcXAwdjJYTXFreDNtNGlm?=
 =?utf-8?B?UU1vYmN5bHAxN1o0ZGhxbDR2TGsySEV5V2oyaGkwaXBPUlJqL2tNbzhmUGRy?=
 =?utf-8?B?cVBjQzloRTBuMDB2NzJUalhIRFA5QWRzOVVETWN3NWFSS3hrQ1VzS3ZHUUpP?=
 =?utf-8?B?YXhyNDkrTk51SnJVYTBDbnBpKzN1NGVwSk4wc3ZpRCtGa1JtemZTYVhXQ2Z1?=
 =?utf-8?B?L0NHTTFhcUxSNUxndjhqYkZ5VzBMdmhEc01JZUc5cFE3b3dNcDFOWncxYkJl?=
 =?utf-8?B?aXRzZEc4NWtzY1ZoWWc5L3BiQXUxb0xLZkVpNWxySlNyYmlnUmEyb3RwV3NT?=
 =?utf-8?B?NCtheGFheXNjcUZwSDhpa2ZkK3JjcHhlWmZ2Ry9XLzVZRXFvYzZlNkMvcmdC?=
 =?utf-8?B?dXJCK21lR1ZXRzBxd29ZMnVnRGgzK1RvSFFjRWFRVzRqbFpLZ05LeENHd0U3?=
 =?utf-8?B?MTRWMVQvaTFTdUVjbk5LcURQR1pGUVNkQWtRU0ZDMGhVaFpscVJ0VWxIQ3dt?=
 =?utf-8?B?Qk1RUlJPRFNOSzZyVlF4Y2tDSW9rZXhvU0hNWlR1YmgrUi9UYXF2VkUwdk1h?=
 =?utf-8?B?OWNDakt5dENZWmxLTkh2TFV1OW9mVG1MeFBUYmpRa1Nndi9pbS9aRGozMDBD?=
 =?utf-8?B?enkyTHdOQkVoUHpQbkh0RkExMU81aitZeE5lcXdjYzlFdUFCQUJ5VkRjTjVB?=
 =?utf-8?B?cGIxc2V0aXdWVmJ3R1htU2lncEJ5NUxCQ1crOXFzU3NVeGtWQmJzTFZncU1P?=
 =?utf-8?B?QXc3U0pPSWovdW9rVUJ2ZjNNc09xZUJXZ0s5dlpPb0NmT1A4dGlyNlFWalVt?=
 =?utf-8?B?eXJiSzZ5TE9kYVhnN3FaMDhNeHdaVU9EZi9ucWVpQU5VTGNKR0g4UHdjdXhB?=
 =?utf-8?B?QmdhU2p4LzF5UzQrcU52anFSZDF2TWZ4d3VNOEY5RnNrRjViTXR4cFlsN2ky?=
 =?utf-8?B?YUVvS05FRWFoL3VuOFdoZmtCNElBTHFmWlQxWWVkb1NVb3pQRjljeXlKbzhY?=
 =?utf-8?B?MDUzUHk0UnZFcTJPUmlyTEk0Q2VjSlBVTm5DblFnM0RaWERjVnl1YkZzYVJo?=
 =?utf-8?B?L29nVkxOYlJoVjQvWGdacXQ4dTBLZmRzU0Vucmw5QkxiTlNVWStWVFVEb2pq?=
 =?utf-8?B?NDl3V1pWQmE3ajEzem1COU5obG1IcXRENHl6R0NySURGeG43MDZuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <045A7D4F923B3E4A8D49F8B19AAB0E2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IM8e17/jU6UiLizCzf+XIMwCdy9HJEeJ/4DEgKwjZwac3IgK0EdOx5kNG2vS43fuq9n6J1/wSyH5J9LvYLO/c+LQaFEC5k6z4Y4PQ/jCVhgZCiZlR14YxhkSelsJl4JK344CTWAUz5mVT/uq4RriTPzxRwq8mNPLiQP7TY3x0RtoWw+g7kUJRepl0gimzKbnGubUvEhv/8AywDqbYIka+XmLbTiXBP4ZpwsRIqnDemcn58Ty3waaNhy9QS2cG4xPxNb0k9327mdivPfGzlEt4T9Q3xuilrPTbSU0F0X+b4ttJjaYWK+wvpekNJnO1mNpiEQ69x1UDAWbucMGTQPXiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8dcd59-a427-4f7f-d00b-08deca88a021
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:48:48.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kq4mwc6+OIOwxB+PvvmQbBtOI8nGOXF/cY35a30nKiIuxBeauPQanhqx89nPAN3KB0lytJXg7/uq4EekaxActg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBkZWZpbml0aW9uIG9mICJzdHJ1Y3Qga3ZtX3g4Nl9wbXVfZXZlbnRf
ZmlsdGVyIiB0byBwbXUuYywgYXMgdGhlDQo+IGFzIHRoZSBkZXRhaWxzIG9mIHRoZSBmaWx0ZXJz
IGFyZSB2ZXJ5IG11Y2ggaW1wbGVtZW50YXRpb24gZGV0YWlscyB0aGF0IGNhbg0KPiBhbmQgc2hv
dWxkIGJlIGJ1cmllZCBpbiBwbXUuYy4gIFdoaWxlIHRoZSBfZXhpc3RlbmNlXyBvZiBmaWx0ZXJz
IGlzIHB1YmxpYw0KPiBrbm93bGVkZ2UsIGFsbW9zdCBieSBkZWZpbml0aW9uLCB0aGUgY29udGVu
dHMgZG9uJ3QgbmVlZCB0byBiZSBleHBvc2VkDQo+IG91dHNpZGUgb2YgdGhlIFBNVSBjb2RlIGFz
IHRoZSBmaWx0ZXIgZGF0YSBpcyBwcm92aWRlZCBieSB1c2Vyc3BhY2UsIGkuZS4NCj4gaXQgcHJl
dHR5IG11Y2ggaGFzIHRvIGJlIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCwgYW5kIHRodXMgbmV2ZXIg
c2hvdWxkIGJlDQo+IGZ1bGx5IGVtYmVkZGVkIGluIGEgZ2xvYmFsbHkgdmlzaWJsZSBzdHJ1Y3R1
cmUuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZA0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNClJldmlld2Vk
LWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

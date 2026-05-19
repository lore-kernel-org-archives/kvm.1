Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E62F7F06;
	Tue, 19 May 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155955; cv=fail; b=Lw8Y8bV/Kl6Z032TCyPfZU40vqHSDr0IgqKOdTk9Jh2FKxejx3zmhNX3Zs35dRgI77N3hstzOVtcDaOB9/ZKkJS9pNgZMmgRkjhDqlGh2gn0NWxaLI94iPt6fKrgqCMG9kJEykebQfM2lhfvVpTGpV/fxvFa3/tl7s3rKWtVUy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155955; c=relaxed/simple;
	bh=oRg29bbjhDGHUJ6MZmg2kE9nwmFet4wGOqin7yiC9qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DuGBVUpIz0dDj7yvwXakEasqyIlEUcndAfemhOkixLNAtiLFs6w9mnOsFGtPO5d88RWcD8XprkFjOTgzwbC4QjIWzHKylHMILPwX1kuQtDrBdCIHWDgxKpmBEGYFpZFDAlB4xOuBFBPgbDIb8BtKRWcu2HS/rxbHYJi5q1JkVs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2M4rtvn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2M4rtvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779155953; x=1810691953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oRg29bbjhDGHUJ6MZmg2kE9nwmFet4wGOqin7yiC9qc=;
  b=f2M4rtvnmm7ApAv0QbjwjSGgOmuQf8VybLHEC1bzqLRKOpdkDUMAsxW8
   yXN8g/YF1VGjCNl2+Hoqc4DxLiKttMF203m71RzOc/Rv3EcV/zmELCa7L
   FYsKlZDS+kjUt7Q1cFVsT7I96JjyjU7b53oZV/HqlT0l0ulfLcHJTt7My
   6jZQEWjeozAzGEtUogMhiZg8htJtW5KlVmgWWWiNfgZQkm+RBtXSJS8N3
   /7UEbnjSeF2tz7CYV0+NJJEiowubsLGU36EXk+Kpi8+e+V7ySpa92Gkk+
   jSL/5N1ZpceLwWLy5FJsWflq35axhUieZHEi6BZs/j2b8r/IpPakuyZvF
   w==;
X-CSE-ConnectionGUID: ibTTxfaXRReXIjeldLH38Q==
X-CSE-MsgGUID: +qMxcZQrRfuFPKgY446soA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97591440"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97591440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 18:59:12 -0700
X-CSE-ConnectionGUID: jH7AwmSKTIOeIW7Zdsa7jA==
X-CSE-MsgGUID: IVWQNIfoSVKw3Q+nljvo6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244606782"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 18:59:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 18:59:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 18:59:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 18:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAzwkO2m7bOa9XJewiIqTg+A/mkwIhP6iDIYFl2F/GiTd1SScLqPG45UoCl5VswXDTHYJHFNS1CPFRgPCKuHAZkaHrni5bO0DWOI7Tkp6o716Bzvnf3lvsmOdh4f7Jfskq8YdMhKgL87RxgCIySZ5Hz6XeHtUx/MgIVLA156YKRZ8rsYyerCV/HwaAldpWntXR3kUasNQha0R07I0mDf/6RYo6Ts9v/wF89Q77trfJqK52WW8iErPsi8+t6BwwrI1Vlz6LeuA8Wt+LI2Oka1D5kWYGDvvdmuBUK63t7HSIYew/6SNoqNtt4JMxPYyF6akCHwxz6SghzG/0AtN65FHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRg29bbjhDGHUJ6MZmg2kE9nwmFet4wGOqin7yiC9qc=;
 b=WiGabF1/cJimU2JBmmyv3s/flTApBmTDb9XF4Y74eT+UTsGfsruaUW9WOpVUXA08ZKAPAxHgdBBk3OpKdig9DKLa9gmIcztvijZMjzoHZRRQ4Dx+0+kgg/Wq8kyhTjUisvRW8WfuEFd5xrc8ueW4/gE8/Vh8VaV5KCP4xwyKoEgn/38o3smQB2CdaFWn2hXjYwz7jwUR89QX6XAMvgSTsL4qHaBBYElQmv4y1MbilPTAjvSszYsYAa045DNWYjOe7hvyNgBXEx/YkA6O39AAmUr5muYZP8HJzhME0MJLn+Xg1PBWFID0jPTMUtljSci44+TpWzP+wRji3WDW9WZgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 01:59:02 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 01:59:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Shahar, Sagi"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Thread-Topic: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Thread-Index: AQHc4urTVkFyyS3v70qCqCVz/hQDRLYPRleAgAQqdACAAJg5AIAAl0cA
Date: Tue, 19 May 2026 01:59:02 +0000
Message-ID: <60dfac5273fa3bd5b5d31dbe6b8f32a60d329a78.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-3-chao.gao@intel.com>
	 <c7d64460-d03c-4198-9320-8afceafcecb5@intel.com>
	 <agrFTv8Lr3HeNM6P@intel.com>
	 <68e91c7ae1d10bdff73dd178d0e4ee48eaf1cfe1.camel@intel.com>
In-Reply-To: <68e91c7ae1d10bdff73dd178d0e4ee48eaf1cfe1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CO1PR11MB5027:EE_
x-ms-office365-filtering-correlation-id: 963be393-73b7-4d5b-e90a-08deb54a3356
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799003|4143699003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: V7EtTTLHthXR8jbPJLHZ5BvTTVd1HrlFFkwo/SG06vbEZbr0hywL01L7V051DoYuG8TcJFjdzJgl/k20V8/RljpUGnDy3ZAl9zYuup8/5OM2IDFqIK18klqa/zVUe7deVwpYI80+kzXje+9A2KxOcD7PyauFX6aTn4rEs5xsO8giKJd2H/qawh1QJD2yhhtyC5mCMip1t0tDEOcQa4XVDZRbOtjSIqvu8R44KkxhQF6UaUAPKKd/8XWDJgtINJUsl79REOlwe4/bP2BsedOOeUZB4ceoTyIPeYVnl4ISTQt5fT7PPg4ronNzQnzLc2nEDYmwquwyDqEh1wKf4h7Egumb6yVUTwJZW7EkSNXQAO8Vet4iKcUs7uBSs6qElLgbkjOJzoM2pp5lvXpcClIeC2ZjDN7/RjOhfD5n1m1UB6o+gK4e0W9weR2FOSNorScjRozfeWwph2w2A/OZqPHT57I3FS2b5gA21gQjdL+mGBKPfWgysugCAA3lakA+F1RDmVsXTuAiVeJeUjw0nnHbE3aUY1rYBHSubB3zPK7rzpQTrgzMi/Mt2TX68BmI8laEY7MjQAx/vssJtoIoYRuzlzQqCm87uFk+DyeZb0E1S9OqOFUbMmcP/2NuIbA3ThX21YkEahdAK/EA40KTSJLaxwENH54k5uhhAttdiOqmlsjgjKrJBE9mHLYvR5aWiOqQu2NUQjUStevlxg/FXiNRjUBoSaQvVWO+79n3cBHn0nTxNBl0d11JntvBBE5xMvKu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERXVGNZWUlrU1UwRDVQdmJzbk1aVjZOaW9uNWIyUTJqU3hxVGx2RnQzblUw?=
 =?utf-8?B?TE0zMnRsVmdiWlE5VloxL3JhdEV4UDNnanhjdkh4bll6YVY1U3NoVE4vLzNs?=
 =?utf-8?B?cW81MmFCQzdpbE44R1dxTUkrSmIyekF5VHhoMEQvZmdsdEQ4NEJtcUNQa1pz?=
 =?utf-8?B?bWJCL3NaRWdXV3VISjVVQkR2NE1VTUkvQmJZSFZacHU0TytiRVV5SzZmQmZZ?=
 =?utf-8?B?RVdwYmpZeDJBSG1MOURaUEVwZG9WZWpYb2JyeEpYNEtwaVZBRENnajdLVHFV?=
 =?utf-8?B?TFYxcnNobStLcEMveC85czdPUkZFeHloNmhPK1FZbWd6eUwzQkdNc1B5R1cv?=
 =?utf-8?B?L1VrVENLZGZCTXQ1Q2VwejhCcjFOdnNRL2lscUFhUlB5NkhGY2hvZloxWEJx?=
 =?utf-8?B?Y3NLRzNwVkY4cU4yNUdkVGtuSkpITk5Wam1jdm5kbGFHeXVUT250ZE9mNlRD?=
 =?utf-8?B?UTdSMElCOFpGZ1V5OEFPcmFFcVVJN3B4K3lGeTRoVEtmd0Fyd2gvWWJCcUpZ?=
 =?utf-8?B?YW1URW15TGxUTldmc0pIWlNHZldEUUNnaC9ZdzBuZjNYaTB5MEhJemNzVUlP?=
 =?utf-8?B?MUV3VDZjUHhRZHVPZy9Nc2FlcU80cHNXN0kvVmN0eWJvRUl6V0w3Slp6aHp0?=
 =?utf-8?B?ci9iaXAya3FGejNNWXZRV0lMNzFBT0ppUlpaZnhpby8ydEdJb3VrQkE1MEJs?=
 =?utf-8?B?TXBoWGw4VmhlSGRQL25zYk96Zi8xVFFob0R0aVZGdnRnenRRdnRPMTRoTWNu?=
 =?utf-8?B?RmNIMW4zVW5xREZydmwwcnA1a0VNTkpHTUYzMko0ZkJEZm9XeVdPbFdVSElT?=
 =?utf-8?B?M21RK1A4TElscnhDOEdaVHlSUEpQbFhWOVpmS2gxazY2MWJkQm9ZcjVtb2dY?=
 =?utf-8?B?UG1hQjBkZnZCK0JSMHVPdU12TjBmb1o0RzV4Ui9IWjV6TWhnRVdxdm4xZkVw?=
 =?utf-8?B?TUEwUnh1KzUwdHJDL3RXMmkraDJqb3o0NHFrV3I5K29IUXpCOFVRcEpRTWhR?=
 =?utf-8?B?c2VXRHEyUTJsWWFZRnJBbVlRbTdlS2ZTT2RPaTcwTE41d3JEUU5BYWNJc240?=
 =?utf-8?B?U2xuUHZoSjF1Q3NaenZCUXpTWCtGZFlITUFmait2Qk9PeUk1bXZHbTdHbnJG?=
 =?utf-8?B?YXlvdlZWVEI0S2VPUEx5ckh5NGt1QSsxcEVHd21zSzBjZmt4TzJ2aktFWWdK?=
 =?utf-8?B?TFNnYXhTMGN0WVVzZFpzR2FRLzJPTkV4cFRSZE83YXRoOG1MM3pHNW1uZzRN?=
 =?utf-8?B?dzFRMFBMbFlZU2RKRGVRdlczb2xtYjg4YW1EUkxqcWFZT2phZ0xrNFIvaE9a?=
 =?utf-8?B?OXZELzZnL1VjdHphaUp1SWNQTStoYzhmVkxrRGN0YVdiSkJ5ZmpCT0NTYUtj?=
 =?utf-8?B?N0NHbUNZbHJzZjJlSlF2MlRGRzBiK2VMK1N2ZUZMZWJJT2VyYlQrUnRRbTZt?=
 =?utf-8?B?T0ptZisvaTJ1VE5zdUwwN0xwTXNVQS9sN0VJZmdDdDcxTnpCdGtvUFRvZ1ZF?=
 =?utf-8?B?a1M0V1A0eCtEZWtmM3pSTXNIZDdXWVByZ2UvemxFYXRJNjFGSlNQcEd4WkMv?=
 =?utf-8?B?V2NBcHdCOEkvQzRYTHh0dm5YSnN3Vi9KWjNYemdteDlkR3pzUldRT3hMUGJo?=
 =?utf-8?B?ajBmd2I2aUxyZjJyN0swY0NRdnkrWkZkSUViK3NTamlYemxqQjVQbnNaakE5?=
 =?utf-8?B?NUhHcFF1eklJVlhaQ0tZRFBGdUhENHhwZHJ6MUl5UlhMSC9STVV3ZTdzdWhh?=
 =?utf-8?B?RE4rWUp4M2RhY1Zyd1BwdC9uU2tpMnFFQXZNTk9YNTR4WGFWSVg1clJZcW9U?=
 =?utf-8?B?TExYbS9lOUxaUk5Zd3ZPa3daZWxNZXNtbnRMdWF2MCtXcU1ydXpYWmlWc1Js?=
 =?utf-8?B?bXNuQmZBQVFZWTdXd0lSREVBaTJBcCs5MGhsSVl4ckMzQWh5QlkyaWgvajVu?=
 =?utf-8?B?RHoyRWZUVkdBMkk4WTNJUDRMZXRrSitGMVRCdHF6VXNQdDdEaEtaVExrWHhZ?=
 =?utf-8?B?cGRkOTRDNG5aZnNpeFk0dHhEanV6bTJ4KzFBbitGVVJ5d0N1ci96dnVWRFVI?=
 =?utf-8?B?NGZGUzVjQmV2Wjk1L1BUYjZ3WHdHVXNFS2RTOEt3SjR5ek1aa05kTEtqQ2VD?=
 =?utf-8?B?ZXBGMnFyRjdJVm1WbGJuZkZ4VllvMGFYUERGUHFsS0hHV0ZkQlNYQ2tnR3Yz?=
 =?utf-8?B?c0JRcTFPRFEwcys5U2pFeHY1RHJVaVN4MW1CNWZVRjFyUVVZejVVM2NNWWFu?=
 =?utf-8?B?cGlIYVRPRE9wdTBFSGRrRDBGQmhVVWlLd3J1WkNvY201YWN1cWU0OTRyK1JQ?=
 =?utf-8?B?NnQ4NTdmckFINHZmOXk1UEVBSkNQSWlRU3pUNkZBaHpWQ25mMitQMEhlRkVX?=
 =?utf-8?Q?dtHit78r5RImIUk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19092365EADFCC4392F617685CEB421D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pxnyTzmvjS9XruCotPfPUWrFPVT4uIEfKBbb/nGLSVT8HHtaWTeD5izjNecVe6D6sfwf6sR+Jkxhh5whubJCDn0HjF3fJ3/AfZMjWgeE+nB1Bs1bR+DaXKQnPtgcCWJ1woW90Vwmt4R3dZvN2gq4CGwLVU41Aok8sL9vlA2N/vDCae8PJvJIaRiNuportwS8dyA8qGULKtcu2/KrhyTRDPXiG47BQF5JIkPf17/H56wYGvmFSMseLZPkjciX6HfOa09PtontDqTcsGlXXNq8qbblUEO3j4doKJzhcgu5HpLS/U3zGFwPyYE7URHX/7z/kwnEUorakqYAi00ZWLzhGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963be393-73b7-4d5b-e90a-08deb54a3356
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 01:59:02.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0aiK50JUREFtrh3p2REC08vbHwxC6Ls7b6TL9K0xHecAcY0hSdJpIsTQB6Y9uDj4joaZldvegFJR38Q9/TSNLGB0pb3bidlWJ2NOJwWKdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDA5OjU3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjUyICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4g
PiBPbiBGcmksIE1heSAxNSwgMjAyNiBhdCAwOToxNTo0N0FNIC0wNzAwLCBEYXZlIEhhbnNlbiB3
cm90ZToNCj4gPiA+IE9uIDUvMTMvMjYgMDg6MDksIENoYW8gR2FvIHdyb3RlOg0KPiA+ID4gPiBU
aGlzIHByZXBhcmVzIGZvciBURFggbW9kdWxlIHVwZGF0ZSBbMV0gYW5kIER5bmFtaWMgUEFNVCBb
Ml0gc3VwcG9ydC4gQm90aA0KPiA+ID4gPiBhZGQgbmV3IFREWF9GRUFUVVJFUzAgY2FwYWJpbGl0
eSBiaXRzLCBhbmQgYm90aCBuZWVkIHRob3NlIGNhcGFiaWxpdGllcyB0bw0KPiA+ID4gPiBiZSBx
dWVyaWVkIGZyb20gY29kZSBvdXRzaWRlIGFyY2gveDg2L3ZpcnQuIFRoZSBjb3JyZXNwb25kaW5n
IGZlYXR1cmUtcXVlcnkNCj4gPiA+ID4gaGVscGVycyB0aGVyZWZvcmUgbmVlZCB0byBsaXZlIGlu
IHRoZSBwdWJsaWMgYXNtL3RkeC5oIGhlYWRlciwgc28gbW92ZSB0aGUNCj4gPiA+ID4gZXhpc3Rp
bmcgYml0IGRlZmluaXRpb25zIHRoZXJlIGZpcnN0Lg0KPiA+ID4gDQo+ID4gPiBQbGVhc2UgZG9u
J3QgYWRkIHVubmVjZXNzYXJ5IGNoYW5nZWxvZyBjcnVmdC4gSWYgeW91IG5lZWQgdGhpcyBtb3Zl
IGZvcg0KPiA+ID4gdGhpcyBzZXJpZXMsIHRoYXQncyBlbm91Z2guDQo+ID4gDQo+ID4gU3VyZS4g
V2lsbCByZW1vdmUgIkR5bmFtaWMgUEFNVCIgc3R1ZmYgZnJvbSB0aGUgY2hhbmdlbG9nLg0KPiAN
Cj4gSSB0aGluayBpdCBzaG91bGQgbm90IGxpbmsgdG8gb2xkIHZlcnNpb25zIG9mIHRoaXMgc2Vy
aWVzIHRvIGV4cGxhaW4gdGhlDQo+IHByZXBhcmF0aW9uLiBUaGF0IGlzIHZlcnkgY29uZnVzaW5n
LiBXZSBjYW4ganVzdCBleHBsYWluIHdoYXQgd2lsbCBjb21lIGluIHRoZQ0KPiBsYXRlciBwYXRj
aGVzIG9mICp0aGlzKiBzZXJpZXMuIEknbGwgY2lyY2xlIGJhY2sgYW5kIHByb3Bvc2Ugc29tZSB2
ZXJiaWFnZS4NCg0KSG93IGFib3V0Pw0KDQpGdXR1cmUgY2hhbmdlcyB3aWxsIGFkZCBzdXBwb3J0
IGZvciBuZXcgVERYIGZlYXR1cmVzIGV4cG9zZWQgYXMgVERYX0ZFQVRVUkVTMA0KYml0cy4gVGhl
IHByZXNlbmNlIG9mIHRoZXNlIGZlYXR1cmVzIHdpbGwgbmVlZCB0byBiZSBjaGVja2VkIG91dHNp
ZGUgb2YNCmFyY2gveDg2L3ZpcnQuIFNvIHRoZSBmZWF0dXJlIHF1ZXJ5IGhlbHBlcnMsIGFuZCB0
aGUgVERYX0ZFQVRVUkVTMCBkZWZpbmVzIHRoZXkNCnJlZmVyZW5jZSwgd2lsbCBuZWVkIHRvIGxp
dmUgaW4gdGhlIHdpZGVseSBhY2Nlc3NpYmxlIGFzbS90ZHguaCBoZWxwZXIuIE1vdmUgdGhlDQpl
eGlzdGluZyBURFhfRkVBVFVSRVMwIHRvIGFzbS90ZHguaCBzbyB0aGF0IHRoZXkgY2FuIGFsbCBi
ZSBrZXB0IHRvZ2V0aGVyLg0KDQoNCkkgZW5kZWQgdXAgcmUtd3JpdGluZyB0aGUgd2hvbGUgdGhp
bmcuIE5vdCBzdXJlIGl0IHdhcyBlbnRpcmVseSBuZWNlc3NhcnksIGJ1dA0KbGV0cyBkZWYgbG9z
ZSB0aGUgbGlua3MgdG8gdGhlIG9sZCBwYXRjaCB2ZXJzaW9ucy4NCg==

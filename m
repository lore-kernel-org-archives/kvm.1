Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6F40B107;
	Fri, 21 Aug 2026 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350928; cv=fail; b=GKXhgg5bnvLIuEax1AD+ExD47wuUeiREG9LTyWgBW0FejP/3qsWc3Bpld58u9V8B7r1Wa5ewEoXRPtE0KxLGGWLqZU2cTwxYBXz2P6zzm2fBLraNxbwDnNz/QCYDT8WeR8g5X1BcbukYhCp0bM5NO9i7LPSnEUXN+0JVgpTHiEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350928; c=relaxed/simple;
	bh=XzJSvNjlbyDh/JHOSkJLsz6um1FSAtjthbrSCTOXJKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLx/s/gU5h02NvJufyrKiJ8GnFopd+RJdn5jN5jHBhEg7O1+sKIQ2aW9rznfyEhH0RoPXbod7F8Tzi8ba8RQR2gToEquNLi4eiqTjwU/5lXtrNOhKU4+/e0NdcH2wg9FgcA7F9rk341nB7pvK+zfBIj3pmJWP5XpTLtAQjMMZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9gyuPg0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9gyuPg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787350926; x=1818886926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XzJSvNjlbyDh/JHOSkJLsz6um1FSAtjthbrSCTOXJKI=;
  b=l9gyuPg0vOKCqyN68U98hYzFfay/f1Q/D8oSPNSfsTbnIgfVMsWxYms9
   P4Gm3dZnetpXm2GTRthsv4K8f5u4+2kHhK9IpwqyK6KvmeErJAFkv9wWd
   uQc1VkxoRZW4rVA501k8fdGV72VZ83ieGUnZ7xWI4fYqOueZYLCBdmP7y
   ZkSHhw8fYbGzCOR+kl1uaaP56wapTCueNSOQe0RhbDqMYfcN6DuEljLuw
   T/DO3jsQJ417T4rncYwr47BBIYx6sWVbWpMsMHvlXwQR0/X9syq1qFMQo
   QRX4I59sqNLDxREafeZ24h0wz6LCoPeEdddm/2Ib51Aoa87/IuG5OYMTj
   Q==;
X-CSE-ConnectionGUID: eHnVncJGQGamTTe951tsog==
X-CSE-MsgGUID: KZeo+9vdQh+kOAJUQOIdeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87763933"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87763933"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:22:06 -0700
X-CSE-ConnectionGUID: X+lnoF4sS0qiw3J279Iz6A==
X-CSE-MsgGUID: AUOuEsRLSwi414Jl8n4eZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="269941660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:22:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:22:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 15:22:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0pgYYIx0sEk9gLRV1M9gViakchGFrKn1qc+2MK4XApUcXC1YgFXxvwm5QT5R8CHFIGAzdgn1+BnU4YA9Ium2OKVrx7lZwXKHhal3UBULDUdRAyFFQcIbNdrSDf+Pgry4m0qioXLuv5eDMb7l9Y6Bdhhgm7w8B5eybsJweb0HA3q5UOnqg8GO1AwumlpeKsdqxlb+mpjyP+Pv9uR3RTX8PI/EgvyN1l3DuaITQem00eEqJAK5UAEBGXZB98zTSsLxPP4iZL3ChEzg+Cu9vCwaaW2qkUi9e7w6c4/A6HJceuClG1Z/OP+NfIomxhYj7ZnhniqE4BNLrBdwNeQFMYByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzJSvNjlbyDh/JHOSkJLsz6um1FSAtjthbrSCTOXJKI=;
 b=YYT2Jc7Bf+yusLTeSWkcqTN9zR57lqgtW4sO/teYiW2dF4YW4jMiCPnkhift+ahGEdIlctuR8/kr2Yt/2CQdccaMIvIrIOUv9LZYwFuZbSxdWSBfcuVmQqTQJ7ESye2SIasS/GKE+B1eKW/sSnYqCuyW/5f1C6/tjTAUQY1yi0b9zjY+QRsaNEviJtkKOyy3fvaSe4RwloktX4j6baxxd8CCm3ub2ZTLWJAjwCy/E05X9avxvbqV5XrN0DqoVN8Hm050wiPu7lmT9rMOYA9ro6AN2CijTb4sP4E7g1rIi32ERx2a7TapDjTN5iNxwqXKp9CkZE/uIf+Ur1FVCPo92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DSVPR11MB9694.namprd11.prod.outlook.com (2603:10b6:8:34d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 22:22:01 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 22:22:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 3/6] x86/virt/tdx: Detect if the extensions initialization
 is required
Thread-Topic: [PATCH 3/6] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHdMR1UJNNDmRVXAU6wPcM9NiaFP7aon3IAgAB1SwA=
Date: Fri, 21 Aug 2026 22:22:01 +0000
Message-ID: <da4cc53825da8edf29bdaaab8352e1fbb60eea15.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-4-yilun.xu@linux.intel.com>
	 <aohsoZbDBZ8ZIYez@thinkstation>
In-Reply-To: <aohsoZbDBZ8ZIYez@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DSVPR11MB9694:EE_
x-ms-office365-filtering-correlation-id: d8cad61f-355f-483a-ff6b-08deffd29f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: +qE5B10nnLslGDEjuH5MYVpvmHP94piLDZG5Utiq/u0u5akNs5WUkFxOKCxSsS/3NUZNsetM3uojH+sWTqRRDrc0B1Jh0MuL3mHXZMaAvrJauw+/7OWyP0L6GQUx6Mgn0QdEEoc5ifaiyPFCO+Qi/ivsdTMyJV2tykI9rspV0rzad2EFn8lZ3Ate0F2MndFmoeKC/Svl4HwaR1668bdxqSxCnU22N3kiSOtYHyBofuGHmvt50p5Gsq1St1khM71KxZLOHfQAqNjd1hvqqWHc6Nl1URGmu5FnjbJqx6NIh6pGH5jh5AkFn5xwWScTcWtygA6LbE9HtENohYwnp/R+cu8sugp7YqN9X/aEyEEZD5y6W2Iq0cOUuGJA9SNdcKnoBcgdmAh/Wn83O2lLsb84mDnmSoZ73muL1qiktMgKJW8ToL86glJ/1OhcTY+vc1Rhsb0EkJc4HVbjGzwvPvXzyKXOH0R1AgWpw0f29UseCsPLts3aFN0GGhozZB2QI8Yhpt9uZmdhkLi96Trndc0H4KSDOL24DrXgLu3EVKMVi59p8iXvHRh2TPVaXZvSq1VUPYcA0lwBcji5pCN+XoHmNaQcUFlo4kcd9ZALTue77TY2EcReJp64bEc5dsZWpO3APJfw7RYaU4wS/cXqbO7Lj7riU1Wr0jcsQG1EBU9017oye0MYl0DaKmF82ZalqX2S5RbD7cItkspmzUyqw8cINefULexi1kfutwp4XUik100=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmxueHlVNCtLNk5USmZ5akVJbW9Jc1A4OEdqcWlhQVJDeFBlUkFNcHlsMXNa?=
 =?utf-8?B?Y1JCdzA2TFcwRGhDUXQ1ekVucHRSZkxMMXR4dGRRbTVJcGxRNk1BUGltOENr?=
 =?utf-8?B?NkJnOG1JeGNhaGpOVGFrSjNwV3AxUWQvSS83YlQvTG5IbUhrK3l0SkhLdHQy?=
 =?utf-8?B?UVduWkZDSWl1NWExWnRlc0JCVVBZUVlkdUtZV1l5cTJtUm8vNnZHbVpCS0JM?=
 =?utf-8?B?WWJhT1VUVVNFV1Z2ZGc2S3ZWWVd1ZUdianNIQXR4TVVTYS9PSXFEZHRUQ3RF?=
 =?utf-8?B?TWJlQjNnUzUwdGFCZFFWaFVPamhUZXV3aXdUUHV3M2RvQkJucU1MVDJqc2Rq?=
 =?utf-8?B?NC9xYUdCSytqK2wvdU5TcFB1dzJjUDZiY0tHZDJleTNkYTkrTTJOaUxHWkx0?=
 =?utf-8?B?cUNzMFJSSms4OC81cy9RWGM4Tms1bHdRRS9DdnlBS25oM2txakNHQmpLZHVo?=
 =?utf-8?B?R282YUxVN01SaEZxeEQ3THdUaWpoemE0QnpJeEs5YncreitxVms4K0MrSzV4?=
 =?utf-8?B?NUo5L092eEdPZnVkRlZ0Sngvd3ZaekwzZFhaTnJkYzdtYVdaREVac0xxMjRo?=
 =?utf-8?B?KzBPY01pNFFoUHZOT1Jud0Vhb24rQ2tIK0VHTWtOZnpxdUY0ZGJJWlZDMitN?=
 =?utf-8?B?U3J5RTJtYWpPWlErVU0rcXQxMm5meG1KZXNEMisvRHFHcmc5aG1lVzU3TFVS?=
 =?utf-8?B?TVBqbzNDVUViZmcyT0hBaDV3cE40dmsvQVcwVk9hN0owTE1vd1dOa3VNeTBr?=
 =?utf-8?B?cWttL1h1ZEoxeFVYYVhRM0g4SGpISUdmZmtpVHpDa2thNk51b2NlTTdIUDB1?=
 =?utf-8?B?ZXl3S1NydFNZQXFaWE5FWVd0OEpDcllZM3hENW5jZ0gvWUR1bzNXWDhjTkp5?=
 =?utf-8?B?MHI1SEFXaEc1cjlaTXpYY0dZaWZMTWNyanlLaVJBUGlUR0xnL0poUEtkMmdx?=
 =?utf-8?B?R2JXRW1GMWk0RnhYK01OU1NsT2kzanpJSngvRkhsWEp0bU45WTVndmVrTU9k?=
 =?utf-8?B?ai9CNkVCOEF6czRyNzUxbHlFeUZaTFFONUZ0SVVqQTloMG50ZG9BQSszeEhJ?=
 =?utf-8?B?MXFzWFI2N3FmSFBnTkthWldxMXlKN0RieGN6aGJaMkZYU3FGa1pvUXpzN01k?=
 =?utf-8?B?cGxVajI2WGRXUmJKTVVCNFRmbDduOFVDeVJDaXZQNXJSSDNnQ3lXL1BtbHRk?=
 =?utf-8?B?NWM3d1NlZEFDVThNSjNuQnJwbVI2RkxYUnBRNkFhbzEvZ2ZnV3NLbHJubXRx?=
 =?utf-8?B?ZVc0b2Z1SjhYNWJaQ3hBSnlOdDVKZlVFSFptb3VlaUphRnRhV1ZGckt6Q3Zs?=
 =?utf-8?B?cEwxbXZyRkhOUmI1Y0ZSUW1DSGlDQzk4TEhJQ0phZGRlcTJEc3RLaDhSQXNP?=
 =?utf-8?B?VEh5Q2dhYUZmRGN2ZnNLV3NYRkxGNzVjR3lmS3hDU2l2K0hMdWwrbFY1VGtI?=
 =?utf-8?B?RGpibU05NTYrcHdJOXhhNWdKZUpDSE9GNS9BSmg1V3hJSVRnUnlBY25RcEp3?=
 =?utf-8?B?N3RTV3BKMjMxSXVaSEhtU1hjRXY1eW81bjY1a1QrcjB2bUJ0V1J4OVZ4RkNh?=
 =?utf-8?B?MmNkZVl4TVd6cFh1MGVkOHZJMnp3NHdoQWxjT3VIemlSaGVjVm4ydGdqQS91?=
 =?utf-8?B?aGc5VWZyL3ZUSW1pL2k5N3Erd2ZhRTY1encydHZJeml4cVNxdUVUdjN0aFhU?=
 =?utf-8?B?M0IvazFQaWN2dkowbzZnWktlSTljZFF4cDNzQ3NITmI2SHE4b2JzL1pTT29a?=
 =?utf-8?B?WloxRDRRdWVSc1FnbDJwREZtWlJLcGg1YTMydWQxSnd1RHZuT245c3ptMTZx?=
 =?utf-8?B?bjlGeDZpWjFlb1V2RnZabXpvTXNpZGQxQ1BoZFlNTlpEYjRlT1hlckhXS0FC?=
 =?utf-8?B?UndFZFdxR20ydXlnd3VsQ1RkT0dLcXBIZmp3cysybllRVjIzSjNQN3NRYi9v?=
 =?utf-8?B?NC84SDhJQlBnak5XUEJ0V0U5QndLaVl6OFBRU0IrbjY3Nm9DZmNOZWdiQ1Nt?=
 =?utf-8?B?aVNIYkR6QmRxQzIwZ3ZXOG4rL0tjc1BObFdnUmpwNU5ZRDd3am9qK1A1OGlX?=
 =?utf-8?B?OXg5c3VSVXd3Y04ySXB2dGJka3V4aUlNdk8xOHQxQm85OHBoYUttVUU5eFI3?=
 =?utf-8?B?TlAyREFmaG1oRkhjejVpbkt3aTZ4MEtyVXFhNDlGcDF0YWcxTTZKdnFyMi9K?=
 =?utf-8?B?SDFmeXJGOGpTQ09xc2hZWGFNbzN6TjJmOWlGQ3RDWGVmZ05DU3ZJKzNpSm1Q?=
 =?utf-8?B?WVU2UEVYTjBJbkw2M3diUE14Y1JBbEcrWXZtTjhGcU5hYlVsNnVtOHdBcEVY?=
 =?utf-8?B?YytnNDdraUtNYUpyZGVaUHQ3RER4VWhQOUh2R3k0blFLdUZmalhtN0pJNWMx?=
 =?utf-8?Q?bA4L23bvEshUwRX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D9770C4E6F3924FA4776D95DB26BC99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WbjskepD5tN1HfzOXOfU/w+v3+zVw7kas5cX/u/LuiYpEq98gXD9CPFVAmh2pfIXzaX7qJFUMyBfmCqllJjT31ASkzDs9HUd3W5Dcu74U8rfs+1fdwxdMEV6bictAwnq/tzO1VJt2DerHVGAg3lHitufmRZRWzw+391sVLdQibo52Xjykm3pf2vqRLasyV6c+0fb4MEo+1GJxkC5Qgh7vVbeZw6QVZAzqFpA/L/RtZsbAGF9Fds9IgGsZ7KVr8ZPP4etxmwBfzYz5wjC7IwsJJNTj9PT3ZL+d9WaHa7XQOG1GaKnmb8LwbwzKSIwoqa92sFgFpAlOqUR06cZOhqvYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cad61f-355f-483a-ff6b-08deffd29f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 22:22:01.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgA1eDEY7CyaTC/TvEnbJcBNGpNMzJob7mJbdEyaPD9UWyxnZrFkX3tVof9DWPcZVZfpqCXMr9bbjHor9QcSpIQnR9pqq82KwDR8GJORa4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9694
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDE2OjIyICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDIxLCAyMDI2IGF0IDExOjI5OjE3QU0gKzA4MDAsIFh1IFlpbHVuIHdy
b3RlOg0KPiA+IMKgIHN0YXRpYyBfX2luaXQgaW50IGluaXRfdGR4X21vZHVsZSh2b2lkKQ0KPiA+
IMKgIHsNCj4gPiDCoMKgCWludCByZXQ7DQo+ID4gQEAgLTEyMjksNiArMTI1MywxMCBAQCBzdGF0
aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGUodm9pZCkNCj4gPiDCoMKgCWlmIChyZXQpDQo+
ID4gwqDCoAkJZ290byBlcnJfcmVzZXRfcGFtdHM7DQo+ID4gwqAgDQo+ID4gKwlyZXQgPSBpbml0
X3RkeF9tb2R1bGVfZXh0ZW5zaW9ucygpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIGVy
cl9yZXNldF9wYW10czsNCj4gPiArDQo+IA0KPiBIbS4gRG9uJ3Qgd2UgbmVlZCBUREguU1lTLlNI
VVRET1dOL0RJU0FCTEUgb24gZXJyb3I/DQo+IA0KPiBPbmNlIFRETVJzIGFyZSBpbml0aWFsaXpl
ZCB0aGUgbW9kdWxlIGlzIGZ1bmN0aW9uYWwuIFlhbmtpbmcgUEFNVCBmcm9tDQo+IHVuZGVyIGl0
IGlzIG5vdCBzYWZlIEFGQUlDUy4NCg0KSWYgd2UgcmVzZXQgYWxsIHRoZSBtZW1vcnksIGhvdyBp
cyBpdCBkaWZmZXJlbnQgdGhhbiBiYWlsaW5nIGhhbGZ3YXkgd2hlbg0KaW5pdGlhbGl6aW5nIHRo
ZSBURE1Scz8gU29tZSBzcGVjaWFsIHN0YXRlIGNoYW5nZXMgYWZ0ZXIgdGhlIGxhc3QgVERNUiBp
cw0KaW5pdGVkPw0K

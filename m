Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5A3955D8;
	Wed,  1 Jul 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931559; cv=fail; b=YB0F+Ec6KftqVL+ny9WISxHMOUI3jyQJrE0GqX+N5IDfn8A8NxZBBPvDqYtlZi0iGGfirip5ywWYGZIyirqmidJ0EZGHGYRcK62u4JqP7IMZ2J/AjE4DG9LPhgbfddLJA7G56/+NNKSo6ICWLlKByZCRhGGWlNyw91HeCEjk+/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931559; c=relaxed/simple;
	bh=m//UqdgZBYYJAjzgx0eVUg/fBQVrwwXX8mCQ9wRt/R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N1HqJsqqjfJiZM/j5cJHNUIJp26myRMXN4qrwYyJ3Kx6H8+lTekIobYADy1HBV7AV9J3WkYeRTaIK89tAu4O7Lfh5KJ6BEt7i+K9B0Fa7XoeC6ry/LfU4xAx7ZeZqdooCMhp70tT42ZcIC7qEPel3SjHxcWvcijKtsfEDzZQvtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gffVgF5m; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gffVgF5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782931558; x=1814467558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m//UqdgZBYYJAjzgx0eVUg/fBQVrwwXX8mCQ9wRt/R4=;
  b=gffVgF5mxS1gVo55n/xdC6Oc2aNnzqKM96iME6+ejZsTW/Yd87tElMp4
   jK4LBW0n1t0unrTbUZ1r41WCVkvO0PF1yZzCArFyhBliGYfH2r6awAd9A
   UW1HuDpkr+DUT1AJj815IrnEXY8zGgoCsHXhwjPvvhV+GuFNJkHsNh2Rw
   tt9fiSOZwCI2YNfEo2AoHkqizNGM2ec4fDf4lwjuomTDkkq3WpYFblwDw
   IRRbVQlYii/kHRq0KPCIJivLCPABzTab8DVgXM48UEVFlVXei6INosMhK
   QguG65gwRXSuPypFAD5Qt97z9o818sdIFcPYqkcXlG39hZY3+aoHST9Yb
   g==;
X-CSE-ConnectionGUID: RVYurNVUQ7emGwwLHg++Bg==
X-CSE-MsgGUID: 4ucWo3syT0abor3Z9D+B0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="86218805"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="86218805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:45:57 -0700
X-CSE-ConnectionGUID: kixlBoekTGiOSWkb96qo6Q==
X-CSE-MsgGUID: /yItyxN5QCW79fiiLUgqOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="248196191"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:45:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 11:45:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 11:45:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 11:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiI6zZna2LkkaQAERrOc9DPxiFrTLBKiEuky4bET6IDW04jQyshw2nrMML533dFfz+ItFHfHR+NljBS0J7I9dWqlYggnq3FekRBske9xbbAlm/0oolNVpTPD96833LxQsMqbtr0qOuLFXY1GZkgcG8DdgIRpR4Y9AQ9UpO8aQI2VotOee0ozNOmgg38p4ZcWS9HSXrRR/QeN+msezGXaNfB7ztHQSxZEErMBjNYPPicx8oplooZ/TnJoIFJ7vBvt3IEDEqYQSmXZu3HVQoN61ajwcJizB1O6RfUGELBuc+eYo1YjWeivkkDXPvMQGCO+mezIleTavLvEmxJHiXFU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m//UqdgZBYYJAjzgx0eVUg/fBQVrwwXX8mCQ9wRt/R4=;
 b=yF3cX7qIc2h/DcIvuwT3s/7JKKXGNAUU7OHDnNLukb0N38XDxD8ZG2qMlYqdbvJ1eaFuMH1/XwAXJgTpykcLDFWowDD6RfKWfo9KPwolgGeJH8df8NXqRnDPjYlVExy/X3M4PwjaamCmNJoYiFyGurg7J3qfX/0A3D/t3vPEM4uOX8xLoKHSSmOgFVWh9txrpaKCHFVD8QY7nIXDy0z6iNQ9uemCVfbT1iSwN1qCWfs0J1BYC7SzeL4QSDGKn29tJlO4YLNJOPBfDwNXdEmiIrW6kvtF4t4BStuQTPLY896H7jL+5JpPq5bebv3ZSgGxOgl18sJgK97segfnWkK26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA4PR11MB8962.namprd11.prod.outlook.com (2603:10b6:208:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 18:45:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 18:45:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "djbw@kernel.org"
	<djbw@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Fang, Peter" <peter.fang@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Topic: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Index: AQHc/v4hZvKBjyrt6EaJpy4HaHV03LZPm3EAgAXDgoCAAPWbAIABfw0AgAAOb4CAAR0dgIAAF2IA
Date: Wed, 1 Jul 2026 18:45:53 +0000
Message-ID: <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
	 <aj1tFuwZWdPGfUoG@google.com> <20260629100301.GA1743876@pedri>
	 <akMQ3J6fK3DUBsPH@google.com>
	 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
	 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch> <akVNdxCzk-n4bgMv@google.com>
In-Reply-To: <akVNdxCzk-n4bgMv@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA4PR11MB8962:EE_
x-ms-office365-filtering-correlation-id: 6dd53547-4480-4e61-2d88-08ded7a0fae8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|11063799006|56012099006|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 5NqZ32oI10KSmk1uIIQeB8nSHfuEOMX9gDbJwji++uwrsIpJNGgrvFNYHt5iSoHSJCa7mLiDZ72RkGb2UrY1Psd0o89n7YgZ/7eVUrkO/PNX/9J5Rj6V26uGzGM+RKGMgAf+m0kqyWco/r6liB/UFxMLB9b6O7ivPC1v2Tm3vCWgc1KCkbOlvizrohU5NMgjtmJmO/2bxepqgWuPLjCnI3TFqLjgYjMxVuvzDsP0+lxfPQHnntrjaAqmOxwLlEORgKt5Qa5yhwEyCCGHYjNCaKQz7Cjpwo35yOBu1wCQCy7IDCRVWbyyjT+29q7kS+jB4DQRgQVSqDPplHx79TAe1ZSQ8x1f95YLvugqzoRkM9Z3LlpjJjV2LzPJVDlqvPr/uhDlB9A/fDN20GBF2SbKS0YNr11xl+z1fBQzBhQXHSJL00w1ahO4TyxC3UbPgvRECZ+l3b/I5PCDSRbnREYJJxTIi73Ej6LN2oCl0mumXiqrrzNM16SGJ54gTR5A1701FpCzV1bR78ZKMBh6CId/54M7fCVe9dfeZGXPFJcW0Q2J2B21yW1rdhCRptW017R1lA9nysnMW1lrbkEdqfzE4mMjCjMiXvZWi0AN0BryQT/CCtHv3pEwfdVG7COmH74kF1PMghyvU3qkh3oCe1GWfMKAa0spMic9xfFqyix4c76fChAlqnsh2SWcduzL9IUvYINLQsYQONTnxGPZmNM2SVsP7vVMJjlaf87veZuRG3E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpiUlRBMFVWRlRrcXV4TmpkUjQyZDFza2oxTGhsdDVTeklvOWVYYXh3SWpU?=
 =?utf-8?B?bmZNeUluL2RsV0pJK2U3OTFwd21PeWNrV2JHSzZ2a2ROOTI0cVZSK3hOZ0dF?=
 =?utf-8?B?MXowYmdrMWYvcko0emp4OVgySXdhb0loZlZ5YnhuQnVUdUNvSm1ncERBRGVI?=
 =?utf-8?B?bTV6NGYzZnQvLzdoakF6eW1hQi9qVjAzaytUUWpVZ3Vyc2wzcTg1TUNWZjMw?=
 =?utf-8?B?aFlSSklYMHdhZUVaUVY1RVArR1lwTXoxRHdraGJLOFdqU0Y4K1hobWkrYWg0?=
 =?utf-8?B?WnE1M2kxZTkxVnZvL3dnWWVsTVZkQ1NPVFhDckpwWlM1bUIyVXFqQjJOWXJx?=
 =?utf-8?B?ODNVWjFLbzBwN3ZIZXpyMFBlWXZjM3h1Wm1iVDlUY2VWNm9ETlFiR1Q1cVE0?=
 =?utf-8?B?Q0YzYjBWZWF2MzI5VlV0Mnhxc0FocEpaNG1GbHV2b283b01oZVYrbVNxMmxM?=
 =?utf-8?B?bFhTbW1qT1RMN0tUNndlSHdDbDE0M3ZreGxhS1J0aDRpYnFvNG5UbmtGa1Zl?=
 =?utf-8?B?NWR1VlFWVll1Wk9tV2pJN09RVVFJOW1vSmFxaG1VTW5lOFBzWWQyTWVoRmpD?=
 =?utf-8?B?NGJ4b2NUQUZFR3JPY2ZHSmlOUUx0TGY2QUZ5aG5UbEJlcXlNSytnbTNza2ZS?=
 =?utf-8?B?WURxVE9wa014N0NXU1Byam1XWmRkc2ZvMFRpa3paY3lBZS82aHU5dXBYaE5l?=
 =?utf-8?B?ZlRESGRsbUpkTURQbmJXSTd3TW41WktiQnZyRVRybUhoMDZnYVBlZzdSdzhk?=
 =?utf-8?B?K0JZL2I0aFlVUWtkck1GMm9Lcjg3N3hOVitMMUV5WHdxVEhRUnl0R1BYa2xp?=
 =?utf-8?B?Q2U0TWpmZTlzNkpsZ3gyaTBOKzJKQVhXdHVQSG9LcWczNzdIcXZBdVlkTjB5?=
 =?utf-8?B?WmFiTER0RFl1Q25qQTdNUkRvbzNlZTd1M1d1cHluZGpUUGoxc1VEUGU2QW12?=
 =?utf-8?B?NGFQSTNwMTlYaUcwRzBrNER3aSt4aklHYXBQVkwyYW5Cczl4T3E2UTJ1eG1L?=
 =?utf-8?B?QzlqdVZRWUpoNHdsNS9WOTB3V1RjY3FvSjhBNzBZeHI2czAvY1Jxbk5xZ0pV?=
 =?utf-8?B?cTI5dXZwSkY0bXNyVk1vZ0NQVnF4LzlVdHRYdkRxZHp3dS8xcTd4YWk5UXE5?=
 =?utf-8?B?MnBLS284TzNTUjMybTQ1R1hSZHJBMU5USWFFZDhRc25rSWkxaHNPSTJqaTRk?=
 =?utf-8?B?a2lIMEE4L0djRzFTMklBRzMwZzVrSUhwQzMvUm5WdTliNzBXTlpwYWFWOWNV?=
 =?utf-8?B?TFlMWlBWU2Y4Q0tIOUNvT0RVSTVzVWpnOHAwd1Ezam4vS2JzM3QyeW5YWGND?=
 =?utf-8?B?RGtnRnBETFRyKzF0VVFnMEpFLzBKVndTM2QySVI1Ty9kekNQbEZVZmJMQ1Zx?=
 =?utf-8?B?Q2ZMWWo4MVZWeXlOYzJGc1l5eVQxRS9EcDVoNVIrd01hUmtpUDRpN29TaCtY?=
 =?utf-8?B?WVRENUtwelZ1MHRVb0p3RWtsRTJ1QXhKaHZKM1d5ZUNzaHlxU1oxY0pqRFNy?=
 =?utf-8?B?c1hNalNyRWRiUGYwMjQzNXh5VFlDK0FaN0VUT3RPdGttb3lUbVhtQW5wQTZm?=
 =?utf-8?B?NE51bHRsUE1GNDFld2ZDdFRVWGFtQ3I5SENZTU43TzBIOEdUemxHamVTTzl0?=
 =?utf-8?B?Rms4eS9nbEUyZGpuLzFqOGg3bjJjNCs1bkVtL21GQkhnOGV2SWttdU4rVUtl?=
 =?utf-8?B?RVpqaTJtTWQvdVNyOE1hd1BrM0pNYXJBSHNOMFRPcWgrazFQZE9vYmtJU21P?=
 =?utf-8?B?TWkxa21GaXpIR3F2enZnSXMybjZIMVVYZWI3Zno1R1pheG84am1OWVZXRktH?=
 =?utf-8?B?a1NKQXQvRzlGSjJQSHU4dDNNYkFhWDIrWi9aM0NuQ05NcnhORWhkaGlkWDdT?=
 =?utf-8?B?RXl2SVFDcGpBR3JhbzBrdUFHR1pOdFBjTEdyOWlkNmZWQ3RCL2RxODVwY1Y2?=
 =?utf-8?B?VGNDeG90c0FLc09NRy9leU1rcnlNV0p5TThpbTI0eW9ucE1CWnhLNlVnNlBV?=
 =?utf-8?B?dWVSbTRiV0RVazB3cGwySjl3S29hSnptd0I2NzlLT2pJZXhhVmxISDZ6Z2po?=
 =?utf-8?B?NDFyRGlEYzZqdklpVHFJb2UyZlU1VjNiN05oZnRSSGRjQW44dEhmdHA5MjBY?=
 =?utf-8?B?dUtrM2J0WTQ4eWVpZlhmR2MvV1UrMVNPOWhBMHkvRE1NbG84S2dsMmpqeWN2?=
 =?utf-8?B?bmc4SFhpZFlQeHN5QkZlYlFyQ0lvOVJkQjEzbllKb2ljOVZUQUwwaVNsbGZH?=
 =?utf-8?B?dDg0RTN3VEpOcWNWOGVjLzlhS1pUaVRaOXJoSE1aMGNOb1FNbDgrRFF3ZUxw?=
 =?utf-8?B?UmJXaDc1Y3kzSFVDd1JSLzc5WlV1Mmd5ZVlpNVNOeWRFSkxJM3BJVXdSQ05R?=
 =?utf-8?Q?6mrFGnhKVVX9B+k8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C58CA4587043844380D641738EA1F754@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JRIs9xEFpw6EOJA0eVJ0d3e/jkEIjoRbJinbLEWpYpCzAU3z6YYuQU3W8YmpVfSWo0u/DjhXhEsfAyAVoDabZg8zQoJdnU2iEYBCEtVDL5fw54QBMZHGw13HYGvZMcZOPc6AYNyTlkplTwJDRzNgMoouKDKgHrM8OdhV6uckN4/+qUp0rtxoMFihks8VkgwCxNMEMcOT0qu1rPG6Nz4dK1NMMy6+F3+iH432qElwuDk7j/a4FVaL26Adi62Tm7XI8yDu/GfbsWMlN3AIrQ17d7zinJT2meTBfRUCN2YEUcN573NY0kKBDKfvUFnpnV0R70rFSA7+6QOka90QEm8zJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd53547-4480-4e61-2d88-08ded7a0fae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 18:45:53.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB7BHYfXyfwhscs4dVvSdv5Djt8fBnGIj0PZj3ziTm/PZs+8dQqLdFfE0z6vZy/RPFI83nJdqG9wWmbXaqBoOKIi4jIiwwPCx8TKrSaRGMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8962
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDEwOjI1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+ID4gVGhhdCBpcyBhIGdvb2QgcXVlc3Rpb24uIFRoZSBhbnN3ZXIgaXMgcGFydGx5
IGhpc3RvcmljYWwgcmVhc29ucywgYnV0IEkNCj4gPiA+IHRoaW5rIHRoZSBwcm9zL2NvbnMgZG9u
4oCZdCByZWFsbHkgbW92ZSB0aGUgbmVlZGxlIHRvbyBtdWNoLg0KPiA+ID4gDQo+ID4gPiBUaGUg
bWFpbiBiZW5lZml0IG9mIGRvaW5nIGl0IHdpdGggdGhlIGhvc3QgaW4gdGhlIGxvb3AgaXMgdGhh
dCB0aGUgZ3Vlc3QNCj4gPiA+IHNpZGUgVERWTUNBTEwgcXVvdGluZyBpbnRlcmZhY2UgY2FuIHN0
YXkgdGhlIHNhbWUuIFRoZXJlIGlzIGFsc28gYSB3cmlua2xlDQo+ID4gPiBpbiB0aGF0IHRoZXJl
IGlzIGEgbGltaXRlZCBIVyByZXNvdXJjZSBpbnZvbHZlZCBpbiB0aGUgcXVvdGluZywNCj4gDQo+
IFdoYXQgaXMgdGhpcyBtYWdpY2FsIHJlc291cmNlPw0KDQpJdCdzIGEgSFcgY3J5cHRvIHRoaW5n
LiBJJ2xsIGxldCBQZXRlciBleHBsYWluIG1vcmUuDQoNCj4gDQo+ID4gPiBzbyB3ZSB3YW50IHRv
IGRvIHRoZXNlIG9wZXJhdGlvbnMgb25lIGF0IGEgdGltZS4gSGF2aW5nIGEgbXV0ZXggb24gdGhl
DQo+ID4gPiBob3N0IGlzIHRoZSBLSVNTIHdheSBvZiBhY2NvbXBsaXNoaW5nIHNvbWUgbGV2ZWwg
b2YgZmFpcm5lc3MgZm9yIERPUw0KPiA+ID4gcHJldmVudGlvbi4NCj4gDQo+IEF0IHRoZSByaXNr
IG9mIHVuaW50ZW50aW9uYWxseSBjYXVzaW5nIGVmZmVjaXR2ZWx5IERvUyBieSBpbnRyb2R1Y2lu
ZyBhDQo+IHN5c3RlbS13aWRlIGxvY2suDQoNClRoZSBEb1MgdGhhdCBwZW9wbGUgYXJlIGludGVy
ZXN0ZWQgaW4gdHJ5aW5nIHRvIHByZXZlbnQgaXMgYSBURCBnZXR0aW5nIHN0YXJ2ZWQNCm9mIHF1
b3RlcyBmb3JldmVyLiBTbyB0aGUgbG9jayBpcyBzdXBwb3NlZCB0byBnaXZlIHNvbWUgZXZlbnR1
YWwgZmFpcm5lc3MuDQpFdmVudHVhbGx5IHRoZSBndWVzdCBnZXRzIGl0cyBxdW90ZSBldmVuIGlm
IGl0IGhhcyB0byB3YWl0Lg0KDQpJZiBpbnN0ZWFkIGNvbnRlbnRpb24gdGhyb3dzIGEgQlVTWSBj
b2RlIHRvIHRoZSBndWVzdCwgdGhlIGd1ZXN0IHNwaW5zIHRyeWluZy4NClRoYXQgd291bGRuJ3Qg
aGF2ZSB0aGUgZ3VhcmFudGVlcy4NCg0KU28gSSB0aGluayB0aGUgdHdvIG9wdGlvbnMgYXJlOiBo
YXZlIHNvbWUgbG9jayBpbiB0aGUgVERYIG1vZHVsZSwgb3IgaGF2ZSBhIGxvY2sNCm9mIHNvbWUg
c29ydCBpbiB0aGUgaG9zdC4gSSB0aGluayBhY3R1YWxseSBhIHdhaXRpbmcgbG9jayBpbiB0aGUg
VERYIG1vZHVsZSBpcw0KcG9zc2libGUuIEJ1dCBJIHRoaW5rIHRoZXJlIGFyZSB0cmFkZW9mZnMg
YmVzaWRlcyB3aGVyZSB0aGUgZXh0cmEgY29kZSBpcy4gSWYNCml0J3MgaW4gTGludXggd2UgZ2V0
IGEgbG90IG1vcmUgY29udHJvbCwgbG9ja2RlcCwgZXRjLg0KDQpCVFcgdGhlICJoaXN0b3JpY2Fs
IHJlYXNvbnMiIHBhcnQgSSBtZW50aW9uZWQgaW52b2x2ZXMgYSBwYXN0IGVmZm9ydCB0byBjcmVh
dGUNCmNvbmZpZ3VyYWJsZSBob3N0IGNvbnRyb2xsZWQgcG9saWNpZXMgYXJvdW5kIG1hbmFnaW5n
IHRoZXNlIHJlc291cmNlcy4gU28gcGFydA0Kb2YgdGhlIHNpbXBsaWZpY2F0aW9uIGlzIGRvaW5n
IGEgc2ltcGxlIGV2ZW50dWFsbHkgZmFpciBnbG9iYWwgbG9jayBpbnN0ZWFkIG9mDQpzb21ldGhp
bmcgbW9yZSBjb21wbGljYXRlZC4NCg0KPiANCj4gPiA+IFdlIHNob3VsZCd2ZSBleHBsYWluZWQg
dGhpcyBtb3JlLCBidXQgVEJIIHRoaXMgc29sdXRpb24gaXMgKndheSogc2ltcGxlcg0KPiA+ID4g
dGhhbiB0aGUgaW5pdGlhbCBvbmUgdGhhdCBuZXZlciBzYXcgdGhlIGxpZ2h0IG9mIGRheS4gU28g
dGhpcyBleHRyYSBob3N0DQo+ID4gPiB3b3JrIHNlZW1lZCBxdWl0ZSBzbWFsbCBjb21wYXJlZCB0
byB3aGF0IHdlIGhhdmUgYmVlbiBzdGFyaW5nIGF0IGFuZCB3ZQ0KPiA+ID4ga2luZGEgb3Zlcmxv
b2tlZCBpdC4NCj4gDQo+IFNpbXBsZXIgZm9yIHdoYXQ/DQoNCkxpbnV4IG9mIGNvdXJzZS4NCg0K
PiANCj4gPiA+IFRoZSBvdGhlciByZWxldmFudCB0aWRiaXQgaXMgdGhhdCB0aGUgVERYIG1vZHVs
ZSBmb2xrcyBoYXZlIHNvbWUgcHJvYmxlbXMNCj4gPiA+IHRvIHNvbHZlIGJlZm9yZSB0aGV5IGNh
biBzdXBwb3J0IFRERyBjYWxscyB0byBURFggbW9kdWxlIGV4dGVuc2lvbnMuIEkNCj4gPiA+IHRo
aW5rIHdlIGNhbiBnZXQgdGhlbSB0byB0aG91Z2guIFRoZSBxdWVzdGlvbiBpcyBwcm9iYWJseSBy
ZWFsbHk6IGRvIHdlDQo+ID4gPiB3YW50IHRoZSBndWVzdCB0cnlpbmcvc2VsZWN0aW5nIG11bHRp
cGxlIGludGVyZmFjZXMsIG9yIHRoZSBob3N0Lg0KPiA+IA0KPiA+IHRsO2RyOiBGV0lXLCBob3N0
LCBpZiBvbmx5IGJlY2F1c2UgdGhpcyBpcyBvbmUgb2YgbWFueSBibG9iIHRyYW5zcG9ydHMNCj4g
PiBhY3Jvc3MgbXVsdGlwbGUgYXJjaHMgdGhhdCBuZWVkIGhvc3QgY29vcmRpbmF0aW9uLg0KPiA+
IA0KPiA+IFdoaWxlIFRERyBjYWxscyB0byBkbyB0aGUgc2FtZSBoZWxwcyBhIFREWCBwcm9ibGVt
IGl0IGRvZXMgbm90IGdlbmVyYWxseQ0KPiA+IHJlZHVjZSB0aGUgTGludXggcHJvYmxlbSBvZiBt
dWx0aXBsZSBhcmNocyBoYXZpbmcgbXVsdGlwbGUgYmxvYiBwcm90b2NvbHMNCj4gPiB0byBzaHVm
ZmxlIGRhdGEgZnJvbSBob3N0IHRvIGd1ZXN0IGluIHNoYXJlZCBtZW1vcnkuDQo+IA0KPiBXaHkg
aXMgdGhhdCBLVk0ncyBwcm9ibGVtPw0KDQpJJ20gc2xpZ2h0bHkgbG9zdCBvbiB0aGlzIHRvbywg
c28gd2lsbCBsZWF2ZSBpdCB0byBEYW4uDQoNCj4gDQo+ID4gVGhlIGN1cnJlbnQgZGlyZWN0aW9u
IGZvciBvdGhlciBhcmNocyAoQ0NBLCBTRVYtU05QKSBhbmQgYmxvYnMgKGUuZy4gUENJDQo+ID4g
YXR0ZXN0YXRpb24gY29sbGF0ZXJhbCkgaXMgc2hpZnQgdGhlIGJ1cmRlbiBmcm9tIGFyY2gvKi9r
dm0vIHRvDQo+ID4gZHJpdmVycy8uIFRoZXJlIG1pZ2h0IGJlIGEgbGF0ZXIgb3Bwb3J0dW5pdHkg
dG8gY29uc29saWRhdGUgc29tZSBvZg0KPiA+IHRob3NlIGRyaXZlcnMnIGludGVybmFscyBvbiBh
IGNyb3NzLWFyY2ggZ2VuZXJpYyB0cmFuc3BvcnQgKEFGX1ZTT0NLKSwNCj4gPiBidXQgdGhlcmUg
cmVtYWlucyBhIHJlcXVpcmVtZW50IHRvIHRhbGsgdG8gdGhlIGhvc3QuDQo+IA0KPiBXaHk/DQo+
IA0KPiBCbHVudGx5LCB0aGlzIHNlcmllcyBpcyB1bnJldmlld2FibGUuwqAgSSd2ZSBzcGVlZCBy
ZWFkIHRocm91Z2ggbW9zdCBvZiB0aGUNCj4gcGF0Y2hlcywgYW5kIEkgaGF2ZSAqemVybyogY2x1
ZSBhcyB0byAqd2h5KiBhbnkgb2YgdGhlIGRlc2lnbiBkZWNpc2lvbnMgd2VyZQ0KPiBtYWRlLsKg
IEUuZy4gd2h5IGlzIHRoZXJlIGEgY29tbW9uIGJ1ZmZlciB0aGF0J3MgYXBwYXJlbnRseSBzaGFy
ZWQgYnkgYWxsIENQVXMNCj4gYW5kIFZNcywgb25seSBmb3IgdGhlIEFQSSB0byBpbW1lZGlhdGVs
eSBhbGxvY2F0ZSBwZXItcXVvdGUgbWVtb3J5IGFuZCBjb3B5DQo+IG91dCB0aGUgYnVmZmVyPw0K
DQpXZSBjYW4ga2VlcCBkaXNjdXNzaW5nIGl0LCBidXQuLi4NCg0KPiANCj4gVGhlIGNoYW5nZWxv
Z3MgYXJlIGFsbCBoZWF2eSBvbiB0aGUgIndoYXQiLCBidXQgZXhwbGFuYXRpb25zIG9mIHdoeSBh
bnkgb2YNCj4gdGhpcyBpcyBiZWluZyBkb25lLCBhbmQgaW4gdGhlIGV4YWN0IHdheSBpdCdzIGJl
aW5nIGRvbmUsIGFyZSBub24tZXhpc3RlbnQuDQo+IA0KPiBTbywgYmFjayB1cCB0byB0aGUgYmVn
aW5uaW5nIGFuZCBleHBsYWluIHdoeSBJIHNob3VsZCBzcGVuZCBhbnkgdGltZQ0KPiBkZWNpcGhl
cmluZyB0aGlzIHNlcmllcywgYmVjYXVzZSBhcy1pcyBJIGRvbid0IGhhdmUgdGhlIGludGVyZXN0
IG9yIHRoZSB0aW1lLg0KDQouLi5pdCBzb3VuZHMgbGlrZSBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYg
d2UgdHJpZWQgYWdhaW4gd2l0aCBhIHByb3Blcg0KZXhwbGFuYXRpb24sIHJhdGhlciB0aGFuIHRy
eSB0byBiYWNrIG91dCBvZiB3aGVyZSB0aGUgY3VycmVudCBwcmVzZW50YXRpb24gbGVmdA0KeW91
Pw0KDQpUaGlzIHNob3VsZCBiZSBhIHByZXR0eSBzaW1wbGUgZmVhdHVyZS4gQnV0IHRoZXJlIGlz
IGEgaGlnaGVyIGxldmVsIHRoZW1lIG9mDQp3aGF0IGlzIHJlc3BvbnNpYmxlIGZvciBsb2NrcyBh
bmQgc2NoZWR1bGluZyBpbiB0aGUgb3ZlcmFsbCBURFggc29sdXRpb24uIFRoaXMNCnNwaWxscyBp
bnRvIGEgbG90IG9mIGZ1dHVyZSBzdHVmZi4gV2UgY2FuIHRyeSB0byBmaW5kIHRoZSByaWdodCBs
ZXZlbC4NCg==

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FEB489FDE;
	Thu,  1 Oct 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886541; cv=fail; b=nj2V9OOZO6xsHFv/nvtZZbTY/80VkhqoRuoJxpWUWFLvaJENTaBuKR6HrzFpgcveAXle/+Gx8XOOmmhu+osaC1498biVhp+lPsuE14562hjS+CHfRZqROyMcVx1X12O7aP5fObSDyQnrduOlHX1A6tNGAcVCCfIGyeFTIrTcsk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886541; c=relaxed/simple;
	bh=O0fJ+mmUzsuletNTCR9saOw76ZB4xgQufS70gmxYH1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHme/PgJgRpNavWj4f+Y+5OHN+K4IAjkwThDg4moqDPiNi7j81rW09dPQqanxmGzq2sIvtUQOXgyPvGso9LZSZDXbkkBp9Peu7+kQNsZId7Mhlc8EyMvMHYcMPkbeELSAZyl64VVSAtiFkJyd1ODuQq3931IL6tbhl8XYvBkEog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMyXtRlA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMyXtRlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886539; x=1822422539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O0fJ+mmUzsuletNTCR9saOw76ZB4xgQufS70gmxYH1o=;
  b=LMyXtRlA39sJSgJ+Vmk63R8z6dQdpZc7da5mfaA0dJfJoKY41pQ/y7dv
   Wjmk799kTgbsCv6Y0CS8/OAo3YFeQ10pbZXjkdWim8tIJ1scIirovj7cJ
   LPGpAZs+7KI0f+ixZxtWpFoAFrc9wZ8QMotYDHBe2YBLwGlQCnV3k17Fn
   Vlkwkqicw/VCekADvUHJ+DajHCoc1Ck97990wrAqpZqBPMHPLAgtnGP0+
   aPZX4haRvY9fLSoEmDlAH7uJaKhe7Rb+P7WDE1yFveU6a39ZteCFH/FpZ
   xzsV+BwFB0ggC9PN6qFpYUEYHX/RFXiGibc2hGugoU1fdv+ALIlIXI/uZ
   g==;
X-CSE-ConnectionGUID: AaTD1s+oQayM597RwWY63Q==
X-CSE-MsgGUID: DZuOa/sUT1Grvq22gHTV4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102232386"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102232386"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:28:57 -0700
X-CSE-ConnectionGUID: lrr7AGBeTKG6bAp7gGQ5+g==
X-CSE-MsgGUID: 0LLLxUPxQGWkb4U/z0ehdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="280830972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:28:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:28:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:28:57 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xclvo799c6Pq9JKQxDhZpyPZssatv54WH6zEOm2vFYIKAud6NI0nh7bv9lXr5Ks/8FGfbhXW/cRTQTQBTbIsN8Df05LunJVmw73EXnHCyJzr3kVL+0sV5+1qqkcDx3FQ3T49ptaC0oIYfTaUMGjHKYgYfdl3HvGSYt81yRVsP1QawDLjhenqwMgv9GIxgxYz7UnW49N6ixstMle+MXgYObp+QJexfqizBBmZxJyyytMK7LIW2J/vzbuJ8wvnzB+dQqvBj0XJ7SEDU6kZLJhyakGDrdvh6CIUCl5jnmdIJ2c3+nhvH6WOSBnBAxPfa6VYFQasykXp0C1NCge7e2Ks8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0fJ+mmUzsuletNTCR9saOw76ZB4xgQufS70gmxYH1o=;
 b=M0IIECjYP0NPw5gN3O+itHiEK24Fd3HpOXqWXkaIhDmV2kS0pZYFYBdm6lRBc14dvW+4SEeh5vRYmblCP1B0BM8ctORqbvrfvwEkd9bCoYRbBd+4z3vrkrpXZ694mQO4UvAHEbkZa0L2J1npEQvms0oNILUe7ijJjizwWoMjyt/PMrs1799Ohe4Ci7dFf+p+9ABAQKph9R5bygyA930DsivGoW17z1qlP2xqZ5a1+rzFzNBZvWU1IZY+PIsmeiGrO4bZaJroQAo+UHbv7GiqvpvghfWL2O/ITRi4kFm5RUpaRa2KAKaZJOARuKFcGsp7knjVtT8Iv0NdTIx3fx2BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS4PR11MB331194.namprd11.prod.outlook.com (2603:10b6:8:53e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 20:28:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 20:28:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Thread-Topic: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Thread-Index: AQHdUJ5P3MQ1gugT/EygKLwzJpWEjrbnzOSAgAEXZYCAAEFtgA==
Date: Thu, 1 Oct 2026 20:28:54 +0000
Message-ID: <48ed6f1bd588c6ccab398c5310fb1fc073c1e53d.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-8-chao.gao@intel.com>
	 <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
	 <ca464aaf-1935-42ed-b486-4f4cb84ecd2a@suse.com>
In-Reply-To: <ca464aaf-1935-42ed-b486-4f4cb84ecd2a@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS4PR11MB331194:EE_
x-ms-office365-filtering-correlation-id: 236e63a9-5fd2-4d2e-2149-08df1ffa9cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: hPFr5pbbRQGWMYbs5pyOCnZk117xrUcSAdlhUsakdxYwL9B2tHOB3pwq5I9KTtnpSFvd6F3vcmf8f4wbR4eOW18KoJD8G5D25yPHSBMgQu7Nbsv5Dq47GMo2WcjVNZvs/fHl1722b7c36ERhCvi34RsSMULz1RmAyejuYmNgTiak7gi7HzBOBcxib/7cu96eXUSB+gce3hD8tn1SPA7AaEzRKlp42jeCc3prQglgIaOJUPrHXaQYPnMJ+p/KBIt/VkiRWMEhY5LafuxxwACA5ETQtntjW+1fOf6Neckjugf6aAD/kl8PB3OHcoc0KoXcF0emHhlydZqN4JHhFvuDO8eflL/hMCAHHn5kqHO78QZZxBAXvRXYPMoUpqw/6MkhYkA/9RJ1afI7SWs+7seJfMfUCiQeZCg5tVlA+429zf1rB283EwkH6YCf9xnCGwzG7y2bE4jmcDseJE9YrKYzDi4sKzyHzzLwX4nfe/u8gcyyo0LSxBS/qOXurXTzdV5iUdFtcS2srCEvbehg/IS3MdvHobRULA2PP6DPuCzJuRx+mNIckiMjShvEzFfnKaklDxP0aNeJHxZunczzzby9MTWRlv7GUoqsdIhg4PSfTuxfvb7bQpBTEg+YpX4xqerHaytaPhDHWpO3Fwvj/77/OV6Nu5Of61tmIqx9B8bFzodTeA7PGJ94ShHky4HmaTBKGxuxPGkCTc0Cl8PZcHpC9m1rNFMkhfTmi3yCOMumFGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0Irb0E2emhGeVYvNUtvTCtxMVQxQ3JobklRQVE1bmtVWDhoN2QrZjV0MlJD?=
 =?utf-8?B?QkVJNUZlUlRJalFvRHNDN0VObkhoL2tpaGRQL1BKSkNYbU5JR0hZdXZvZllE?=
 =?utf-8?B?TytmdjBZT0haRXEybTJsYkdEVTBYZFJic2VhWFM4bTJlMm9UK2NtNlVzbHYv?=
 =?utf-8?B?NGJrNS9FbXhvb1dHUCtxMzRJd3p4OUUrTEMzL2RqaDhpNHp2bGhDam5RSW5R?=
 =?utf-8?B?blR4dGNkVkc3UWFoT3VEbTBXU3pvK0wzNWhPQThWeWtjdXptdmc0ZFFMS2JB?=
 =?utf-8?B?ZC91MUhJNWRsdm1nVTgwTFdNSFMvc1d5Mk5xYXdPTXNVVXludFY3eVo3OVEy?=
 =?utf-8?B?V3lJMlJYRmp4K0VnZldGRGRDWGxTT3J6YjVENFBGRXhnU2hKV1dyVHF1TW9G?=
 =?utf-8?B?VW5BYjlwcEI5RWxENkNVT0xQVUJSTEFvdUpUU29PV2hidE13N3g2NU5lRDA5?=
 =?utf-8?B?VlpYazNqM3lSbE0yTm9hRkdGT3Rad1o4MUhvbjlKZlZnc2ZtYW5iK2p0UlQ0?=
 =?utf-8?B?azJpYXJjcUVxQXBTQjZmZ3d2R2JqRDA1TkoyeXRvZXkvbVlEM2NtOGtLOGds?=
 =?utf-8?B?c0szUTZYSFZoSHBXVjBwK004RmcxMFVpOW1NMVhSd04vOE9yOGJhdEY5RmtU?=
 =?utf-8?B?Nnc0aGZIa09MdXRCU1VPZE9HM1MwV3FoTlhuTW5BOEl4NjExQUZMMW9Xc1FC?=
 =?utf-8?B?NlpFUmFSd0xpNVdtQlZ5K2xadVJtRDlCVjJqNjJITzl1S1JEOVZ6UUplUXZv?=
 =?utf-8?B?a0FSaHlJZXM2a2NOOWlUc0NJeTFNOVlaUDAveUZrRUdBZjBRNDQwYm9EeTZE?=
 =?utf-8?B?Q1F5ajJvZSsydjZlSllQU3JXR3k5RW1UOGtwUGUyTkdJMHBkWFBhbGw0YmtG?=
 =?utf-8?B?OHZKRHRJbkV3OU1ZakF1Ujh0YWF6YkNyWnBTMSs2VXNxRUJtdDR0KzJyL1k3?=
 =?utf-8?B?UmY1Y1RpaW01bU9teGI3eTVDVVJNVU5hQjd4S1RmRHBBZDM2cWplN2VZM2hk?=
 =?utf-8?B?enlSQnczUzZldG9MeHJzRnZjcDAvZmRtUHJxeU8zUTJOZFJaME9WcFAwdU54?=
 =?utf-8?B?RzduUFkvTmJVVFJBM05DK2E3SWF5SmFxcnlNVnJUNExNbUVnY1U4c0lDZEwv?=
 =?utf-8?B?OFdrUnZNSTV4ZzhwNUJVLzM3aDN5aVFuTE1uZXRIRTJqdlBjcWxRZDFwNjl0?=
 =?utf-8?B?MXBaNk9VREVmQXRuM0g0cjI4ZGk1V013aWJ5UEVLenNTcEliT3hadXdsSjNE?=
 =?utf-8?B?MUE3a213R2FTNnBwZFhLTGZKYi9USGlqTmI0K3ROWDBFckFMNTBtcUxEMWdQ?=
 =?utf-8?B?T3JWSSs4RzRBL1ZuZ2lWZXdQcVhUQVF4YzROSTRmaVJWOG9FZG9WV20rampL?=
 =?utf-8?B?M3lEZ0ZVSVZTb3pTQWNwbHdieEdMblg4OXQwRVhjdzNVdklIaW9RR3dQYWJr?=
 =?utf-8?B?cHRwYVRScW82YStnaVgwVFZvYzFNS1lQcDYzNUhvczRYKzNYdU05TnF4S2Jv?=
 =?utf-8?B?K0hoSmgwM1JEb3o1QWNmd0NXekwzZldyZHBoZGhoMWkrWUd3b1VVU2dpQmo0?=
 =?utf-8?B?bnhxZEdBUkZISk1BZXA2cTdZaGhLbDAwRnVRY3N5TXo1QXRQQVhnejVSK3Fp?=
 =?utf-8?B?WGZ3THpPbEd4ZHQyQmdwbDcycHdhc1pPN0JHMjdvVG5tRHJFVnplRnRhSjdX?=
 =?utf-8?B?M2IzOHhYTms2NXFCK29veTUxT1lud2xlaGNwRTVnMVFod2dzU29CUmNEcWF4?=
 =?utf-8?B?dzV3bVZCVWNtUE81VkhBQTdZQ3lmY1ZLbW5EYzZSTUVrMnpNVi9aVFdabXdw?=
 =?utf-8?B?NXhKVVpjcVFxRHNua2RjSm1zZ1NTc3NOM0I0RkFRdWdBSVRxamJ2aWlGVkxO?=
 =?utf-8?B?bXhWbjNudTh4MmM3VDBXcmNzMTNMRk5EdzJUNk43V3prbDBkb2trVnNrV2FO?=
 =?utf-8?B?Z3VZZVo0RGk4K2Q5cnBGeUNCMlJXQ3NIOTB3QnkyWXUwb003eDIweEVLU1c5?=
 =?utf-8?B?YTZPMWYzNGdwcDFodE9OaXFQV0N6UWpjOWdSaFVBNDQxb0RYc1Q0c1kxZFVk?=
 =?utf-8?B?QjJwNHRERmtHWGVxSXRqNW9SdDkrT1JvcFJQNzN3d2NQVktFaUxnMDVqWkNa?=
 =?utf-8?B?alVCYTJDelVmSWo4c0tPYzJobi9lOHU2eUUvdURpQkJGdXFvNEZTSk11WGR4?=
 =?utf-8?B?TmVkdEl1UDM1TVFHbkR1Vll4UFMvZjVrUE5ESTV0V0RJTmtkTkVkUmxJQVpk?=
 =?utf-8?B?TC9ZN20vNEhTcVZHRkVLT2lmTlRiVEFtVzdtQ2xsRXFhMm8yQXRhVmNpbkor?=
 =?utf-8?B?UnNEYzZUdHZnODE4MHVuZ1doSWhhQjI1N0tOTVZpMFBQYlpBanRFWVRjM1FH?=
 =?utf-8?Q?0VjoTv96/0Rc9p5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0574F83D930A2343ABBCC8CE2D47F080@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 133ksj/WX29mTTwtMDfGvOH2eW/G1SVqUu91Q6+45o49Dpu4YaPDHzj5d3mRbpC9xB0e9QQGgCU2fGEUGH9cSA4OZVapj/YHFpJykQDKX9HJBNAcNJI3yDxhPYDo9x9yZb0PmKcpzjbd6CKJQ+0nEA0z/SmY7J3t5JzSGn2WQXjqe7mpeNFbMLWWjIsvoAbQHNMqCZXon2pUhmCWJXFzLJIrbj7yBMUgfXRQRXAIOBau/sCFPFYENIXCOs3zkdWpadYVA9XM3h2DuJWRS7oepfBFOxp6PZZZUkq39QhAzeb5NYvHDwDHJNbNKUqCGHPJc4PS9pOEOPGAz3jSqb4I9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236e63a9-5fd2-4d2e-2149-08df1ffa9cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 20:28:54.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKKIui2AKpCsq0VveL5nyVpB1hB4lc8PfKvnouqtmYvpLjGF8GO2dVSZ9BhIRY5r4P/wif7wuGVy3/7DlxajMN+wY91snIXoppPFoWCSslA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB331194
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDE5OjM0ICswMzAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6
DQo+ID4gVGhlIGNvbW1lbnRzIGFyZSBub3Qgc3RyaWN0bHkgcmVxdWlyZWQsIGJ1dCBwcm9iYWJs
eSBmaXQgaW50byB0dXJuaW5nIHRoaXMNCj4gPiB0aGluZw0KPiA+IGludG8gImhhbmQgY29kaW5n
Ii4gSSB0aGluayBpdCdzIGEgbmljZSBhZGRpdGlvbi4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIG1h
a2UNCj4gPiB0aGUNCj4gPiAiaSAqIDIgKyBqIiBhIGJpdCBjbGVhcmVyIHRob3VnaD8NCj4gPiAN
Cj4gPiBJJ20gbm90IGFnYWluc3QgbGVhdmluZyBpdCBhcyBpcyBmb3Igbm93LiBJdCBoZWxwcyB0
aGF0IGl0IGRvZXNuJ3QgbW9ycGggdG9vDQo+ID4gbXVjaCBmcm9tIHRoZSBjb2RlIGdldHRpbmcg
bW92ZWQuIEJ1dCBJIHRoaW5rIHRoZSBhYm92ZSBmYWxscyBhIGJpdCBzaG9ydCBvZg0KPiA+IGhh
bmQgY29kZWQgcXVhbGl0eS4NCj4gDQo+IFBlcmhhcHMgdGhpcyBjb2RlIHdhcnJhbnRzIG9wZW4g
Y29kaW5nPyBUaGUgY29kZSB3aWxsIGVuZCB1cCBsb29raW5nIA0KPiBsaWtlIGNvbmZpZ192YWx1
ZXNbaV1bMF0gLi4uIGNvbmZpZ192YWx1ZXNbaV1bMV0gLi4uLg0KDQpZZWEgdGhhdCB3b3VsZCBi
ZSBhIGdvb2Qgd2F5IHRvIGltcHJvdmUgaXQuDQoNCk15IG9ubHkgY29uY2VybiBpcyBob3cgbXVj
aCB3ZSB3YW50IHRvIGRvIHdpdGggdGhpcyBzZXJpZXMuIEl0IGlzIGFscmVhZHkgYXQgMTANCnBh
dGNoZXMsIGFuZCB0aGUgc3RyYWlnaHQgbW92ZSBvZiB0aGVzZSBsb29wcyBpcyBlYXN5IHRvIHJl
dmlldyBmb3IgcmVncmVzc2lvbnMuDQpUaGF0IGlzIHdoeSBJIHdhcyB3YWZmbGluZyBvbiBsZWF2
aW5nIGl0IGF0IGltcHJvdmVkIGNvbW1lbnRzLg0K

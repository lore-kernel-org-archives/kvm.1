Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B65947E6;
	Tue,  8 Sep 2026 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906694; cv=fail; b=heaag2U986H7mhv4VHtNoDk4iOauxj+X4REg9wAS/2Dj5siEI8pDiBXBYIBfWv6Zd/MgyQa77hUvTs+GGuERd+B1Yqae01j2aMzcNuIKR02ZKINtpVeKb0WmXCmjDa33GXnEEhs7mk9vCOlxpF+liQjTi/9GVvio0vPgsui0HUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906694; c=relaxed/simple;
	bh=j9wPR8sfCrKkzzyuI5vRIYvJsu53+LT354v/PpL2yzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iv//WmvPMV9L8acuChLH8uAlq2tgfvpcMdzF0dAFGkXqRkI3iAfZg0GyNdvNXsgr1M7eEB26L8V9p2FW0J/x5g3hCAyW9VFkWWw3XkTmwRaWEwBHspmWJ8eao6KABjuNpWTkEjBGtulZy8I8m832AOaiLgyOarXzuEv2Os9yfoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrYU/vFJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrYU/vFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788906690; x=1820442690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j9wPR8sfCrKkzzyuI5vRIYvJsu53+LT354v/PpL2yzI=;
  b=UrYU/vFJacrloBdwgJPB4YxDddy2dkji5d+KIjJU7hv96HQ66eR1u533
   TABTrtgAsivQzlfDcvixAi34p+QxiJ6omIDwyrS3BTQOOsgyP+za5k0Tv
   GFeL672APkDOPuAp5xNVcTMzYP8E2f3bquR4QcxECH8oHIRhRd1wZk3wP
   pQkp8rvU4QsOaZYtpCpgy5q3DMj6bpmrRMInt+8CHSYeJLh6VqDpM9iQq
   w/t4ZZj4F/IWNIh7M/mD17zct2lswHJZBvp6XBPnwBOn36VklDUGSF1VV
   YdoeO2zBk/mcCDAHpPeevOK/7gQXMN1VtJpbpaoncUKlvCBpN23RXmdSn
   g==;
X-CSE-ConnectionGUID: svTsrdYdSLm/8vXZstibDw==
X-CSE-MsgGUID: k0f2dGfnS9mKYXigzorMag==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93019847"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="93019847"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:31:29 -0700
X-CSE-ConnectionGUID: 8HkO26PGQs+WWx2Y/FMYhg==
X-CSE-MsgGUID: 7yLAjvJGR1anFxwo5PiRPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="296071237"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:31:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 15:31:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 15:31:28 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 15:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJucSjC7Ib3Tt8GCdcQWgXcNaOIRxO7MGqJHXqeOfj3DbSm333oN4eh791xpT3Iw8VjWp8Q+ds4QBXOQTTLwO/kIpk7p3Wfdhm108XvOhWJ0a4TxU8aS7qelYGYH3EQgoU5dnHVfWQ8JbSnu7MsAOcGrd42am7jWSPQVVx+0HZ68zNllH3tjqyDw3T9nBIdq9IsTfhpOc2GOX5DCm7EI6oJi0JS3Kei2v3oxXkX5R4XhelVhUfB4dDjToP/0JpMSHJWA/3ryeonuEA5DROi8LdSNOHe2ZZI9IidMmvxhJhoZsRbGIHiyY9KqyUi3g1rZMlQV8nRvzl8AGNwiZ3uf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9wPR8sfCrKkzzyuI5vRIYvJsu53+LT354v/PpL2yzI=;
 b=QK67f4XaFBUR455VHsSmqNPhd8ezjiRWOwbX7aFZ/VIigN2tGDrFXVk+1ZQLvBz7c1avU9hzBM3r+6s6CdgYpyZ3jCHOFZuUm6sPfLJB3qjITJNOOXq6JzLo3PmR+L3oKgkhM87zcdPx9Cx/HgwROk9l/M7p21o5Jr55HIQXKMs+8A0PDDyu6arRQf4g/af4+ufnx8/B+oAbieMd/cLQNrvL23gfYpu29ypVUE6q8/LLiaWmkM1Yie4GKloZvSr8Y2xvPG4BLAUC6H9VrH4KrY3vmj6hfP1tAmIpkHDqT3iE68tyMyQ+QOS1zvYzP6sLKnGUFs7eZT9Y2BK3RX/VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6730.namprd11.prod.outlook.com (2603:10b6:510:1c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 22:31:25 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 22:31:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLbFNg+AgAAh2wA=
Date: Tue, 8 Sep 2026 22:31:24 +0000
Message-ID: <58c185c82658819454a9950f37c6424226a098bb.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
In-Reply-To: <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6730:EE_
x-ms-office365-filtering-correlation-id: 290aedfe-b4bb-4406-3787-08df0df8ea9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: IoMUCF4kdP2BGcp9xJpoxdZyZSNPTGHeiMPVvGTBoca+Gi/fR1BylvksM0V6SPZ3AE84iMivW4BrPmXpsYDct2yzfLqG3SwwTQCIU8gaylIyAgXMYd5cOI62QUDS1y89z4qZJ4z9qFTP/w8VHhdCYB4Z6t3uvV+vk1olZw/p22CDh5/VDTkOBesSPIfgY5i2Gtt1Iv7e9ynfUGvxlZqXIXEd7MHyCeoC4FPc5zMJrLooi7ajZw4rDU7F8ubSqY+0w0hJg6gTwo6kIu95mpoKR44wjBBp2ElU0Q63nAJQfDSjx7I0f5TZR4b7mInNHUsOq6FlceMIDnVIqbdThClgbsmx+b+S637eohlrZNIPOv2DXLUxp8hVYaetPuxj64+8G0lGIBhdmS1dtaEsTquW2TmagCo8m0I6xN9zclZ/f5UjhUymCAivWI7XpT8F00fg/YZy5I/QwgZ+OQHUkrxlmz3TaFF6PE5IsJGLMdJ3N5/9QgiLPaboFhlK0s8PjryMBJFFmXG0b/C0g21Hip797TrkOhikFA8B4M8XSF239HAI1l/IGkjPRYx4vzxdLu4BF8WEWN/OESLWmdr6HlTTvNT/6VGbGc7kUQ0f6u9S3QDs0V2Mj4MpbGxdC3ZmVIDKqV+jIdoyrCL6ss9vxmLchT0Nlk7eqhFyidnSKr52qZYZnJ4vWQNh/rBJshdxknt2TVOE+UmsDSsN+pioUjfKa8TA9HYdfo+1SELE4WIu69w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3h5ZmllRlFxVno1Zm1YbE1UMXdCc083MmVXNUJHWlR3bVFJbHJSQU0zWXBJ?=
 =?utf-8?B?UEU5N1NuRW5xdEFLcmdwYVdTUjZZSUZ4MVZ2cXRaY3hNY2pGc1MxZTVxcys3?=
 =?utf-8?B?OCtzWUhhdC9tQTZxOFVDdW5Vc2hCMDF6RVJDek80TDlEV1lHL1lMQjF0NVhE?=
 =?utf-8?B?TTkzRXFSa2tJOXh3aVprUVhMQXhJV1NJemtOVVlocUx1UGVSRUdyWGEwdjRx?=
 =?utf-8?B?N1lLZlp6SisxR0FQdVlkRm1oejR2MzNGYnBDN1dzT3FFaXN6WFpXaStzNndo?=
 =?utf-8?B?NFYxZittVVFhL3kwU2xoaU1tYStpZE9PZEFOdjlnNmMvMTFWdDlqdnNDL1JH?=
 =?utf-8?B?VFlpR2JtcEc4YSsvcXlya0V5TThkbC9wR2xiQ2w1dm82dzNjN2dOclZDZE9D?=
 =?utf-8?B?bFUxN0llMUx5NFlST1AwZzhhdkNWWXRvOUx4anlTM1pzdCtPUnZ0RVdCSkh6?=
 =?utf-8?B?QlRka0NhUnVxaC9QY0dGWFMreGdpSFRsQ25WejRHM3pFNCs5TDZBTzRKY0tB?=
 =?utf-8?B?alhGZGNvczJ4WWtlZXFuRFZTV0MwMHR6bW5kL0xucXQyYXhJazRoMzRXWEgv?=
 =?utf-8?B?V2xWaXhkdXFHeU5tcENJVzVybTdnUTdOb0tibHZHVWhJZHo5YVdpd1FxeXRZ?=
 =?utf-8?B?WE1vanB5d2JuL1ZSZ2xiY0JlYktpYkg1TTUrUmp1UFJITnlua2JtZjQzWDcw?=
 =?utf-8?B?am1jWkJoOEd2dUtFSFlVRjZIMW9QTHdwWTZuNE13K0VVbVBhamk3VlpSY0JH?=
 =?utf-8?B?WDcxOVZjcm4wZVBHM29odU1rSUd4aVkyaEpETzloMXdQSk9VUGVIOVJxQkFz?=
 =?utf-8?B?eXFIbGdHSU9JZTI2WWt6a2VxNUZvTmxGRVRLYUxXM0VhTVVuem5rMHdoVXNZ?=
 =?utf-8?B?TUorMXhUcnRhTHhqMEE3WWpZWitKcXZsbkE4QjVMK2JKaTFsT1k2U2M4SDNQ?=
 =?utf-8?B?RGJTYVFUbUk5VWwvcnZTSGxMb2ZMUlROdEM2Tm1WVkJEVjE0MEY0djVvaDNG?=
 =?utf-8?B?Q2VVWm1jYS9iNzYxTFBJR1E1bGU0cEtXcmpRUGRLUm9xOFVDRU5oUUhxTjd6?=
 =?utf-8?B?K1lrTlhybHduMlkrNmZSNzBvQktHSXlUTFcrc1RaUEJWWTE4WTVDVnVNNFhY?=
 =?utf-8?B?cnF3dC8xS3dxZy9hcC9hQmt6MDZwNEI0a1NJZDVHQXN6RUVyejB2dEVRRFkx?=
 =?utf-8?B?bFJmMTMrUW9SdlpUaEtxTE1DdjFXalo2aGNoWkRPanVFWHExblkyeE5OdTg5?=
 =?utf-8?B?VXhIa0NDZEwvNzQxeTdydGlhUlZRbXFJeG82ODc5QU1VV0lLVkNOaGtnckZm?=
 =?utf-8?B?bmMrK0NXSm1rWGtwTWNCUTlXRzgrdVFmVlhtbEUzSFluNVB2ZGYreGxreTdm?=
 =?utf-8?B?dld1Ylh3ZVFMMkY1VFZpZjBTQjZLbGlkallzUWg4a2Z0QjV6T2NPS00zS0ND?=
 =?utf-8?B?RVMyWEFZSUd5VXFZZ1ZMSG50SzkyN0Q5R0ExeW5hOWN0bm9kdk5MQmlmZWYw?=
 =?utf-8?B?WnF5ejNISFdyS3N0Z3hBZ2pRZGZucG9GMjEyVWkxZFBRcjlZTmh6SlAxczlD?=
 =?utf-8?B?R1pxQjd4RmlpbDM3MWo1UGVJNlVDM1NROGFibmlaMndJc0FpYjUrN0V1cStu?=
 =?utf-8?B?TitMUm5CSjB4R3g1Wm9vb21uMTNqbnJFSUt3ck5wb0FEMmMvL2RwQlQzZW5C?=
 =?utf-8?B?UlNmQldOa2xycGF1MVlZeE04MHhkVUxpWWxML1l2L1BseWVQQkE5WVNIMDl4?=
 =?utf-8?B?cFVxNGFxekd4ajRmU0YvbldLdG41ZmF2N1pTcklZVXhRbFZWNWMwOVEwejZ6?=
 =?utf-8?B?Q1c3TGQ2NmtlajUxZG1xYkdPRU5zdm0zMExncU5jNC9mKzBmclJDNTRzY2Zq?=
 =?utf-8?B?bmRJeWpNQUI3WGhROXNLOWg3L2Z4NGZXOUpMWm1ZaHdVWEVxMVd5RTZDTnB2?=
 =?utf-8?B?WDRUTTZoWXpqOEthYUEwbTJtWXZnVk95dTNEV09mUlhZd29OejJ0RUl1M0Ny?=
 =?utf-8?B?N2UxMFUxQ3Q0aStHRlQvNDl5SW9sM08zeVk4SXZUODBrcXAweHJ5VG1uS2pD?=
 =?utf-8?B?bFFwYXk1dzhxRXVXQ3oyaWRtc0ZYd3FwQnlmNmFkdXB4cEZ4aDNWeXNCRVV4?=
 =?utf-8?B?U0p3T2FMVFNybXU5NHM3bFFWaFcrSEZLY3VSK2xLTHJMbzJoWllyaUZlVzFx?=
 =?utf-8?B?Sllpd0ZGcmh1ZTFHdGZoUTJTL1loc3FkbkJKOHRpN3N4bkJwRUJ5Y3d4STVW?=
 =?utf-8?B?bFcwc0NmeGlZbmhJUnJGV2dhMjBQd3U0cU1ya2VreGw3WmdkblBaRzU5aTJZ?=
 =?utf-8?B?TVJ2QTFtZ056L0t6VEJzSy9VR0QreFVRYXA5bWdhbndYc093OE14MnVYVGxJ?=
 =?utf-8?Q?/rPmRduRb/CmklYg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37E030EB9E32AC4D90C89E35EE712655@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k8o4q4En0bxj5TEA1B4cYZgzkL0WC4DHvfFzsvoWtp3bul3CZeni7TcR0bYNLlCpT3asZOlmloWOuG2Wwz8U7h6KPifZTvwDbMDHQGW/+3qZAYTXxYb6oKm6koQo35ZMgWtka8auewrs2Q8ymtfHPfFs73YbrX8dkkRqSqajLO2HGIPlNr3LqCxWDu6CqIskTiMB5uC/LGr+B/snKEGgpWaYGHskBj108luZvTA4YwsxgRxGla/4yfNIhTixJsQdpZqdHY0nNzV8aOwRAuhN3xIIzvItnYOuBhflguBkET8uHBDDGHl/BpwsaF/AmRVtieZbkVYVGubOGK2I2HFljQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290aedfe-b4bb-4406-3787-08df0df8ea9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 22:31:24.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwGhWVuP+435Jgr0onOrCw6LG8ckEnjFPIpenEq2GYTU+Pwo75gOb9aPUvIRdc/kPgRpYF/kxaRa9mIBB7Lhvz2mh3r3me0ZMjT/hbM7LGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6730
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTA4IGF0IDIzOjMwICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiAqKkRpc2NsYWltZXIqKjogSSBhbSBuZXcgdG8gS1ZNIGFuZCBURFgsIHN0aWxsIGxlYXJu
aW5nLCBsZXQgbWUga25vdyBpZg0KPiBzb21lwqBvZiBteSBjb21tZW50cyBhcmUgb2ZmLg0KPiAN
Cj4gDQouLi4NCj4gDQo+IFNvIG1heWJlIHRoZSB3YXkgdG8gZ28gaXMgdG8ganVzdCBmb2xsb3cg
J21zcl9wcmVzZXJ2YXRpb24ucGRmJyBhbmQNCj4gYWRqdXN0IHRoZSBhbGxvd2xpc3Q/IEkgZmlu
ZCB0aGlzIGFwcHJvYWNoIHNhZmUgYW5kIGFjY2VwdGFibGUuDQoNCldlIGFyZSBraW5kIG9mIGRp
c2N1c3Npbmcgd2hhdCByZWNvbW1lbmRhdGlvbnMgd2Ugc2hvdWxkIGdpdmUgYWJvdXQgaG93DQpt
c3JfcHJlc2VydmF0aW9uLnBkZiBzaG91bGQgYmUgZGVmaW5lZCBmb3IgbmV3IENQVUlEIGJpdCBi
YXNlZCBmZWF0dXJlcy4gU28NCnNheWluZyB0byBmb2xsb3cgbXNyX3ByZXNlcnZhdGlvbi5wZGYg
aXMgc2VsZiByZWZlcmVudGlhbC4NCg0KQWdhaW4sIHBsZWFzZSBkbyBub3QgdHJlYXQgdGhlIFRE
WCBzcGVjcyBhcyBzb21ldGhpbmcgdG8gYmUgaGFuZGVkIGRvd24gYW5kDQoiZm9sbG93ZWQiLiBJ
IHRoaW5rIHRoaXMgaXMgc29tZXRoaW5nIHRvIGdldCB1c2VkIHRvIGZvciBURFguIEkgbWVhbiwg
dXBzdHJlYW0NCm5ldmVyIHdhbnRzIHRvIGFkYXB0IHRvIHBsYXRmb3JtIGFyY2ggdGhhdCBmaXRz
IGF3a3dhcmRseSwgYnV0IGl0J3MgZXZlbiB0b3VnaGVyDQp0byBzd2FsbG93IHdoZW4gdGhlIGFy
Y2ggaXMgbW9zdGx5IFNXIGRlZmluZWQuIEFuZCBmdXJ0aGVyLCB0aGUgcGVvcGxlIHdvcmtpbmcN
Cm9uIHRoZSBURFggYXJjaCB3YW50IHRvIGhlYXIgc3VjaCByZXF1aXJlbWVudHMgZnJvbSB1cHN0
cmVhbS4NCg0KDQpIZXJlLCB0aGUgdGhpbmcgdG8gZGlzY3VzcyBpcyBob3cgVERYIHNob3VsZCBk
ZWZpbmUgbmV3IGZlYXR1cmVzIHRoYXQgd2lsbA0KY2xvYmJlciBob3N0IHN0YXRlIChlLmcuIGJp
dHMgdGhhdCB3b3VsZCBhcHBlYXIgaW4gbXNyX3ByZXNlcnZhdGlvbi5wZGYgYXMgbm90DQpiZWlu
ZyBwcmVzZXJ2ZWQpLg0KDQpUaGVyZSBoYXZlIGJlZW4gc2V2ZXJhbCBQVUNLIGRpc2N1c3Npb25z
IG9uIHRoZSBwcm9ibGVtIHRoaXMgc2VyaWVzIGlzIHRhY2tsaW5nLA0KYW5kIGFjdHVhbGx5IHNl
dmVyYWwgYXR0ZW1wdHMgdG8gc29sdmUgdGhlIHByb2JsZW0gZHVyaW5nIHRoZSBiYXNlIHNlcmll
cy4gTW9yZQ0KcmVjZW50bHkgYSBob3N0IGNsb2JiZXJpbmcgY29udHJvbCB3YXMgcHJvcG9zZWQg
dGhhdCBhdHRlbXB0ZWQgdG8gbWFrZSBpdCBzYWZlLA0KYnV0IGl0IHdhcyBub3QgYWNjZXB0ZWQu
IFRoYXQgcHJvcG9zYWwgYnJvdWdodCB1cCB0aGUgdG9waWMgb2Ygd2hldGhlciBoYXZpbmcNCnNl
bGVjdCBzdGF0ZXMgY2xvYmJlcmVkIHdhcyBhY3R1YWxseSBhbiB1bnByb3ZlbiBvcHRpbWl6YXRp
b24uDQoNCk5vdyB0aGF0IHdlIGFyZSBtb3ZpbmcgYmFjayB0byBhbiBhbGxvdyBsaXN0IHR5cGUg
c29sdXRpb24sIHdoYXQgZ3VpZGFuY2Ugc2hvdWxkDQp3ZSBnaXZlIG9uIHRoaXMgb3RoZXIgc3Vy
ZmFjZWQgdG9waWMuIFNpbmNlIFREWCBzaGFyZXMgc29tZSBzYXZlL3Jlc3RvcmUgbG9naWMNCndp
dGggbm9ybWFsIFZNcywgd2Ugc2hvdWxkIGhhdmUgaXQgd29yayB3ZWxsIHdpdGggdGhhdCBjb2Rl
LiBTbyBmb3JnZXR0aW5nIGFib3V0DQp0aGUgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uIHF1ZXN0
aW9uLCBob3cgdG8gaGF2ZSBpdCB3b3JrIGluIGEgc2Vuc2libGUgd2F5DQp3aXRoIHRoZSBzaGFy
ZWQgY29kZSBwYXRocy4NCg0K

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E449ECB;
	Wed, 29 Jul 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323435; cv=fail; b=TTROb2SBggTEhdzs2ZOhzGL90UVP95wg5p3HVysQffBbmhydbqAdz6ZsHTXR1VcS7fp5siwkJDcEq/GNRCuLQPMT0KPt+zs6p0HO9nYF453yOaya6w00P9tuWC8CDeEQ/I76O4PMeYvWbSVX+Y0QPzBx8Hbv5G4pk38Us1vSRUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323435; c=relaxed/simple;
	bh=jNu+RxwMxKaqxO2MsnE2N2vr9vzB8z4WDfN3lNOn2cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HaEqnjDlX5v7k71gw1KXPZEKChPvpR4hPpd1k/86M74aRNYVV5AmHY7USgiblareESMMijc9VaO4aIzRyWSJEkEitcK4cDjO8TldPa4Vo4oS63RN79ZL7hywbrJ5TwSSovk6bKK8qF90GH/1QSeHboMtbvcoBGdWIQU0Jv0kxbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2ungKXq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2ungKXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785323433; x=1816859433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jNu+RxwMxKaqxO2MsnE2N2vr9vzB8z4WDfN3lNOn2cY=;
  b=H2ungKXqszxa1BN1v8PkBWAuDYhsItsAwPl19tjVZlh+Xb8wSso9drjt
   jZGP+DTJk9wZJc6Pp5PkVH4o3p/HizO0KpizpjWVE1KQvuW9hPLaeJhmR
   VWQ+vR6m4sFmanv6qVXp8lqMLamA6Iib3yBPtnowT3ELW3rR4I6Iu6rdi
   1w77m6Ke1nz+VebEW9WszN6emV/JWPOSIoEtPGFQzxggMgCH8/T3zjEPh
   /W4yOpH6vHjaUHEFFF7KRY3qehr0CU1UPNXMCn5KbMj01P69nGAGB11Pl
   +zOE+3hA7ZLxJkgh9erkxeIuR6592xkPGQq+haMoqz6Je83DuDFh3Zz/l
   w==;
X-CSE-ConnectionGUID: 8kA3PeVzS3K4EYExJA/pzQ==
X-CSE-MsgGUID: 1ewvMunGTgSlp5MWjoeD9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96283987"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="96283987"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:10:32 -0700
X-CSE-ConnectionGUID: dbxfNksLSu2KzEWlnXEi3Q==
X-CSE-MsgGUID: sU6avZcbT76pIaaivXQJZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="259391808"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 04:10:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:10:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 04:10:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp9uq4XCtaLro4Q+/V2D+m1VNtUhiqcuFRA54SqS5x4XypZImL4rTQZWStGJljCfOCaaa2duYGgbFfbJZtW4+UGUJv2v2cVMXNDx+ZZr5STaYkiRCKP9Np2rh68238Og9OcGczxre60HwxUTVJNx5AMzEQjfFM4Ov2GvLoSUz2rCeUSFcC6pY1WVykJUJCSwLBZn/MFnc8xM98iSdb0/tjld141tZcFTcmMY8QSTzorxYW1irLgnBRQ2bjQsB8KSbkDCnp9C0EPirDozOrIdq3gbtRy8K2Xc2n8QwkJCu8/8tfF4LGkVm6saql/Sn6Pe5eydk6e8PTI2HKLzK5+EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNu+RxwMxKaqxO2MsnE2N2vr9vzB8z4WDfN3lNOn2cY=;
 b=vUEpg4GMuXrwUy944ctllAQHstcAeC/oJdpM8juF1l3L+kjnKPtGZKt/0c9eVi2xr+TkKXNdGGAM/jiCecvGXcUQf9JyDJMjhX71Ba7AhXIutPFcX4m/XzgG2JFKpExIHmGtCZOAcB/5RBLJwlBFDRv6qulBlU7WKd6+mf72iVaCaqPWmIoUKqlaW9KYfuSOEDthivIWOm3+cxtrhBcxkusZiKJcIDsFNaJ3tVLpNSeMFaSXdpIMUoDn2YHV8XbVi3b0fHu076vRedcy6FYOTLgMm1UL2ndQxJ/lLAg79U3f2TGovV+VvmE5dnAvq3eQjraS5zPDiMgtqEi25iPjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 PH7PR11MB7028.namprd11.prod.outlook.com (2603:10b6:510:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:10:29 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 11:10:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jthoughton@google.com"
	<jthoughton@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in the shadow MMU
Thread-Topic: [PATCH 2/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in the shadow MMU
Thread-Index: AQHdHieBmkJO++R+x0WhxxcLrskcr7aEWWcA
Date: Wed, 29 Jul 2026 11:10:29 +0000
Message-ID: <ea32bf304cb912380e760c2c7267d4db53765c68.camel@intel.com>
References: <20260728002236.869865-1-seanjc@google.com>
	 <20260728002236.869865-3-seanjc@google.com>
In-Reply-To: <20260728002236.869865-3-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|PH7PR11MB7028:EE_
x-ms-office365-filtering-correlation-id: 4d6eed7a-4efe-4659-ebdd-08deed61ffdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|38070700021|56012099006|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 4mM2F5tHEX18hDthy9ORgP7o+caUCq+kFMVJESNNOuqizOoDyI6GpbfZdmycLe0wExqtleIYU1DUpGs2M2xKuz7kTQCynPQmmMuJD6FqsbnVLXTOpy1ZJk4vPGbC32gGXPv5sz4DgKDjw48/cLofa/9zf8JTVOHdyH4dE41LvRgGGobIqdM32S4x7wzaYZMNDUvGmXEPcN95JzwRdtkAXDVyW9LMI5tMewn/jDzepjd+snc3dQrc38qEslibF4EnBCrTv1QM2r3fKnsHcvU6REng1qqYuxPwRqV4jjCzepSig/hn+StQ3bEFHSLOPoqLW8uPyVP4H6DwxsQlenMy6ermv/5CBTeQf9A1lwtIBBwmefehL7fPHDBHjeabgrlc9svRmo6o7HEYDKZhFBxAm4nIUdh24RQb+XNO6kKix4iANa8xAJHo2wowo0JyyCdVsOqWiydpTb3V1lqpuTHkUZ1ReckPsI94OsTtW+kM8Jzyq0kQgYKuukpSqt+LHGs+mg4bkVNvzDPpSrHN3wHVmsGmWLcic3mKrgoZioFgDKp4jRJB4JZGK2HbHyKXsRlxAgC69foxUC4ouF8Tq6wTnPX/jIgcAG4F4zNkOv3VbvCliHxutzJb8KxKhXShOYCKcm7E8CC4aiikyoC2HO5zdlvE7chPo7Xe7MFzgOF7i9vmQQschazE9YZZBFpCDFM/s5uqyO3Oz4yvbk7XEGBvNljhrvx+ZLlAIu9ObwKndss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBYS29rOWNqVWQxT1FRTHkzcWpVOVFZZ3U3ck1TOFlDUGRSR0FtblZQcjZZ?=
 =?utf-8?B?bENnNmtJaTJINisxdGlNMWFXNTYwZnI1dFFpU2xDTTlMdUsxbjRDdmR3SzhT?=
 =?utf-8?B?U3I4QmptSXY3NTQ2R0xGUUtGTTlEQWlzY0FhaHJ3UjZqZEFja0ZZVkY0bWZW?=
 =?utf-8?B?S0Z4SmMvdkxlRHZ4NWhFSERwQlRzdXZUeTBVUUdxRnkwam1RNGNCRGpoQUNn?=
 =?utf-8?B?V0lXbWRtcDRENDFXTDZZempNelMyRGUzd1ltMGVac2M3ZmVpbG8zeDgwR1FM?=
 =?utf-8?B?Qy9qZVYvcEZnNXNMK2lFL1V4QllyRjY5SWxoR2VpQVBmdXhWZjhLWG8zNDZy?=
 =?utf-8?B?RGRXRmFNUXdzdWVTbzRtd0UrbGszOWZIdWEwRjhYYVNRNmFIRGYySnovTThR?=
 =?utf-8?B?Q2dvaHZ5a0p5eXhTdGdDaWxEODVPZGJiczVRcGJkUE91L1BEOTk5eTFTRDBW?=
 =?utf-8?B?VTBrZmk4b1JSbzljTFZCRnRuVzEva1gwNjIyWWUrMW4rYVcxYTV6ZkZQWDZ5?=
 =?utf-8?B?VmRmamNrVUxrSzFrS2gyN05DSjBMTWJVTUtpWllKNUIzR2p2YXRRRlVmaEJo?=
 =?utf-8?B?K3NKc013OXZKeXhRRTVabDJwZzZXR2R2S2JITFo5WjVseWppSEhOdzlIaDM3?=
 =?utf-8?B?WmlLdkRuR01KUTJ0U2JucTByN0xrdVBxWDZmd1J4M0RLODJ3WTJSV25IMTVK?=
 =?utf-8?B?RGRjN2dFRlVKUlV1dDJUNE1RU1JRZGY5WFRNVnh5RlpST0tQcGZBc05SQ1lw?=
 =?utf-8?B?aHJDWEpKeTVEV2dyQ1BuK3lXaGlEcTBpYnVDWWt0d2hpcE9tTjV4b3VaYlZ5?=
 =?utf-8?B?cWdTb0U5cmRpUkVTZ1ZOOWU1Sk1Jbk5yTHFpc255eGc3UzF0SXg2RUhsYXpj?=
 =?utf-8?B?OWhSKzVSb2poV01vbExkWWpnWlFlNzV6NFM4bkJ6YUtvZDhjajl5RWJ2Y1pQ?=
 =?utf-8?B?dFlmVTFDNlVRZ0dPaUI4T1RPTHBXREc3Z3hoSENsc1duekFTcUUxaHFwVkNy?=
 =?utf-8?B?My8rUmhEalR3eHRlWVI2bUFKTmszRnVBUStCY0RDcSt2cHFtaFUweTIwQUFo?=
 =?utf-8?B?S1U5VTVFMVZZc1Vta09JekRyRGpKN0VpT3ZXSkpDQkpGa3pzK0tqdytWYVFJ?=
 =?utf-8?B?MktPRFRDbkdPaWwzT1FoOWZUK3FmQW5GUDc0Z1JpQ0daUnVHYmtEWmxoTWk5?=
 =?utf-8?B?UG5ZTThWOTFORTFKTXdwQlRwUURXRGIxemFHS2s0clBiTisrMWx0QTVoOXo2?=
 =?utf-8?B?VE5xcU5xZGNJbCtFMHdqa3dmeXJWc0ZCWWxSMHZKQTRCN2Jqays4YUE4Rms3?=
 =?utf-8?B?M09NUjFLblp4dkhJd2lPanZFUHY5QTlHeFdRbi9oVDRpQ3ZaMDFLRXBoUWd0?=
 =?utf-8?B?ck1nd2VIK0lnU1ZReXhpLys2cDlyQjE4VVJ3amEwVEdwZmdTdEsraWttbEIx?=
 =?utf-8?B?djJMZ0xkRGdhMFpDU093RDliUXVmeUFDSEFFZUZjQms0TGF1L0FsdjcxNk43?=
 =?utf-8?B?RWJ0ODNJZDFzY2lISkFJaHRJZWlWbnJ1OXI3dVRUN2oxbUZrd0JiT0tiU2NL?=
 =?utf-8?B?eXZzOHhWcDR4bElhdzRDbnh4eCtGbzRKQ0Qvd0twb003UExHUnBtZDRndkxO?=
 =?utf-8?B?dEkxcHNxb2tPTm1SUEpzck5xNjB0eXZCTDllemxlL1JZYW05NUJSUUx6OEhw?=
 =?utf-8?B?QjMzTXhyNDdad0Q5TGdzb3pUQmxDd09XRWhLS2ZkQ1oxK0h0dEdkeUlMNHZy?=
 =?utf-8?B?MzNrdGQ1ZWxnK1dFazRNdnA4aWx1ZENySU12VVVsQVdjMDlaR1YydGp1YUwy?=
 =?utf-8?B?UUxWdWZHbnFFd0lySlBWRVh2NC9YeG52TmpUaEc4ei9SSStna0p5Q0tvczZE?=
 =?utf-8?B?T2hNOW1kNlZidnl5cURQN0k5WUpmVkhrMzg3VzFFejF5dXlNanFmbnZQNG1K?=
 =?utf-8?B?cWpJemt4cnNHKzlYQXFiL2UwMm9NcWFiK1lFR3dFNGJnNEFtbWwwK0ZNUHQy?=
 =?utf-8?B?TkxwYzJlMzA3ZFFpNHhYeHdrb3NWa3pDZjJnQnpKZlhCR0lvVzA5N0lReGNB?=
 =?utf-8?B?Zm9vSkNoWmFETzlxdzRUSVIzSlZMNTVFM0tKdmtoMmpKakRnQlhyMWg5MWU0?=
 =?utf-8?B?dDBGT2NVQ0w1c1BjemFpc2tNQnE1U0NZbmttQUhDalVWQkJmMHhqMGpjR0pl?=
 =?utf-8?B?Nm5SeXl4dVJRbnpRTFd3ekRBQTBTQ2hjcFJQdTNQdWdKbVRIZk5oTHFjaC9C?=
 =?utf-8?B?RHNHZDl0aW5hNEtPdDZURlA3Q0RZZTkzU1kxdDRvNTJ3MXY2d2lyc2FSSHc5?=
 =?utf-8?B?ZGZ0N2ZLMEMxZFNTMzhPVFB3cDF6ajZvcEYxUmI2d2xIOWg3SjAyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7382D133CD075A48AA4F0FB24213A01D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kvXaGsMu84/iUPVKqHb2BK+0Eo8jfzE6fZd7i0Id2Os1TjPtDXmrErPe7wwFmFjUTHaYLu+3uDJkOLykdx2V5mC+SXC3KZAeQdKLyzRmhs4+8llXgwNRqe2mGauSMX/gGTJNj4USHXgmoNGROgBzMaN7LD6NtkIDB5a+6HOxGxvvRizL61q/TSnz0PfhnPiHlmjjPJhqwWrzWYpkD/9UfA+xA89uxvHpBhDr+MEOeOxn5u/3Sf0/jQCQmW0Md9w/tI6DqYTCSkEUFafnND3C2SKCXJB9h17Sl6bVIoAhFkZ217TAyQlRQ1bgn9TLDUnPoNWJgLQmOnCX3q+bW95OWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6eed7a-4efe-4659-ebdd-08deed61ffdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 11:10:29.3110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzBdDbeqsaq6qeYGYr1QgNYAmOYhmGlgkZcllTTk9HqRPmEbNkJM4b2hB83o5pShhUGPafzHEa30EQQN/752mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDE3OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBVc2UgQ01QWENIRyBpbnN0ZWFkIG9mIGNsZWFyX2JpdCgpLCB3aGljaCBjdXJyZW50
bHkgZW1pdHMgYSBMT0NLIEJUUiBzaW5jZQ0KPiB0aGUgdG8tYmUtY2xlYXJlZCBiaXQgaXNuJ3Qg
YSBjb21waWxlZC10aW1lIGNvbnN0YW50LCB3aGVuIGFnaW5nIFNQVEVzIGluDQoJCQkJXg0KCQkJ
CWNvbXBpbGUtdGltZSA/DQoNCj4gdGhlIHNoYWRvdyBNTVUgdG8gYWxpZ24gd2l0aCB0aGUgYXBw
cm9hY2ggdGFrZW4gYnkgdGhlIFREUCBNTVUsIGFuZCBiZWNhdXNlDQo+IHVzaW5nIENNUFhDSEcg
aXMgZmFyIG1vcmUgcm9idXN0IGFnYWluc3QgYnVncyBpbiBLVk0uICBFLmcuIGlmIHRoZSBTUFRF
IGlzDQo+IHNvbWVob3cgbm8gbG9uZ2VyIGFuIFNQVEUgZHVlIHRvIGEgS1ZNIGJ1ZywgQ01QWENI
RyB3aWxsIGZhaWwgZ3JhY2VmdWxseSwNCj4gd2hlcmVhcyBjbGVhcl9iaXQoKSB3b3VsZCBwb3Rl
bnRpYWxseSBjb3JydXB0L2Nsb2JiZXIgbWVtb3J5Lg0KPiANCj4gQ2xlYXJpbmcgdGhlIEFjY2Vz
c2VkIGJpdCB3aXRob3V0IGF0b21pY2FsbHkgZW5zdXJpbmcgdGhlIFNQVEUgaXMgc3RpbGwgdGhl
DQo+IG9sZCBTUFRFIGlzICJmaW5lIiwgYXMgaG9sZGluZyB0aGUgcm1hcCdzIGxvY2sgZW5zdXJl
cyB6YXBwaW5nIHRoZSBvbGQgU1BURQ0KPiBjYW4ndCBmdWxseSBjb21wbGV0ZSwgd2hpY2ggaW4g
dHVybiBlbnN1cmVzIGEgbmV3LCBkaWZmZXJlbnQgU1BURSBjYW4ndCBiZQ0KPiBpbnN0YWxsZWQu
ICBCdXQgdGhhdCBjaGFpbiBvZiBsb2dpYyBpc24ndCBleGFjdGx5IG9idmlvdXMsIGFuZCB0aGVy
ZSdzIHplcm8NCj4gcmVhc29uIHRvIGF2b2lkIENNUFhDSEcgYXMgaXRzIGNvc3Qgb24gbW9kZXJu
IGhhcmR3YXJlIGlzIHdpdGhpbiB+MS0yIHVvcHMNCj4gb2YgTE9DSyBCVFIgKGFuZCBtYXkgZXZl
biBiZSBjaGVhcGVyIG9uIHNvbWUgbWljcm9hcmNoaXRlY3R1cmVzKS4gIERvaW5nIGENCj4gNjQt
Yml0IENNUFhDSEcgb24gMzItYml0IGtlcm5lbHMgZG9lcyByZXF1aXJlcyBhIG1vcmUgZXhwZW5z
aXZlIENNUFhDSEc4QiwNCgkJCQkJXg0KCQkJCQlyZXF1aXJlDQoNCj4gYnV0IDMyLWJpdCBLVk0g
aXMgYWxsIGJ1dCBkZWFkIGF0IHRoaXMgcG9pbnQuDQo+IA0KPiBDYzogSmFtZXMgSG91Z2h0b24g
PGp0aG91Z2h0b25AZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhl
cnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQo=

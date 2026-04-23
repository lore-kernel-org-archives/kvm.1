Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7233D6F9;
	Thu, 23 Apr 2026 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980929; cv=fail; b=mRN7rLC3Kes5PrMDWaCJY49fK2g46PcH1mDG9ub9TfLPdL8EWVDm1He/CAhFIwygySqsshSYP4QVzxhamW+/B6mdnYOzZDkgTcUvJI+fQ3AHeHpsUx2x062wX+eBJRsSgfNOKAAW+JckIjVnwBTQIuh/PwpImhsD3qJeCU9Vqws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980929; c=relaxed/simple;
	bh=3jzHqesfuHj7dHqkocYKTkdKx8n9fEsXLExF4K9nAYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXK5/k8d7/wUS+KaNwDHFVxVfQCOBFO2x1o1IQR7o4Qs7z2G8MpK8iL37a+62JlRh70AhlZKu9vLkYgy4TylKwm9wJ5Xi9Kl22ug8DK2nrf6GXnJ6mdTaM62n68mtlmyxnlcaa+dm1sjoSagT0ggT1ILtSQHB/WIcekLqDpa0iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Esubuomq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Esubuomq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776980928; x=1808516928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3jzHqesfuHj7dHqkocYKTkdKx8n9fEsXLExF4K9nAYk=;
  b=Esubuomqu22BuAiNsJRAdvxfM/qE81lWENmEGZNOSQVA0HMFloI8r+Dh
   3ds3/shwUI+HeCJ5NIcDEuH4K+YWlXkrUduC2PsjcG114w3u4+E3Q9W/7
   12Wu8WqzWAPbz+OO3Q0GhPevyokJTYeIw3nAnhIxQu4PPwpQ2s9Z6nqVw
   8FGXrh0LHQCtPWEFsqfYHGZSwu9vaOOZ/WtEVKmTxN730kvIDze+SLE7y
   oFwvvQSkJKkiTJc9uyBjRdCMfAfaVuhzie9oK4paCYQiLe+4Ulf9NXkzw
   aMq6KFn3rbXJEzEBkd+SYWHNIXpVRUWRH0luCK39W4m1U1QC9HSb5SQ8y
   A==;
X-CSE-ConnectionGUID: SjA28D3tShWesedXYHpL4w==
X-CSE-MsgGUID: d1QSW8yFT+asbZAl21riDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89042754"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89042754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 14:48:48 -0700
X-CSE-ConnectionGUID: y5LbDDXqQSymRpG+Qrls+w==
X-CSE-MsgGUID: YgN5OvvPTZiLW8yeYp/C+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="226242571"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 14:48:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:48:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 14:48:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ/G1CJ0GVZHk4vhSPEQFt7pL/QW2bpJXRBsTuggcPTd959pqQld7nwAyEn+qVVxXbHP9NDFs3Cif8CLxrqcnFgACtrnIW/YsTuBHkvG/0AU3IRy48zkW+ljNa+VA3FcoL+/uZQxinZ/ARthuY7JAnOp8F8NmWevWYiQjM5eRM9SfeQb3lDMCgwdLf1fRSzCQ+hX6kgV6SQYXqjzVNaYUBemixyrtIuDUBd+Y7949RW6mWkQIVcAH9f+w6ebdiDJwkrAcpC2jKT2W5o7BrFVkANKlPFpiY/z4be7AJL2M5yICzLyozCMUfb+n9FmjLj2Ty/Nc3+LBMz25EvqupeSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jzHqesfuHj7dHqkocYKTkdKx8n9fEsXLExF4K9nAYk=;
 b=oRRx5cINT7AQkeiKfnrDGpHWp9pJVIUWnbIZS4S//fGxLgq3LBmoLBEPk4PP5eEIMRFcUvU3kNYmScWyfLLx2uLUllfK7MgddXkUubkwvShgyhHgvbwm3WvhN++TQCQRFG+aMCiZ9n3Y/zspMTHqnyeo/iXhFZhUWAPQPOBSb+3OYRRtfzx5gbBCV1BqhE4GHOK4Io+m+SZtrOzNo1WvtBmaVWY9Cb26S5qPJWO5DmsQXHseuhezl6/uy+bz/t61WEz/o8oqzYsQ05cKt11OFcNDe7MxvYlAXDDymTAjhoBEApvu3jmX5e8fvdFN5iepq5I8PzQYYQEZpBGYMmpZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 21:48:37 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 21:48:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 1/2] KVM: x86: Ensure vendor's exit handler runs before
 fastpath userspace exits
Thread-Topic: [PATCH 1/2] KVM: x86: Ensure vendor's exit handler runs before
 fastpath userspace exits
Thread-Index: AQHc0z9Jujcv7fIz+EarE/9znwmrS7XtL2EA
Date: Thu, 23 Apr 2026 21:48:37 +0000
Message-ID: <36ba7f79bcc090802c5e1fe48e0576088f1b7492.camel@intel.com>
References: <20260423162628.490962-1-seanjc@google.com>
	 <20260423162628.490962-2-seanjc@google.com>
In-Reply-To: <20260423162628.490962-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB7298:EE_
x-ms-office365-filtering-correlation-id: b210098c-5a1a-44e8-0e3d-08dea1821348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: iUbT4XywEvG88dlf0vOqXvoV47DYsVDzIZDHHzsxcoLYVC0yP2e44M03TEs3C/q/KcIqoVFkq/19NnqGwqnMvctNJZiSgSWrKqickaDpXunbpuyNz1aGsIiMczxmNA4RvZVPEhu3K8weAyJAWGYGc9q+WmPS6F2zzBORzwQ0YGhhRvp9cyWYz38ZUqJh8tpEvqi3kF5Qs72PhqqgOloUDEunynT376afH8YkgOnFbWkCTO+k9W31kLEJF8JeMjr7lFrAiPA17W8lMrAs2G7rHJI5wAzA0GJsAgqeoQJOO10rCkGruKOn1zHB/SGTM/YV9U+b2S0iwPSgSBXN08At24q7X3tHHY4Ha8ceDSB37qZSnIE+GTwDZ57sKLVAodK8g2KTJspyESgwYlJidyFPXMRW0I+qTibj5WO5bUWg4hMJJsh3Ckw1RP9gxY+1pUPnBiScqultQE6oHpIPX/O3fOPtN2L1cGtgfuuh8LUB+KzmPhrNsG3GeHUe1+wnR3bge1WT/T/YcpVuDQSJWk3HU621En6okpG3/hQ5wUvme7WvhB+ZjtIaap09DOSJ/6xUIkL0DEiofyPUqbFXtAxvvSU154Gs4bFu7xHuIX0lfIVCeGEm4J9ptVQZqPVcP0rsGkcKTNwm3mng9oj0JNg3QAhEU4+5VQ9ALp6co7JgwngYv/yJCfPPSGaarihDqiHgK2gxgxIlvMug0P261LcaHJTyuSN0DCz/PDGy3w2sMai7BpIO7gYhmfUxHamDMdNuLG4GKqOGouw2KkIKFy0HnBBJKaooz7nLynDd6WEJxkw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVowUGN6ZFdUYXp3RWpySW4vc2drM0R4S3pBNU1ydHpjOG5pVk01em40akpV?=
 =?utf-8?B?bExaazJoM1c3a2dkK0RwK1gvc2FXUEpHN1hWNFJJTHlTTTRQd0lTUUJnK2JY?=
 =?utf-8?B?eng2RkxaaFFDYnhOM3lzb09BbGowdDJTTUhWRHdDZFl2bUtpdTZwYWtHek0y?=
 =?utf-8?B?M3huVm1INkpEMnVpOVJ4bjI5dlZJM1g0eGhwdHp6MWE3WUxDYmVpRkwySFN5?=
 =?utf-8?B?cHBGeVpINUdUZ3laOVc5VVkvKzU0WjhsVnJjS1ZCaG1VMTNkc2ZnQk03ZlpR?=
 =?utf-8?B?aHJuR3ppL3l3ejIwcVRodzhCR0VSZkVCSnNNejNQVFUwRUdWRGZsejhIK05l?=
 =?utf-8?B?czJja0lrYkhPYjgwYmlvaUVObWRsQS9ZVVB4N1hTV1R1cFlZTWpqVzRnL1Vx?=
 =?utf-8?B?TW9hNmxRdjZqKy9hdjZTOFdwOUx6amJzREFzd0pZT1huMmJTUWZtR3FZeTlM?=
 =?utf-8?B?UExDMVJmYWVxR1NTVm9DZXMvSDNhTWZMdlFIV0tXb0dZTUZrMXp5WXJ6VXZr?=
 =?utf-8?B?OGFnNHExQ3hCYmZNR0RudTVLdlhJSXhEek9JY2V3WGpYYzRhdENLdmJuZEJN?=
 =?utf-8?B?dUlPcVIzVmdWWmFxRWxzS1VGdmxUVjlXNFRNWC9rU1lZYUtZaU1rVldhcFJr?=
 =?utf-8?B?MHM1eGtya2pZWGx5QkF3U21KNjVuaFByUFoweE1FN3pEQTE0Zzhlb0NQWmVp?=
 =?utf-8?B?blBMcXhSYnRuQnpYZ0dobHAwK2dSTzF6OElNemgyNjBHc1p3VWhWYnhXOUlM?=
 =?utf-8?B?YmJsSUxzQzl0WkkrbjROc0JXWHFjT1k2NUxNTmsyY3VZcnlPTXp5R1M1R0Rq?=
 =?utf-8?B?TTBuOGJja2Rud1E2emNlQVRzU3VGdHlVdjJoUDBOOUVoNldyQTVSSmduc1Na?=
 =?utf-8?B?RURzNFhXVWgyUUdLWkVlaUNhM3QzMkFabjlwMW4yQ3J4cytLUTdKdVJQeGZE?=
 =?utf-8?B?M2h4SXM4em9SNW5wcVViS28yU3c5UGx5VG5DLzk1cE5YNE1vdEZjeDZYUDdN?=
 =?utf-8?B?NjdIdEQvS3F5UUduZ3pMYVZrRC9VNGFOa0t3RTJ1Qm5aQU9sdU5UQ3hoRTJj?=
 =?utf-8?B?ZWNuQWxON3NQMlVzQ0JkcDBCY0hqMXZNa0hpRXpnc000eldTVFZpWGtXWENQ?=
 =?utf-8?B?Q3Q0a2Nza3NwQ2dMT3pEU0xXMDJpa0k2b3U5L2NQSEQvQVNiWkJ0bXp4RHpB?=
 =?utf-8?B?SFg0ZTJXUTFqR1l0dVlibkZoZ1cwQUV1Y0MvT3F0amNLUzdkaUFVcWp0VGJM?=
 =?utf-8?B?RklLc2J1b0lxK0N3Ujdrdi9Xa2tuL1p3Rit5UFo3SnZmdW4yaDdEYVhWcVpN?=
 =?utf-8?B?WmRiR1NPSWxjOFNjUjVPbHRSOGpVWm5lbHJSUHZ2eVdvampFbUR4dDZ0Z0Jm?=
 =?utf-8?B?L3lMR3IrMXdCdmcwWGpLZkgya3pJR1QzbkNZSnJCSHpKZS9lakVXWFRpY0pm?=
 =?utf-8?B?MHRraXg2WlowR1g5cnlYNEVYNVRVOXpYVkdXbDRaM09lczNaY0hKcW5GQnd0?=
 =?utf-8?B?eWI2RjhFWkwybnAvMVVSSFkwUXRVWVNyek0vaDlTN05wWGhJUVJ6ZHVkdXRh?=
 =?utf-8?B?VkhINHVaaDljdE1IRVl0R2ZSZHVvbUdFNTVkQ01OdEttbDFjU1dIOWdxL0Iw?=
 =?utf-8?B?SkN2Nm9PUnUzVkxmaFFYTXZ1Wi85NlRtZkhWUlk0UnNmaGZOVGVBcFg2cjZY?=
 =?utf-8?B?cWlBaVIyYnNld2ZkODg4WnhtT28wM29VOXBtVUxUbVBoQ3NzRmlNc2pKVytF?=
 =?utf-8?B?SmIyYko3b003cWxTMDFQZ3NMamxRTUFpV3RYQUtSMFYxR1c3VDYzck9KTmFE?=
 =?utf-8?B?eXJhZ1NrbFdUYXVibGdIMkJyYTVKSHljNkFCVHU0aGpQdGFRMjBlVWNDV0p5?=
 =?utf-8?B?a0wrUzZIcm9ZY2pldEZZVjcxdk1zQTUvOTZneDRIZHF2a2VCSGNwOSt1Rkx2?=
 =?utf-8?B?VCtpam12RmpnSXlUU05YWmIzNzBaWE12QkROVTRhTTM1WE9DOUVKdFV4K3hL?=
 =?utf-8?B?aGY0Q2JPZkRlV1IwbkVFR1Y0b09DZjI3R2wyLzZNQTBzb0ZQU1V3ZW4yYlpH?=
 =?utf-8?B?UkEydlVPZnBydlJ4NzRBQkt5VkpOcXA0VVA5bVFlWDdQRTIwMUlZckZtNVVw?=
 =?utf-8?B?Z3BvTEtyZWwyZW5JSG1oTjVlYmxXNE5XODB2bFBmbkhWaW81UWc3Z2tobFI4?=
 =?utf-8?B?OGFXNy9tdEdmN09ZOHNPUlpJR0RlOUZiMHZLTE5UanZSZEIwd29VUzkveDR3?=
 =?utf-8?B?dVZmdmM5a3lzdkFvZXg5Z0wwQkVYS2hBN3BhZGk0aUQyT3RzUU1pOGtDb2xn?=
 =?utf-8?B?SU1aSHhKS1RXcnpvR1dxZHYxMy9qZU5WVE8xQnUrUnpQaml2NGRQUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4420BEFFAC5DA842B815825C049D2EBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n6GKIk1JrmGCBPc2v4gbfQcdyR254UGWOPgE9zMRGr41T4qAOVlZseThIc8buWoQ0r1dj6fnvVVaVkBaRkgB7V8kTTpYkjsLDzQJXm5Ydq3WPAMUMwhY2ya5g5Wr7+g9rBcp64IU0PCTZbjyQXhZzDQClfSzTblc3i64etJ8FyabVW5Y4ClyEca21dKrphypD3YEnTSSZzXJzaDVXS1Zsdvw6FFMwrK2eFTQ98OxMZUY8ICiizvZCramxOLcEO6ykkZeoqO7+TK+98nHSAgkhdj84lZ3832cIg2f2+qQodPmFB+Fo3quYGi+YEnk+NDjIrVq5m15uEQoZ6imEGaMTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b210098c-5a1a-44e8-0e3d-08dea1821348
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 21:48:37.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NAi4Gernq/eqkc/YDu0i5kqakGew4C4igz5kORjYMU8tr3ma0wl+QXLUR+20k9MonVyLTI+NotGADkurJTW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTIzIGF0IDA5OjI2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBoYW5kbGluZyBvZiBmYXN0cGF0aCB1c2Vyc3BhY2UgZXhpdHMgaW50
byB2ZW5kb3IgY29kZSB0byBlbnN1cmUNCj4gS1ZNIHJ1bnMgdmVuZG9yIHNwZWNpZmljIG9wZXJh
dGlvbnMgdGhhdCBuZWVkIHRvIHJ1biBiZWZvcmUgdXNlcnNwYWNlIGdhaW5zDQo+IGNvbnRyb2wg
b2YgdGhlIHZDUFUuICBFLmcuIGZvciBWTVggKGFuZCBzb29uIHRvIGJlIGZvciBTVk0gYXMgd2Vs
bCksIEtWTQ0KPiBuZWVkcyB0byBmbHVzaCB0aGUgUE1MIGJ1ZmZlciBwcmlvciB0byBleGl0aW5n
IHRvIHVzZXJzcGFjZSwgb3RoZXJ3aXNlIGFueQ0KPiBtZW1vcnkgd3JpdHRlbiBieSB0aGUgZmlu
YWwgS1ZNX1JVTiBtaWdodCBuZXZlciBiZSBmbGFnZ2VkIGFzIGRpcnR5Lg0KPiANCj4gTm90ZSwg
d2FpdGluZyB0byBzbmFwc2hvdCBDUjAgYW5kIENSMyB1bnRpbCBzdm1faGFuZGxlX2V4aXQoKSBp
cyBmbGF3ZWQgaW4NCj4gZ2VuZXJhbCwgYXMgdGhhdCByaXNrcyBjb25zdW1pbmcgc3RhbGUgc3Rh
dGUgaW4gYSBmYXN0cGF0aCBoYW5kbGVyLiAgVGhhdA0KPiB3aWxsIGJlIGFkZHJlc3NlZCBpbiBh
IGZ1dHVyZSBjaGFuZ2UuDQo+IA0KPiBGaXhlczogZjdmMzljNTBlZGI5ICgiS1ZNOiB4ODY6IEV4
aXQgdG8gdXNlcnNwYWNlIGlmIGZhc3RwYXRoIHRyaWdnZXJzIG9uZSBvbiBpbnN0cnVjdGlvbiBz
a2lwIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE5pa3VuaiBBLiBEYWRo
YW5pYSA8bmlrdW5qQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJz
b24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==

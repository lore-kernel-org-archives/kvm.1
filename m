Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABC3B42F7;
	Mon, 28 Sep 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621441; cv=fail; b=ouU9MPb2lVOZ0TNiGWiAVhPWLWB6tK3I0505BRwK0yLPCBjsQVIT37P3URT1kSzx2nCE8prL2OBySOf5ElmOdKr5gnItLFx4NsUdnOJiftbKmLTSS6vSU/NXHm+ISOv7oz6ryecqMLr2ALUsmMOlg1rxgOyVNZ5NHNZ8o6TJuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621441; c=relaxed/simple;
	bh=Yb1tmht3LK4HDtby7PODhyVy0MzULVtqlyua2vDfTOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAJ31KwI1lKgA4Lxw+n0PSTiQ9EOZfVJIB/jOfGijuNY04uXGY5A+BaSpQW2bAxuWRbNQS2YhnJHZJEHfwX5jjcA9GEoCeFMv39AZ9FaNB/sKzwfy0FuWRkpzgoK8ZCEhGCJydo+TSkuekNSlFuu8Plu9c3VodKyHOVXSc7BHhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebsMmnDY; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebsMmnDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790621438; x=1822157438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yb1tmht3LK4HDtby7PODhyVy0MzULVtqlyua2vDfTOc=;
  b=ebsMmnDYs6Y9rl8bqcO42POJNYng1t7z0AvaX9ldqYKtIE+3lGDbam3S
   LOh2d+3GrclA3WSshxUek+xfNN+a2F+PaRslIcG5o89cLRT6J2vk3wZuG
   ODfzhaLyFMsSyMld2rz8R0NiX2rBtdo/eeGiQH3RUVUax+EmAYzFlQuLl
   zIPeCqwizQ5ORPy+/JrQAHRJmXgNHPvSITHitwzDMVQQ0Yaeb1ThvjNta
   TuixCME3dEugjCbB7AIqObZw6oQIga7icYythi420HOb7v1AXDbiLEMnL
   9MhBmArKbjzNYwqi7i15Bos+nhL5CDjmdB0twEE6+0tk/2eWvJhVzZVqQ
   Q==;
X-CSE-ConnectionGUID: //KqCUJtRxqfTRFKLDYs5A==
X-CSE-MsgGUID: PocI/i+cRtOSnk/Gb3/xJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91350466"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91350466"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:50:37 -0700
X-CSE-ConnectionGUID: BpcWkcWeTt2t/Vqq7DCHpA==
X-CSE-MsgGUID: /7a/e3etRfWYMWr3Hji4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283221415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:50:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:50:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 11:50:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUkLpLeldyn+rTv2Gg8EclRBygCkGdT5Ic+D5tzBtCA9bOj1wrHG9ibRPf1i1qQ0u+CHqzo+DrY2S6B6KG6vHH4TsDrnAztPqq4AwD5xMscjdBsZ4MV5unsNyonYgTP6TAlg+EeAaUUK4LL7R3ixcMaJqbAtfwhzxt/oliC2x1RJMo4p5e8s6r3QZCgu1xqUd0qvO4fFin8Uju3WsW+UJ94FEO209mu4+59VB/ZZgK+KtRuL0edc4gLHEUm0n3xJ2YwUF+emS7OSVDP9dxxeRxavx5rzlDxOR1U1HCrTcEzFWCIIcRa272aPBMIEKLFDikIS69LDPuGXeIi78735rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb1tmht3LK4HDtby7PODhyVy0MzULVtqlyua2vDfTOc=;
 b=wSOQU+LM9a5vDnDjhJ8G3y9CPbAt66E2CBvPqM/a+M8c2P+FzZSSzUzxPFD3tbo+T6z7EP6TxyzEnHD/ZtQvrZEXirTU2Qg3xhczyrzbyYDmW4yu40Aa9YsVQMfzDDGHpIrf0LG2epq13b96iuUGpZ6RdqUVYArNJ+y/1AQJ5P/OtpzVjfwP754aj4FCgLF6sXrnxNtXz65qeWJ0ZowkPP5nX870vGE+Qo0bbkGakXlG2Ie5C1rQXTIrsdneL3bzLHmTIa/6U57SZo9pJJJWI4+8uRXRhMktD1qSh6bWK7UeRsAaocXQYV5BYFxuSWWmSuIPZuxrXNS8bEfDuIYLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:50:33 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 18:50:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Topic: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Index: AQHdTzGsoGIHh9qePk+bCG/ii8ItOrbkVhWA
Date: Mon, 28 Sep 2026 18:50:32 +0000
Message-ID: <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-6-peter.fang@intel.com>
In-Reply-To: <20260928100913.2265687-6-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB6719:EE_
x-ms-office365-filtering-correlation-id: 7cc1c9a9-50e1-4119-7921-08df1d915ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: bS6gWPWyAv3BzJsNJel6m+naPFzCEXrEQsEGkwr9ZEJHC4rjdDdHNJa5jhtcKIFdNu+4gL8+2BBAikY5nSLzrhNImFpLMvJxRlSlmL96zVurH5txu/pmcMFkoZrN356ZzW/6rcQip8N6CFRVWgmGdqvvDE5nCrxnJ/tnmDVECAW6fC7NgL8Ji0GSY9MMnC8vFHOmnXJyFY8v7Scy3ti/OvTRwFM/yxs4yFmba13NbvcZuv6rimKooPrPh9DpC8gKYaNA/mia7+JA+NNujq80e00E8/nMAAajnTavWlIiIJjJtOXPu4OQxT7+tY+vNVQxMfER5k0O/l99Ec1C3DJHBfYKDD/x8VuLgzuEkp1sDPHI99tdmjVmdsmOST10cvMWEk89dONrJ460gKRoHmdmj2208b34pNbNYUP1stJAh4x3B7ij5WJvjcx70NzJTS7rgBzE2by8VplVNZe7l53LRGNLpjFeotcQWbH6GYiINsZIM+qqZjHW6QUraea4a7XZr0O7iJa8MSELqarXNiopAMIxBzL6MPn5/HzZPhgsKn6br1HvtXgHEqsxKPVqVVUn0pyqeGGtJnx97HzJEHouN7NCGnskIm9WP2FRuoHSo34rJGVaF+7/QJ9Oj6/FB5uzOeePh8GZIFsftz4SRtBT73O5FIePAVEP0RegeZRJPdVEPK6xerQzzAP5Y3Nu2rhlNlIiPR65rr0vBdEGobWRPBrvezUipos6nK42oTDlnPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1RMWVdEWjc2UTIxSUhoZ29ZM1FlRUgrTHE0bG5ReS9UdWV0TUx3UHcva05Q?=
 =?utf-8?B?NGZ3YzE3Z0M1eUJEaGRKOVZmL2NVaEgvdmlhU2YvMWlvZ0ZUdGpYR1R6ZDNu?=
 =?utf-8?B?cG82S0lhYVVCVGFsOERIazEvU1BPN01xbUlWM3FIMDIrdWROSEZVNnVOd0tU?=
 =?utf-8?B?bElSbnk1aDVyRGxGRXJXQVpiZDB6NHRmeTJGV3h0ODVrMUVPREJMNWViYklT?=
 =?utf-8?B?NkVDdkFZbDhXQ0VGVXhNV0JwbUhINC8zYzk0aEp4Q3MwYmxoOHd6dWlndEk3?=
 =?utf-8?B?b2E0TEdQUHowRHRteE51NVhpUnorSWxQZjlJeThvZlZISkQxMzhuK0pJY3pP?=
 =?utf-8?B?ZCt6cWxOb25HdFNkNVVMTjdJQmRWSktadHRxYkFDbG9qMDZuNlMxTk8xem5p?=
 =?utf-8?B?U00vYXQ2bHRPN3lkSDF5a3FSdFBZWDdJY0xacnBBa1AzdGFZZm9KMUpoNzND?=
 =?utf-8?B?em56TlQ3anl0L1VEaitNMHNSWDVhLzVUbHdyVEhPV0VwQzRJU3Z6ZG4ycjJ0?=
 =?utf-8?B?REhCVmdSTWx6bUJIVDZyOW9lY2d6OXdhcnJQVFExdzJGRTN3QU1pUzZLZENT?=
 =?utf-8?B?R2xYb3I4R3ladDB1dEdId2lQOGVVMGtKMjBFb291STRwYWZaNzhCcmZhblEx?=
 =?utf-8?B?N1Vkc2Ntb2xXSmpRU0U5ckVkY3R2bTZjZ3NLa3hZYzhGOERyd0l1QTlGaklw?=
 =?utf-8?B?WFJBNGtUZWVMOXlRNmE5eG5xTFdneTR2TUNhTmEwaTI3NUFaOS9pWUNuRllU?=
 =?utf-8?B?QnhiblBRZWxTTktCZ2F5WUNMUEpKRWJ1V3lJNGpIMUI5dWpnN1NpWnlSK3pD?=
 =?utf-8?B?cDcrYmFpV1dpejBGb2ROVkRML2NtckdpQ1RCV2JKbmlaeitKM0ZrSE80a0Ra?=
 =?utf-8?B?eHZrYU52WG4wWFlNaFI3SDE1TkNPcUQ2bjN3WitnNjI3NzBwejhxMzgxRnFF?=
 =?utf-8?B?czJzc1NQeUhJd0x3cTZPOU55VG1yczhsSG9nNDlFOEZNTGd4Vlp6T2MwdTBv?=
 =?utf-8?B?aTdEYUl5TVBhR3Fzck43K3N2bWNTQ3NmdU1sVHdTbVZyQWE4ejJjQ1VOWVNl?=
 =?utf-8?B?Q0lubExneHpSZ2IvaExnNjQvajg5R1Uva3gzNHJReXBwRW11QmpTREFmQXp1?=
 =?utf-8?B?T1g0Wmt0VU9zTjViNmtQeWIyR0NDcWs3ZFBhU0VsWS94MVR0SG1Gd3lSTmtq?=
 =?utf-8?B?N3JZT0JuVXkyajNOUkJrN1piWERmYmo3Y0R2ak9qblpJSWdzNXRwZGVCbEtH?=
 =?utf-8?B?eGVBOHMrMjc5YVVhNEhxV1U4QUs4VktoTnpzUVJ5R2x4WkxXZUdVOS9TK1R2?=
 =?utf-8?B?QlI2VGU2MFZXZ0ZzUSt2UzdkUUFncG9JWm40RnIvL0hCaUs3VzdyaHFEakRP?=
 =?utf-8?B?eUJ4K21jZGZuYy9ReWRnOHhqOW5EZklFQmxwRWlTamgzL1dFUjBsc1owRHND?=
 =?utf-8?B?VXFqNUVoMUY3ZFVNN3pSSlVZMlFJZ2UybWczQUx4a21oV2M3WldFRC9GTDgv?=
 =?utf-8?B?akM0R0ZRMXdmSFBvWjB2bUdmZ1k0YitYL1hFMElvTGVQc21Ba1I0WkdReWVr?=
 =?utf-8?B?VGxQcVlSUFVoV1J3c2ZtZEVJYnl0WWNtUER1YlNTd0o4SmFvT0k0bzllbnN2?=
 =?utf-8?B?ZnBXbVpHYnFJWXVGaWNWTExrc0NqUG8ydFVoaE5SOGVnMjRWUDJxaFNKRTdT?=
 =?utf-8?B?SDVEV1BLdnZCSEhhQmdEbmpJanB4alR2N1VUQzFrbFpVT2dhbTljQmZzY0V4?=
 =?utf-8?B?ZGZoNEwrWVdld0V0QmlCMnZhK1lLU083MmFlVVB2SW5DMDZtclgxeE93Q0hI?=
 =?utf-8?B?WUMycXVzdk9tcGFlNWdOcll0K2lrREdEZlQ2STcwRmZ6TUFBN3U3OEppVXNm?=
 =?utf-8?B?Wm5qL1FXSkFRTXhIdVR6aFUwNktWT1V4VVlaa3JDWUtNZ0dNdUhJL1ZKSW8y?=
 =?utf-8?B?UENIcGc2M1F3YWdSQ3Y3V0pkYWsxVkpEZ3ZJbkxlTjhTZlNibTVEek1JRmll?=
 =?utf-8?B?dys1VzRwdkx4aTd3cUZzSW9JbDYySXYxV0srN0ljQWZTb3NRNnl5SWl2SmFT?=
 =?utf-8?B?dzlOM2dhUTFRNytzclpMRVh0MkFQUFlFOEM4dnIxNHQ3UHY1Mnh3Y1ZVR3hT?=
 =?utf-8?B?VEpZQnJma3FVZ2NqSE5Nb1dhRmlEVnV5T21ONXpHaHYvMk0vSTdNdFNKLzNm?=
 =?utf-8?B?Ri9iemZZWkF1TS9pb2VJYjgxcVkzMFU5UUpYOGxNVldTdC93cXY4VXlGd0NH?=
 =?utf-8?B?WE0rdkl2aWw5RXZNbDhxVnU3SEhVc09rOGlYcWFpWVZ3ajhYWHo2bGJ0N2xW?=
 =?utf-8?B?SXNPS3RNeWpiOHF1dzZCVDBQSXhnKzdkUFNZT1hjVTBTSk93dUdTUWN6ZmhP?=
 =?utf-8?Q?1PCpoWx+UCecIABc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ECE3BC0661A7B439D9208143C835AC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OL4WnKbpIQfxHL7wdijTFELmkl92+x4T45vHtsL7in7OeiFHYhSvyMOZCbSE//5bC3uqV/67LgZm75kvAFRd3euzSlRwsT4S6Kg3U60IHXM0xaS2NtViv67GR4aZ94/At6QATLztYWyNQwpVudsagbmTH5hKvluHmcKT6yqcdMzX2GzVjVtA0FaULyK8t9xeqxfjJZHKOeXX80CQvxR5QKSCVIGP7zY0G288NIGL23t+rcfxTnOnNWJgvI6GGLN5jcU9yKtyolRvOKpOF7Lz4zJ8oDufLBmVXJiWS8mJbFAEuzLOJ2fo+bDrMiy7FPeS5PIPsVQ29EEk/wXh40SvJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc1c9a9-50e1-4119-7921-08df1d915ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 18:50:32.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXzlPoAjqFnbMh2QewA3mlPB9+jlahVj5sGa4RWgaWxpUEgfmyMJiO1Ai2wtpkH/CEkKmAn4dAdsOqzknUYL3qckusg/8mb476sYAFIjLY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDAzOjA4IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBb
MV0gSW50ZWwgVERYIE1vZHVsZSBBQkkgRGVmaW5pdGlvbnMsIEF1Z3VzdCAyMDI2LCBURC1zY29w
ZSBtZXRhZGF0YQ0KPiDCoMKgwqAgZmllbGQgIlREX1FVT1RFX01BWF9TSVpFIg0KDQpUaGUgbGF0
ZXN0IHNlZW1zIHRvIGJlIEp1bmUgMjAyNjoNCmh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50
L3d3dy91cy9lbi9kZXZlbG9wZXIvdG9vbHMvdHJ1c3QtZG9tYWluLWV4dGVuc2lvbnMvZG9jdW1l
bnRhdGlvbi5odG1sDQoNClNvIHdoZXJlIGlzIHRoaXM/IERvZXMgaXQgc2F5IGFueXRoaW5nIGFi
b3V0IGJlaW5nIHBhZ2UgYWxpZ25lZCBhbHJlYWR5Pw0K

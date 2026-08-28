Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C33AA9E2;
	Fri, 28 Aug 2026 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956849; cv=fail; b=qx3rUD1HTqJgKwjFoq4QB4DHfeeIWdMwtvrx5TbHN8EneyBS7E7WWM8D8yKGMvAt5e3E+bjIYyOaYBmUMQ38kcRPi5F6VqxA/FgBMLaDghhb6HzX7cGp8QMoPT5YNK16H1GC8vZ2B6Rx/72wHO9jMjoqYSoDhpvF+9VwVR/V2/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956849; c=relaxed/simple;
	bh=5V+QGD/6rG0uKXfqEoCD9MlubUnI8IZp0C+eXw4VxA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsMtsPbi2aQzGDT0W6VgZaUf52ETEKH8Hz9XWxWX5fF3If1VyJpHAvlMGyvPe5vnmrHc+/h5ICfOeS8g5Tc+fC5tJAY+Hp1qhpR89xN8ESeTSEu+qf/v5MdjsEIxcEiT72lItFnBw5CLVha/7DWVmafKajOpyXr4iz3WYoas+Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TADgaN54; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TADgaN54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787956847; x=1819492847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5V+QGD/6rG0uKXfqEoCD9MlubUnI8IZp0C+eXw4VxA8=;
  b=TADgaN54n4SU5dv7MmRY75UNMBU5dj/5qYrzlnHPA81LuOhEhEm2M/K/
   ov0/5OmHMT0TyHiYodYK6bgWoE/65IIFgOESGoXYwCKl//KTKRRqpdgxj
   iZ+JOY+F5KLP9XDzXUSTHc1RJwEHEd6Oljn+HBQ1AFrj8jQjjlQoYXz7O
   GFrSfoazf2AQ1C8mOCJRzDovBBLAvDSCFfwYdAkImT3XdTFVRBUvuhO12
   JbT3sG/OoCyQseS1442KE6DXTOlOZXqMYC8GT0aVJE5TW8y0I8ff2h+dH
   fesYWQ7swnpXzBYxBTUnnEPbhVhmW1Ga3AABSDsTiyuoNt560KS6pfQ/b
   A==;
X-CSE-ConnectionGUID: UPSdAbTxQBeyxVjp62cHFw==
X-CSE-MsgGUID: +EdpY6prTxyHUnqF0jX5qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99067722"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="99067722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 15:40:46 -0700
X-CSE-ConnectionGUID: /9kPbryEQNqJx07DDxWJ/A==
X-CSE-MsgGUID: qkpqj65uT7isirpoIQd+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="262180902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 15:40:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 15:40:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 15:40:45 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 15:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb9bcPwQ/3EVvX/OgFMDBeKvbRdL6rvQsrxxm04yzWWV7btbd+JzGWtkSQDPcfMciuN+pH2eoMI5KqF/RFQy0yUy2CQ+kPJvXXDh9Q7Gnna5jqhwPOFGNIn2ZrPh5zZOuwGLd9VDHzZDkHSPWZs7MnmQwgiJTGm81oslx1pIn2rTvUxTJSgDcffpd724xBf/Nm1iByrVb1m8xBiKXuKuLLrYimnO/7rdOKA3tWLNGGii9kRUfz98U72Tsz3nK80GpxR6n32X1TQx5Fq+m/vIkIwxQlFncc3tfOwajUlAR/QMnh9cSQBG01zZK0AaFbiyIlLfN1SbRX7te6A8/xx+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V+QGD/6rG0uKXfqEoCD9MlubUnI8IZp0C+eXw4VxA8=;
 b=y2p4o9PgJceF3SNpF/IlU8qmv9wyxu1yLZ6teUH/L+mYimXhowuU8UwT7NJ2BPymNWCysmVIFvJ+LVc/UJvk3ZXuA/JSFZrC1OYSlEdg9cV7yoWY4EW/ZUw4LZwTibG+DFJovWGIHfew6omm1i+Gat8uMK7QrKQkPfe4nIEzUTE7k0LCbndoOSWodjX+SoUNuHdePl8mq3NFdrwuqhrqkLG6bobIPacX2s5ciQjVaN4bYScmu203JmDLS6h83S7ibGPDJimS+rE7qPVKRy1RTZXaxS2vtjfzCNXXqa6RHusdVXq1bchx1k5P346vodgDWd0CH7uYJminu3petR5Amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SAVPR11MB9552.namprd11.prod.outlook.com (2603:10b6:806:4e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 22:40:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.006; Fri, 28 Aug 2026
 22:40:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hongyu.ning@linux.intel.com"
	<hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v9 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Thread-Topic: [PATCH v9 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Thread-Index: AQHdJUiURbrhwbeEcEKAY2Tm3WeisLa0K9gAgAAGGIA=
Date: Fri, 28 Aug 2026 22:40:42 +0000
Message-ID: <74bc9f2695959f335f2f502ded1ae7c944fae13a.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-8-rick.p.edgecombe@intel.com>
	 <CAGtprH8XJ+SbxQLTowch3DR6N1NSMUKyVnGf0hv5N+iKWT3q7A@mail.gmail.com>
In-Reply-To: <CAGtprH8XJ+SbxQLTowch3DR6N1NSMUKyVnGf0hv5N+iKWT3q7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SAVPR11MB9552:EE_
x-ms-office365-filtering-correlation-id: 89280d7d-0397-4abf-02c1-08df05556474
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 7O8x92dy8pf4ZZuB54DG0XS3WvxO65HRkLNLNORfTozMuGOYwxcaEdCnKNrXIbtymlteaEQ2ORTZTFqK8U+ptX4Nm9eQHIzNZQUOPP5VVY9fUZplFtE+kN7x0UHEFhdJDpS9vvXh6GDVCnc1MqXmzNPQr+MIXB+6ae1k9nRMcO8VIZAXMUNwCIVOBTmrXJYHZMmXDMJXK7hMmPJG4QIH9JOPH2Z5QQK7zWc0HZ7CACJKYZUPXvEatFjGYGkzJSgDal4aKV9CkzWRPL5ONEdeSZZCsGyXtOTbeA69tExagkuUcgxyjw+c6l8XsNfrxHcr2NBrpvVodE/XiGPvZ7tSC0+0fgdp8Bpv/7o4VERJSknAHhtetyByU69TxEBmqVbl22pmpVjachtQ976i2NMABqF2mQaAF/DDhbg8BILMa6w1BSUo404apIgyt7iSrbdTs4c8MefIY1+Ywp5+Iyq2kc6PjdO3ULvjm2okQe9Laad4NXmEz49eifXVHJvcsC8q8A0APmBnrSEpLRQkrO9JoJwz4+FIf4sTxTVUvyEbHFiI32QKqn+/AjzxM969+fJE7mh7Z1geRxaXbJQq3lwtvB2KkJWsS9gJQCW4y8yyiw8soYcUMwvcgLNzwSG6mOOkMeqSgTDvMiUikioFm/h5NlHii1NJwRVC6dQflLkJxKMsUUzCwtLWHMxdO5g7ZAZbataXxQkgns6gbZ5aB4+xvAtqJ8HveWREN2ocbuQisQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlpKRC9oV0x6RWs4dE1YQzBXZjM5OWdLQ3EwcDFTTHNqelJJVWo0ODlFSEVy?=
 =?utf-8?B?N1JlUldKeExlZEsrRkJyMEJ0UGtVTittODlqY0ZXRThHWkhRbXNFUk5scWNy?=
 =?utf-8?B?Nm01N2FCa3E0QzFLL20yRE9kbExSc0VOY0lXaVVieURWc01DMlRxcnk0TERj?=
 =?utf-8?B?MFFsRmkvZjh1UkU0OGY5VkxWektLV1VabncyQ1VtaUpYZGVmblBCR1QxSm9p?=
 =?utf-8?B?cE5pbzFHT3dORUc1blBHS2N0RWFjQUdFSzYxaFZmc1UyWC85MXpmN204dUJ5?=
 =?utf-8?B?UllRb2FtSnYwVmtzN3NYeTl5YjAvSnVRUDRwb3RZM0YyVmdRYWRQTjd6bHV3?=
 =?utf-8?B?aEM1QjI1cnRFMzduSCtkc3FiWTBZNDMrNjk3UEMyaFhrdmMyLyt4S1M2cWlm?=
 =?utf-8?B?MlZMSTE5R1RDZ3ZtNExTcTFLN1RTYjNiWi9IQ09PVDVFQzFMNVd1UWptUjFO?=
 =?utf-8?B?K1pDaVdqVmErUng2L3lTeWhwME9HTTRTUDQraUhOOVdnMlhTQzAybkhxRjI5?=
 =?utf-8?B?ODhoTE5TN25VaWlib1NvaHA1YkF6QkV1RnVxbDdSSkJzMlNoMDEzcGJsdEhj?=
 =?utf-8?B?c2o3cFRwNmVBUDFlQkpRaFV5amJPR0xwWVhDK2hmb2hyNkYzM0lPZlVUTndB?=
 =?utf-8?B?ZCt3Sm4rTmhnZmJzVnBSR2hIU1FYR1hYU0o0dEtsNjNzWEplN3hMQlBTSExR?=
 =?utf-8?B?cmdwT1pVbmlNdUszMFdqeWFIUXBuN0RGRkVvQ1lRWTNuQ3hrbmdaS0pGTHQw?=
 =?utf-8?B?YlZoRDVLUkl6UklRNm5zQWJNNmFTaDNuejRLWGorNlNOOGhXdnZBREZ6aXpQ?=
 =?utf-8?B?bGZmMnN0bG4yQXBWN0gwOENSejZ5dGJ2VWtPd2Z0b0tuSmdkd0pJQTc4dUJo?=
 =?utf-8?B?bU9qcGxiNmFiVGo0T3RCRXNXVnNqUFArK3B0Qk1mUlg0eWpOVGVFb25yRUhC?=
 =?utf-8?B?UjFNalplS3BXRVdDRzNMbURjcUZrYkdOZlBMUHZrQTd2MTJUR1M1aDlTb0F1?=
 =?utf-8?B?YWw3blA1UUY1a2NranZ6Y1RSbnViOW1BbUxEOWZGQ0lNd1NQbVA1YlRONmtM?=
 =?utf-8?B?a2JoUUxLNjF3bkZFVEFvT2RxdU41ck1UUmJZK3FuVFFwc05jTUdkUUd6QU9Q?=
 =?utf-8?B?YUZIa1pORm1lN2E0M1BmV1ljVzBDV1FZcWVqdjd1Q1FxZ3l2YjBSMlhBMk0r?=
 =?utf-8?B?QzN4RU5GWi9mKzFkUytpa2hNSms1eXpQTUlzRXU4NlRkaU9Wa0dUWVVWb3V4?=
 =?utf-8?B?OGN6S1FyNWZGNkNqV0NHWFpxNmtjY3ZFWSt6THNUeXdTQ3QzQ3JoNXY0aDdu?=
 =?utf-8?B?b3JwemdySlNxU1pINlYzOVpiemFwbjZOUG5qNGN4ZFFMRno3ZlY3bnR0b05L?=
 =?utf-8?B?ek1WZVFDb2xTZXFvaFVVYjJISnN4N3dScGxsK2oyN3ZrMm9qYUE1WG9LTy8v?=
 =?utf-8?B?UmVWWDh0SlVRR2lkbW9WMGRVOGNJNFlPdjZUbFpiSm9UQ0gyQllOSkhYWnJp?=
 =?utf-8?B?UVlnalgrbmZCMi81dTh2aW02SmVEdkZOcVg1UjhDS09YSFhydzNjOUNTZVdP?=
 =?utf-8?B?NGFTb1hvZlVzRGYxVGx3K2g0T201K0FKdUt6eS9mR1lFaWFxSCtGejBZRTJD?=
 =?utf-8?B?bjM1b3FaUmhYaDFZTlhWMjJsamFPQUVFMjRTcHZJcEkzL1VlcTd0dytTS1BE?=
 =?utf-8?B?ZUhVbkt2a2ZFTTJoRmMvSVVGOElieHZCVEV6NDBvakgvWW5Cc0JueERvYTVY?=
 =?utf-8?B?dWVKMWdrSzFYMGR1Q0QwUUFZYnM5NWk4TWg1NUxsMTl0ZVJqVC8vR1JkdnJj?=
 =?utf-8?B?aUNOVG85Rlp2V0xnbVAzd0Z6M3Q5dkEzOXFsTEhVTnZDRkR2Yk5CSnRrZDZT?=
 =?utf-8?B?K1pyR1MwcDNoT1VFOVdHMFFrU1BSKy90RE9RWGFhNTBPVnZtaDMreVplR3Bv?=
 =?utf-8?B?dm1aZFE0cmpBM0daV2E4U21VVzJkcDF6OENvNjdHd00xUlAxUUo4WTdEd3ZC?=
 =?utf-8?B?RC9wMGtOSGJzcVA3elZGenlXNWZpNFJOdGExRURVWVltT2pMUktVMVU3dGd4?=
 =?utf-8?B?OVZyNkE3UlNrcVZwSHFxemNDNXVkZTdYdmlGTnBQWWpFYnU2ckpicGVlYzhF?=
 =?utf-8?B?TEU0aWhtdnR0NjlRYUE0MjE2Ni95bkZsOUVMUzRkTlBTM1drVUZ3L1hhR3VT?=
 =?utf-8?B?dFV2L0FKOXlaOUU4cTVZQWY2RmJLODRqZ0owUlhCYWNVbys0dDZLT1FzMDhI?=
 =?utf-8?B?Ukt6TGtNY0V5NHRuR0ppck4rYzFYSFp4eGt2aDFUQ3BCM0R5L3ZYNC9oay9C?=
 =?utf-8?B?MGhYSFR6OTNGbk0xWk5QL0RFQWJ1SGYreWdkZUxLRlYzVWNSMzl4azBjcTE1?=
 =?utf-8?Q?zmGVXqpIXyaQFoiw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7FFB658868BFC4BA3D3C0C6BE89B08E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L1zEB0UdFpnRtlauMRcaXtesgWAvT9sXMoX/roKi+pEuYuJdpx8ij62SBXVJrXJzXH7+9xkqmaDUyned78FoxmOr5n/hjtBOZJjsf6ZiQTCjshE/CdPQ2XvUTSlg3NlhM81Sve/UcczazPIPVVltjJd9vCndx0yj04fyErolrfANyzsaGrLZQ1az5qBXJMg4Y9ppSJuzJJJlNUxLrc3bd5aOUTBu9ynws1TN7XQCIGpzYAxMJYrsHRN1koXVyh2PJRbcfufE7UPP2kJ7RwyHrj2Alg+h1hFzP1Jb0CdCps6I0guEwDV56nKrOANa8jpYpX1luAIkdd5ePl5sCOuVmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89280d7d-0397-4abf-02c1-08df05556474
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 22:40:42.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVVXI/jb3c/bwAQFNfH15JBdgdtN9ALkVpAT2JW4315mWgfmevukoIG7K0lXhug1esN00cMF3ZSC2fylVmGsOVXWfNptJycU61HNfjkwoj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9552
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE1OjE4IC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhbGxvY19wYW10X2FycmF5KHN0cnVjdCBwYWdlICoq
cGFtdF9wYWdlcywgc3RydWN0IHRkeF9wYW10X2NhY2hlDQo+ID4gKmNhY2hlKQ0KPiA+IMKgIHsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGludCBpLCBqOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqAgZm9yIChpID0gMDsgaSA8IFREWF9EUEFNVF9FTlRSWV9QQUdFX0NOVDsgaSsrKSB7DQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFtdF9wYWdlc1tpXSA9IGFsbG9jX3BhZ2Uo
R0ZQX0tFUk5FTF9BQ0NPVU5UKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
YW10X3BhZ2VzW2ldID0gYWxsb2NfZHBhbXRfcGFnZShjYWNoZSk7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFwYW10X3BhZ2VzW2ldKQ0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4gDQo+IElmIHRoZSBhbGxvY19kcGFtdF9wYWdlKCkgd2FzIGFibGUg
dG8gYWxsb2NhdGUgYSBzaW5nbGUgcGFnZSAobm90DQo+IHR3byksIHNob3VsZCB0aGUgcGFydGlh
bCBhbGxvY2F0aW9uIGluIHRoZSAiZXJyIiBoYW5kbGluZyByZXR1cm4gdGhlDQo+IGFsbG9jYXRl
ZCBwYWdlIGJhY2sgdG8gdGhlIGNhY2hlPw0KDQpJIHRoaW5rIG5vPyBJbiB0aGUgY2FzZSBvZiB0
aGUgY2FjaGUgbm90IGhhdmluZyBzdWZmaWNpZW50IHBhZ2VzLCBpdCBpcyBhIGJ1Zy4NCkFuZCBp
ZiB0aGluZ3MgZ28gd3JvbmcsIEkgZG9uJ3Qgc2VlIGEgcmlzayBvZiBiaWcgc2VjdXJpdHkgaXNz
dWUuIFNvIG9wdGltaXppbmcNCmZvciBtb3JlIGVmZmljaWVudGx5IGhhbmRsaW5nIGJ1ZyBkb2Vz
bid0IHNlZW0gd29ydGggaXQuDQoNCj4gDQo+IFdlIG9ic2VydmVkIHNpbWlsYXIgZmFpbHVyZXMg
aW50ZXJuYWxseSB3aXRoIGEgc2xpZ2h0bHkgY3VzdG9taXplZA0KPiBzZXR1cCB3aGljaCBoYWQg
cmV0cmllcyBmb3IgcGFtdCBjYWNoZSBhbGxvY2F0aW9ucyBpbiB0aGUgZmF1bHQgcGF0aA0KPiBk
dWUgdG8gU0VNQ0FMTCBmYWlsdXJlcyB3aXRoIG9sZGVyIFREWCBtb2R1bGUgZnVuY3Rpb25hbGl0
eS4NCg0KVGhlIGJlc3QgY291cnNlIG9mIGFjdGlvbiBpcyBvZiBjb3Vyc2UgdG8gZml4IHRoZSBU
RFggbW9kdWxlIGJ1Zy4gSSBhc3N1bWUgdGhpcw0KYWxyZWFkeSBoYXBwZW5lZC4gVGhpcyBpcyB0
aGUgZGVmYXVsdCB1cHN0cmVhbSBhcHByb2FjaCBmb3IgdGhhdCBraW5kIG9mIHRoaW5nDQphY3Jv
c3MgYm90aCBzdWJzeXN0ZW1zLiBCdXQgaXQgc291bmRzIGxpa2UgdGhpcyBjYXNlIGlzIGV2ZW4g
bW9yZSBzcGVjaWFsLA0KYmVjYXVzZSBoYW5kbGluZyB0aGUgc3BlY2lmaWMgYnVnIHdvdWxkIGlu
dm9sdmUgb3RoZXIgY29kZSB0aGF0IGlzIG1pc3NpbmcuDQoNClRoYXQgc2FpZCwgdGhpcyBjb2Rl
IGNhbiBkZWZpbml0ZWx5IGdyb3cgaW4gdGhlIGZ1dHVyZSBpZiB3ZSBzZWVtIHNvbWUgdXNlcg0K
dmFsdWUgZm9yIHNvbWV0aGluZy4gQnV0IGNhbiB3ZSBwbGVhc2UganVzdCBjYWxsIHRoaXMgYmFz
aWMgdmVyc2lvbiBnb29kIGVub3VnaCwNCmFuZCBidWlsZCBvbiBpdCBsYXRlcj8NCg==

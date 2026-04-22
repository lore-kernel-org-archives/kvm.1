Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CD3537FC
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885221; cv=fail; b=UMukv2Sir9as/jUpUA5qHetBfmxFBxBvmCXKFRg1OOrdFZQsCXR3W6kvR+ysuy6ryOmxphi1we/jUb2Qr2RubKr5oF2ikeIh1nE36bIf+ujcdRvve8XkdGzb6j4Lvxap54Zoi90oiS+Gpsw/UYDZFNpPkpqLG2ELt/kVS3maHY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885221; c=relaxed/simple;
	bh=V69LjuKGEZRdVEeS3gitiKnYoTW2kYxq0yYgJExiSag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H44oUjHpZPR7gGBXWsbB46BacHf+S9si2+rIMu5vxyrOXH0cpWidbfa7/if80TUcpqTDysszBWElM3RwTQCiLkh3Lx5CTHCU6Bdt8BRpqGaAAtJzsV7Cx+BtLnPykopGax/4YnebdSfde9zYcM/Q5F53SeXFbVFbONgiJBf8fwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHqqMN8Y; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHqqMN8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776885215; x=1808421215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V69LjuKGEZRdVEeS3gitiKnYoTW2kYxq0yYgJExiSag=;
  b=hHqqMN8YDq6yEFM8CxcbfACDhgv2s/LOVz5KiXDJQ6pjUxRQXGiuSR8p
   8G4upwL+BoUvIBz0/z444w7TtMsB1bokKHF96vDMrsHgNuFQMjtI0YtCT
   wX0zTFKbRIClvQie1ncD674t4SDvTfKsjlr8FCd3Rainea/NjbndXVP8s
   VK32xDw4cXV2dvh87aQHdTxtW6yH4YvQfeVPTnUf3xIc4WbIk2mRAVvb6
   O80Mqso3taKGNdH+HMrX69JbHFQl04RjRlOdl4GjR+Yg/QLTfP4BknaP7
   FEwCUntFOWuWvNkiyYSWVNCk4vZ7NIqEKx9lhG8W8xcia5zlnytOcCyXL
   Q==;
X-CSE-ConnectionGUID: U5+TObuTSCWK3APPjge6+g==
X-CSE-MsgGUID: pj5RrCaLQx2+AU2bBGpBOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95263204"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="95263204"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:13:27 -0700
X-CSE-ConnectionGUID: gScKUvkzTL+1TD01lXOP0Q==
X-CSE-MsgGUID: TnG+VaB3QHaKgIxRuIsWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232295004"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:13:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:13:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 12:13:27 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhK0As1uAlN0YQ8MeOcxpXxhqe+H/S1l2K5E9RWF2LAn6TQ0JfeIhVUlv74lrpcjntZdSkI3zLi+Fz0WpNTrR4Om8EbrQDs9QZOiMFlK29389pyWzpOjfhc5dkxgxTmWA0KkT4dbnIBmM2e/oRImpm/fOrlfdwZf7EGWmHMq6QjQXXbU1AWMjHdgX8L1dJNVMjbERYr2s0rcvSbwScD79N9H27PhbdQXQ0CvC8qf4Pgwmjkxr4wi+zwz9iaSDOlrW03dMKG+HqQXyaiHp/I57wY7n0WXEClzEjBYcpDy1hlAUxgIyhNTBf/aH8XGXcs2xLye4ljktsHaLKY0HMRrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V69LjuKGEZRdVEeS3gitiKnYoTW2kYxq0yYgJExiSag=;
 b=LvBa7ulnOc++4LSklOOhgqscQOAj8W1VK/G1gK241Lto1/JnUVSTLlAVKS2o0e1rxtLXmKxT194RynexaK+5kDCGTEQM4nb8JOiGQalqMZNzz8K/yGdZqlKc0QC8khrPkXVxEh5jAnNuqLbIKZdXzUSwG0ojtywx3RkSUiZLADNJ4FcXj0fS5UiSEH5hBAQs1PiULpeHmZw8EOR93oTTZWCz2PZXPEKTCdqGdzc7PnPYstPJvQ9PAeQl2cHb84nSvWUzwc7/FPAPyfoVlL1nay5j+9Js+0WkoA/KNjyOrNer8uO1BDm6bmWAWYm3pboHUjwiq5ws46Iv9WNtN/tiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 19:13:19 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 19:13:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bonzini@redhat.com" <bonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgADoVICAAC7QAIAAPWUAgAADsgCAAACJgIAABFgAgABZ2oCAAAJ/gIAAE08AgAAHVoCAABPHAIAADkQAgAABS4CAAAtiAIAAmn0AgAAORQCAAL/PgA==
Date: Wed, 22 Apr 2026 19:13:18 +0000
Message-ID: <3a18c4f85211737bf9f7f1cbf1a814335279a30b.camel@intel.com>
References: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
	 <87cxzsb5n0.ffs@tglx>
	 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
	 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com>
	 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
	 <aefktNLiS3ur10yD@google.com>
	 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
	 <aefvVjTtx22EzMkR@google.com>
	 <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
	 <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
In-Reply-To: <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DS4PPFAC42FDD50:EE_
x-ms-office365-filtering-correlation-id: 10471dc5-c66d-46de-cda5-08dea0a3368c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 2JPAtlMUp5SUGviyEdrGaUOuUUSNvwWpbjEyMZJJsPgZ56PkdzZn4FQ+yfLWMSB5Iqk8jBzXDYTJAUkGKYLWbx2vguC8d5SspFJ6D9TC1gT8KegJN2eXzxmmZQehu+rpx8uTuN9n+LRx1faGzpOgQ1xXJT5OL7NoA5f2JBw5yzpWQcqtwpqGU4z709SvQ06YYNMCZlbpPFKEn0u/uq+1LDi7g8b75OxnzqpKlUHuSJyaG0+3wcYLhayISQdlbUW1knMeqNcg6bpRuq4Nmmco4OGlWiqFZvrz86ok3yhzJBjvNyJx/x2tni9RD4LpCwmCqAOUZWdOP8e2DWfztvqG2fdIfPHkcv1lAbzqTpfgnsG4phU25m5UGTS/8U3ejB0G7XLHTwDj+KSQ6wCrvprHCQ2FhwwrpLjlmOF3bO8g9pFqAFqPOtGqsMMwaRyWLFs9fQrg0A0a+qwDI1R8COtPg9tOZkDQU6W+pFNaAX1eOxQTqS/B0DvAaNKblAfyoc2joX8T+CSPVIcOAz9h0nePb9veNClmxOp6MJa2vFRu6e525f3DNxEEiTVT8HZ79R/oGvS+bdZ6KjSPR3kRHeDwzoNNGwZmLo+5ycVkVMhgm2QZo7gwc+FTdFTB1G3fop9vuGbNwKECm0AUhgatLr7H3jarbffpmcQ3bhrdhngzDkGBqSha2+jvTCnqW89snlYTNxUKUYPnLij1aIUqpfgBYfXzNeKcpRuESzpYAHOpcYoAOMZJMGFXyZkePU6RuOHoWU/ftGX3Z+SBAgSYyHGmrXSFFzL77xaqxauzr/FlbKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RCtTSjdPeDdtUkhwOFhvc21rR0draGtsUlkzNWhFbnpVNXhGNlhHZHNUYTcw?=
 =?utf-8?B?N2dsY3R2Y2dwdDRyUVZndnFUOGJianY0dWdRZ0w5dlBmaUNqRzBLeENkdkVC?=
 =?utf-8?B?akh4eHVNZkdrMFpFTFV0ajFrcUNkNmU1WGRtNmdnZXppZEJ1LytFTFdUUWJQ?=
 =?utf-8?B?d0lFUURYOHdtNVdKOWVwRXBxT3d6Z0tNaDFvRFdHSVNCSmxGZmhGNU1vMUxR?=
 =?utf-8?B?QkdCSklYdEVzT0dSeklhaFE0S0o5Q3VaQTd4bHIwOE9mU1FkZTFXQkRtWlUv?=
 =?utf-8?B?NTNTczZYMXV6c3BtYkE2TlRrREwzamhrNjh6eTIzNFBhUElsQVljTXl2UTFn?=
 =?utf-8?B?NUQrWEVyMUxMSzV6Tno3aGFlbFBaekFsVXJuVXMyaXpWNW5ZWnI5bVhYWXl4?=
 =?utf-8?B?cTExV1dpaTVyYm5vbUpYZlRsSUJKMHYxSnZFMmZ1OCtaQTdic2hzcU9ReGxD?=
 =?utf-8?B?Z0ROR090RlhZWFQ2cnRDQXZTSkptbTZ1SDVwRVdpbEhFcTN3dk8xM0YyQ1Uz?=
 =?utf-8?B?WUtKYklOWDlwb3RQMnJibDlVaFp6NDNuclVSVmpKblRaWW5EVUlRZzhnRkJm?=
 =?utf-8?B?aS96cVM3cVErMmxwVUpnYkowY2NHRzdUYXM0bkJLRi9wejA4dGZLQ1I5VG9v?=
 =?utf-8?B?RE9INFFTRmJtSlV4dVFmQlNtbW1QaFNBeFpJT0U0WmFYV1E3MEo5NHlYRkhI?=
 =?utf-8?B?RzNoSkhEL0NKNXBsM2ZmeTBuRjZCYUgvd3djSUJQVkNKUTdlMWRqeHQ2azc3?=
 =?utf-8?B?SXY4cmtpUjJPbEtoT3RtSjBnOGNRRmU4aDg0NmhzaStQWUUyTVp0bzJqUjJP?=
 =?utf-8?B?emxEM2ZLYWIzREFoeWM4MzlKYWswMnNGbUVXREFJbE5WL0ZvdlVGS1dZVzEy?=
 =?utf-8?B?QjNrekZtRVYwc2ZkdisrUkpPVWFOWUlaQkJCdXEzVmNKcEd4RWJCSFMyRWtx?=
 =?utf-8?B?aS9sOUxnZGFvaDFBdXpHdDM4Nmg5bUhxdlRmb1YxZVNNYzB4cFBHSlhaWm80?=
 =?utf-8?B?Mk5jU2I0ZHF1ZGNmbWtFTHR0Rk1xdnBGWFZLSjNiRi9sbzcvT1RpVWVVNmJH?=
 =?utf-8?B?NUd3V1pKZHFhUmhxM2UwYVRCQ2hJOXlSRnNDamRyRnVySDVaRDJMNW5TWHJm?=
 =?utf-8?B?bnFkalVKYnBtOHJLcGRMdFo3Z1JrNXkrRlpyb1VXRW9KdmlQWFFPNmVJK0Ev?=
 =?utf-8?B?cnVJZGlWanZtZFdERUlhNGFVYXRrendkNjBrdEMvdGJlQ1IyZUljQTMrNjR6?=
 =?utf-8?B?VWRQcm11NmlQNTFjZmtOZlU0S3lBNWl3VThuU2UrdU5NQ2dLOUtSK0o2Mmt1?=
 =?utf-8?B?ZWpZVFpYeDIybDd1WVcwNGxsd21rQU0rU0NiNSsrdDkrTk1wSEtqZ210N1U0?=
 =?utf-8?B?a25MQUUrbC9jR1dJbVVZc3g5b3gyT29pMnFzMWZVUXhDam5aR2J6VXQxVVp3?=
 =?utf-8?B?Tkp0REF1RWcybzJpT081OVFRMzNFcFRFeG44UzlaZ20ybDZSL0FKY1hrc0lN?=
 =?utf-8?B?c3p2ZTZ6T0E4ZjBseUVxcEF4OGQ5anNnUDdDNXdPeGlCL1dCaU10alMrNm9C?=
 =?utf-8?B?cjY3ejFOdEpVYXk3dVZ2VzBweHFmU1hZMjdQMUJXbTlVWmFtVkJiUUpCSkda?=
 =?utf-8?B?OHBJUXZUS2liaGNzOURHOWNWYUExSEpBSDg5SUNHREZPVWVmYnFDL0hkWW5Z?=
 =?utf-8?B?V0FIcG4rSDM2NXQ0RmlMcGR1aytiN3lGbEd0b0dUNVBuQTZ3STkzcXRwNWJG?=
 =?utf-8?B?bDQ3UGg0REVueVFIY3NhcHA2TDhmMXBJZDBaWWp3NUpjSVhBbC9jSGtGSHlT?=
 =?utf-8?B?N3hHUkM1VENJOCt0T2ZmdWtUWHAyZ3B5NnlsbENSeEFQazRKenhxdXpDVEJw?=
 =?utf-8?B?OUVXY3pORXBVMkk0bVNqdWlVMHFQcHU3WXE0aHdDQVNjNzFSdTBJVjRDVjJ2?=
 =?utf-8?B?TjU2K1pPc2lMZ1dQWjVaakFweCtpdG9wRTEyNWhmS2FEa0Ridnd0VVppUzho?=
 =?utf-8?B?U29aY21WejlPVHViY1QvN3JtZlBNanZOZy9OYVlrWER6ZzdnbDBVcllOS1B3?=
 =?utf-8?B?THdzdnBzZUM4b3hobW5FdzlTUVQvT09SK1dRNC95NmFCcjNpeU9VNjhxVkp1?=
 =?utf-8?B?K3l1TGlENFJTTGU2dWVndFgwUlVzZXVkTnFwNGowQmJaOEVBZ1JkUDdVMjlm?=
 =?utf-8?B?bzQ3VStPY0h5bFJudVRDMGdBRUQzZE93Wk5vbGl0N1JtTFVzTmJRTGNTc3ZI?=
 =?utf-8?B?TlJUOUVEY3ZWWFRYOW8yZmZDZ1BVa1lSS3RKRlZuZ093RmNtOXlSODhHVi8y?=
 =?utf-8?B?blFtcm80T0FHWWh6cFRrcDVEZ2JaM1JBN0RGYXJMWUwxdThaK3ROM2Y2eDlS?=
 =?utf-8?Q?wAHxammpPMe2WvIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <143D610BB3ABB44E9DDCB73DDAA790E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sCtR4Qk5yySl5UCaivG+FKVawEs1Gjj91Gt1UVy74gWiZKyjWJWjVJAgwcP3o8hb6IFC26xsmOMPR9SHo2O76D4L4sg6pwTrKJbuFlxf1dM0WfEtS1jnCXV+K52sG2wyaLDoBeC4VvHjqsC0ddkAiKWEdGQRY/1bIP3p64679Hr5F9ksYPNnTRmJHjN42JK0eutClS7cQ8KGWJ6qUvs0kRgUwg9M7puRkCpGp8CYmqFzrZ3cMkgeBHmAgcDFGTfkhjYAADRD1nB8yqadl2gJCZizRqEDGiQlHKaKjNAyejWiQlmD93doS6RLHmutVpmkv0OO6P+Qy6ao4WXzHn6zyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10471dc5-c66d-46de-cda5-08dea0a3368c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 19:13:18.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NumnIzIONzjn8Etik9Fv0ccYh2xZYi13RZ+fD1Gw/kJ7UwxJa/fJ4iTw+0KzhT6vjazWJzC6x4r1cLzETS6wyGrpueS4PQCvEHa2G6Ji68E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDA5OjQ2ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+IA0KPiBUaGlzIHNob3VsZCBwcm9iYWJseSB3ZSBhdCBsZWFzdCB0d28gcGF0Y2hlcywg
b25lIG1vdmluZyB0aGUgY29kZSBpbnRvDQo+IHRoZSB4ODYgY29yZSBhbmQgb25lIGFkZGluZyB0
aGF0IGhydGltZXIgZml4IG9uIHRvcC4gQnV0IGtlcHQgYXMgb25lIGZvcg0KPiBub3cuDQo+IA0K
PiBJcnJlc3BlY3RpdmUgb2YgdGhlIGhydGltZXIgZml4LCBJIHRoaW5rIHRoZSBpbml0aWFsIG1v
dmUgaW50byB4ODYgY29yZQ0KPiBwYXJ0IGlzIGEgc2FuZSBtb3ZlLg0KPiANCj4gLS0tDQo+IFN1
YmplY3Q6IHg4Ni9rdm0vdm14OiBNb3ZlIElSUS9OTUkgZGlzcGF0Y2ggZnJvbSBLVk0gaW50byB4
ODYNCj4gDQo+IE1vdmUgdGhlIFZNWCBpbnRlcnJ1cHQgZGlzcGF0Y2ggbWFnaWMgaW50byB0aGUg
eDg2IGNvcmUgY29kZS4gVGhpcw0KPiBpc29sYXRlcyBLVk0gZnJvbSB0aGUgRlJFRC9JRFQgZGVj
aXNpb25zIGFuZCByZWR1Y2VzIHRoZSBhbW91bnQgb2YNCj4gRVhQT1JUX1NZTUJPTF9GT1JfS1ZN
KCkuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4NCj4gLS0tDQoNCjwuLj4NCg0KSGkgUGV0ZXIsDQoNCkkgZ2F2ZSB0aGlz
IGEgc3BpbiBvbiB0aGUgQ0kgdGhhdCBoaXQgdGhlIG9yaWdpbmFsIGZhaWx1cmVzLCBhbmQgdGhv
c2UNCnRlc3RzIHBhc3MsICsgbm8gbmV3IGlzc3Vlcy4NCg==

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9833B14C4
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328996; cv=fail; b=fE0/b6tFUR5fZM4Ew3ATgxJZ23DXO4CHEi/ydlji7pUdiYGDQrNmHS92fx1P/2SS8qbye8HPeQyhttYvU2texm8+EdFyHOz9U/g/c5Cq15BzEgNiJt7ib+R2YwoPw2hLkb0XO1dEJRJrHSINDcr2Mjmrt0HSRV8HkYepgicrWg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328996; c=relaxed/simple;
	bh=6onXbqM9OWgkCfRCdll1BHuZd/m/twk2ZJiahbkItbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2EJEjgZNe59O2g939u757KRsLcKdEkDCzOClzJwNpRyXDnEWIR6mPfJ2VudyJRLtLDoyIY6Sv/AvfrtWozarQ0GxSEU5jBM58DtQVzMss7k8j3eMJnX5cniazb3laHpqfY+iSpVOoyY9ZvX0XrTIoHSQthwq6xHq+K+7fftBJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOBeVGZA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOBeVGZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783328992; x=1814864992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6onXbqM9OWgkCfRCdll1BHuZd/m/twk2ZJiahbkItbA=;
  b=NOBeVGZAAh5HeejT7fKsh/FZOwBBZKtO6s0l14rnO6MNqq5OL8mlxBOu
   NSMQ5BVuQIsdShzOPM2q2FNBO0JMgAnvr9JiZdgzaGEWURK7SdxnIMUm2
   nAezVxpjXBSDQYrC9Cs8Cw4hDsMxB9bOmj+mgybKEtvpXN3hsUyyaXukw
   C7Sml77mP3TivOta0IwzrLKudM8llk639DsXwvX56DrgeVLA6E3QDTWEJ
   +EmWlkNCUAKwyVKk8eDdVHwD2MjK0Nf2c1sn8gsdFaI8tpEsXa46xgI3k
   RjcfVlCcqB72tjua4G/oVO32y1AHDxbeYEUQ6/pHYI+ZkSdqqhcK9NNJ3
   g==;
X-CSE-ConnectionGUID: U6R8GosWTpeO1BfhpL00iQ==
X-CSE-MsgGUID: Dn5Me3ERRwKuGd0J9AnSLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101375837"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="101375837"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:09:48 -0700
X-CSE-ConnectionGUID: HbkxRtT3St6QnpePg+44Rw==
X-CSE-MsgGUID: TJYt2R62RzisdGI9uiUbow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249670270"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:09:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:09:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 02:09:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqgdUWektADMW6DDPJgox8GlIjAmC/krd63WLqMRZL7ciMmS9cpzO/n+8+79U5PLS0imXyxobThGw2jgN1HUHClK7fnmX75i/s1SUV0P1dvbqJcJIRISMldmQENbS8i8Dkn3a6nn09upNJFX1wH+V4ivTt5NPTmjn2AYzPtX9rLDINofQrbGniERmVBOvPIgFQ0T1oUNeGc2aejNBgpU+A4C5pCoC9AGBF/E/Njyrql6yoi8pV39xRTcPcr/vmpfII4h7mZfjoxJTIcbx5L+Rl2cq2ZJW7T4Mr8LW3oYFxuzOuwDWpgpR0qWXnLcvMNCppkN9b90+RHbGdlt/LrBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6onXbqM9OWgkCfRCdll1BHuZd/m/twk2ZJiahbkItbA=;
 b=Yj9s7TC4kaEcq+SZo4+SFxr4L92C5TT+E4WBPLQ5GLysIgFz8XQJAmbEEVT4CfL7V5W1CFpo2ZFeZrLcGs+iSM8fww8I9jHGmtUPM0L2Xq7fEMjnCY+swvldYNzVWfrJUUrIIlG06ZNycYNuKX0kH8P/GBjD6J8ZWwg+C+kOeu3oxSar5OiiIrDQ0HYxBZ1CXf3defAuVsz8W1BOY38LE59WLteX1Zz9FgkDlNSRJARYwFB9o/XqOR+oHxCfQmIO4vU2mZeNbc5rElWMzQBvi9l2Gmnk87fyXuOOenDeMwPsTh5RlpZo9Rpn6oaiREVZ3Pd7HffK9WGO1zVDeMm9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 09:09:43 +0000
Received: from DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d]) by DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:09:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "bestswngs@gmail.com" <bestswngs@gmail.com>
CC: "Wang, Zhong" <wangzhong.c0ss4ck@bytedance.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "shixuanqing.11@bytedance.com"
	<shixuanqing.11@bytedance.com>
Subject: Re: [PATCH] KVM: x86/ioapic: Cancel eoi_inject work before destroying
 vCPUs
Thread-Topic: [PATCH] KVM: x86/ioapic: Cancel eoi_inject work before
 destroying vCPUs
Thread-Index: AQHdDDvkXKM5hChfb0KPE1+eGFYZ37ZgNd8A
Date: Mon, 6 Jul 2026 09:09:42 +0000
Message-ID: <f654b630538d27d05ebf09a5b7ff07cee1fed773.camel@intel.com>
References: <20260705050443.1331662-1-bestswngs@gmail.com>
In-Reply-To: <20260705050443.1331662-1-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4691:EE_|PH0PR11MB5030:EE_
x-ms-office365-filtering-correlation-id: 03fb5309-164c-46ca-f22e-08dedb3e5123
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: /WW8IQQeBgHgRAvNLrnLh+0xCwjtjsWRxfwwZz4Ps6SpfFPMmpJMMjAsMboCoNLyQJ1shdvaPO5KC/qX589Ly3uE+XVOxWPMyrEbk6HEDS1oLoHdhV56NAadlWDdwKZ2V9nZ6WXXQIoQce/HHhsfku6ATsmXR2DSX5ygO4H+eaxdp+DHFkTBMTTrynLfy7YpahAqaqMEkPKKTDx9iK66AJkpCf7cu+V0WC5z9dlX+Dl3saPO+AslaMPrPFzJ+7r6X302yavtWyNFWr625JB99vsW1+FJLkJnvt+zKwcvGUxmlXqeQO2OVPtzmKe/LiKnJ30vdzdKCk7IC9olc1xntee/43jasw9ApOzBqI+3XuOR3BtibcnQyqyPoS/BBEk3IQLnMkPZjwuPKCRN6l4zM6TMudI89j48ihEBBiApR35T1qnkIQn8kbR1hnwcfjKz+VNF2fvZvkS90ssEC1U8JakzJKzhwKW8/6TwzLSeeS6VcKXLYe5xSBxa8EjTqorJQ7/s//2jAuARMncFPq6g0aAcV8e1PvEvj7RxZrYcwf+udWfu//JcybxooPYlfM0OmleYqVrJ8pFYeyM4PjTvZf2dDU5WZ4AzD2aF0r4iaOxDHvZQP4Lsxr5wDvB8dXJnkH2Hs7w7lN4OJ93lDjhvGdyXP7EyoITCSosoRd1pZvDpBTzMSHYH5aIkVlunmV8p20iMdhF4XtX4YHIMtNsGMFe/QaEaWHs9x6mYCYdZtnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4691.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmpnU0pJR0htYXIvL2FEMFp6N0MxeG1DelZON0UrYlNpUnhIS2gwUFFncXg1?=
 =?utf-8?B?RVo3QzBUTG5MaitvRVNFQTBEd2gzZStNNzZ2RVY4Njhhd0Nxbnc0M0dTWENa?=
 =?utf-8?B?N3pzVEc0QS9UdzM3bkZFb3JIMmk5VFRaU21VdTBrQXhHQXozdER6UjVqNi9u?=
 =?utf-8?B?dnozdWRjK2lNTDUzbXRVbkRDOXc4THpzNkUxSkNxWlRaMmFrbmpjWU5lNTdC?=
 =?utf-8?B?V29jM3h1Q0p1R09PL3ByOVAyN0MyY01wSnBHc3pSSEc4b1JXWTFjT0phbERN?=
 =?utf-8?B?aTA5d0s2WW54djRoemg1a1dpc2pXVzdSKys5Z0tQY1owMkNzYVNEdFZKWTJM?=
 =?utf-8?B?bHV1bnIvV2I3K0dYTDJXZGFkdHNQSHBJeGpZQ2t2VHNTV1ZTNEVpMTRaSHNY?=
 =?utf-8?B?SVV6ZUxlMWk3T0IvaGRhS3NJajdTUGdRdVZFNE1kQnFjUU1NRThnR29WOUJU?=
 =?utf-8?B?TU9sSkR5d3prVDk0aFlNL0VpbWlEQVNxMkZwUE1wMGlwMmpDR3gvRVFHdEpy?=
 =?utf-8?B?ak16VjhZbWxLQjdITDMwQjRkMjJmQ21yS1B3YURuNFhoTUIzaWlFN3ptWVlU?=
 =?utf-8?B?UlpuaWppWng5Uk1ZQ3ZDeUh1U2pONHFtVzl4cGI1V0ZWc3J4QXhaMXUwZGhj?=
 =?utf-8?B?MzZwdlVxRmYrZnJicEVIUDZldUpsNHlBNm9mWSt0Z1p5OC85SThWandZZktG?=
 =?utf-8?B?UXNURXBqLzlScDdQd1NsaHJSQmZoR0MvbFFvNjA1c3l0Z091N2NWYXZRNkdV?=
 =?utf-8?B?STgyYlUxUUk3RUlkdnhEVVZ5UUJzeHVZYUZqQ1h5bVBoK0kwY1k0djNWMTlB?=
 =?utf-8?B?YjVUc2I1MTdJZlRzZGZkUytweHV1enNDSGswdDdzT3M0SkMrRlNlemdEWnVF?=
 =?utf-8?B?K3ErOXdUVTk0ampGb2E5WTBMNytqRHhUNUdBZ3kzOXIzQlYwSWp4dmNEaTlX?=
 =?utf-8?B?NUdjaFhkVGNWdy9tQ0JOUzV0cDR5dGJ2RXJXSFB3VE96NjNEU05ZME9SQ3lN?=
 =?utf-8?B?SG5QWGJTdXI3anU3MUh2UDZHTFpJTVhiUWJ5a0NOQkpVOG5WUWhQbng2QWwv?=
 =?utf-8?B?ODF2TXQzYzVVUzVJbXRGNjdtaVY1a0g4d250dGJKNkZNTFhYT0ExU01iTWdZ?=
 =?utf-8?B?cVVEbFFydUhvQU5RMEZCOWdWcmIrWnhHUXRkVERBaDAvcVhxNUlnV2V6ZzhH?=
 =?utf-8?B?N25uaHhWNC94MTlXLzArM0VEdGpQV3I1cW45MVo5RkNvbzM5UFg0WThRa2dt?=
 =?utf-8?B?T2R4NURqNTVzaEIweWVLbitRZS9LU1ZUZnVDbzdBQ3BaMzF2OEZDVGhUMDlj?=
 =?utf-8?B?T0FYUThxdlEwY0k2dTkxbXppSHN5dUkwb0djeG8yWFBSb3UrYVJCOCtrSFdG?=
 =?utf-8?B?VURMbFdTQllYY0Z4YjJYU2FJenpKTjJUNTFhRFkzZTFZTkt4dnRMR3NUWENm?=
 =?utf-8?B?azQrYzArRnZndk96N0pINjJidmZHaW8zV0Vra1MyU1hFK2M1c1hzSnJzUnFU?=
 =?utf-8?B?K1VEUGxKbGsrZERhUGRVR0paZTFINVhrMHJvbWJZcDFWYzF2V1E0ZGo2dCtN?=
 =?utf-8?B?ZVVadXRhM0FneEVadmtCZnlwdFgrMWRUZmoraFdUekk1N3krMW5EcW9JUWhV?=
 =?utf-8?B?TEtuanhoaFY0VDFFK29ReS9DcjNvWGxsVyswMGJWcmxZL3czQVlCaWc4N1NK?=
 =?utf-8?B?cGcwREtqTXEvWXJxaFlqbkhiUFpKT2x1eW1WVVJNeW1yWUlFR3ZhczBHeHc2?=
 =?utf-8?B?ZW9DbWM2ZEhtQjVGSkFQRlNxa0RuSUJ5NitGTFVzNXlpY09NZ3dxa3pKTU40?=
 =?utf-8?B?NWVIT2ZnUEJ1UEZlMFZrOVpxWnU0NHNNcEkzMjVUZ09vSlAwMENsNStDdjEz?=
 =?utf-8?B?K20vMC9oTUtDYWliOUVKUnd1NkdUVjZsTytwanJ2MnFNYVRDU2lkVmhkZnBa?=
 =?utf-8?B?SUJ5ZlJqTWNRNmpjd0tVRGpZZ0VNZEhXZEZYTzREdUJuSDA3TXJ3alZhL2wv?=
 =?utf-8?B?bytTNHJseitWMEVETHFSdWVKUnhjZkpMV1JkUlo4bDAyNU9KbWlyZkJVWmRi?=
 =?utf-8?B?ZGk4czg5a1p0cDczZVdBcFRZVGs4d0NVbWJod2N0a2pmcmdNQXlVcWJNOGxX?=
 =?utf-8?B?MDFJcUM2c3NyNVpJKzVZYXpVaEJYejJkT3hxdjR3MHgyeUFkR01mOEpiWlFj?=
 =?utf-8?B?NHREVW9QRXpzVWJYMnE4ckhDdHdCd0JiN0pWUnhKelA0aWs1YUVyRlVnL3lO?=
 =?utf-8?B?cDJUbzlvVzR0aVNac0VWemp1Z3piTlNzeXl4QnhMOGo5bXVRTTRPVzlweUtB?=
 =?utf-8?B?MU1ESkM0MXpNUEJiQzlSc2JKMFdoWHFNWSttblk3aXZPNVhqVW1jZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <654BECF5478C2045AA115859B0FE3187@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ax4QwBznQUsy5e31Sc47/M/LRktQ39Wnv/pVaxG9FpBNlpzxVXrG5thWF0r5fX0SnCfqYjzZapGiPEFvLufmdjLg2lK13TuJSVj48KixNmJJjtYYqlwn1Odia4P5Xom959db330jh89DsKRaTRc6zdf0XqDsxhyNCJ+966xOtMeeIXNyNj0DkGoruonrjjnXXVK/vZPNSLjE3s/TpRDqJEYfzbrFixC38XzwrRaxAu+EPlUm+8EiKaF2OC93Ix6lww7ADufEujSrmWUDMkCmhgKkCJOc3g9ePGuj9AnBeCmDv3MUe2M0A1liYgxFKfmrkrh2OFkd3jkUetrRa/XMlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4691.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fb5309-164c-46ca-f22e-08dedb3e5123
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 09:09:42.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3An9bHxRHQwxpj/k3pTSJwM8QBfH8jQuIGUFIN59WQYHfAupnl8mt011ATUs1/4dLpv92xfzXErgeVUC1kM42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA3LTA1IGF0IDEzOjA0ICswODAwLCBXZWltaW5nIFNoaSB3cm90ZToNCj4g
a3ZtX2lvYXBpY19lb2lfaW5qZWN0X3dvcmsoKSByZS1kZWxpdmVycyBhIHRocm90dGxlZCBsZXZl
bC10cmlnZ2VyZWQNCj4gaW50ZXJydXB0IHZpYSBrdm1faXJxX2RlbGl2ZXJ5X3RvX2FwaWMoKSwg
d2hpY2ggd2Fsa3Mga3ZtLT5hcmNoLmFwaWNfbWFwDQo+IGFuZCBkZXJlZmVyZW5jZXMgdGhlIGRl
c3RpbmF0aW9uIHZDUFUncyBBUElDLiAgVGhlIHdvcmsgaXMgY2FuY2VsbGVkIG9ubHkNCj4gaW4g
a3ZtX2lvYXBpY19kZXN0cm95KCksIHdoaWNoIHJ1bnMgYWZ0ZXIga3ZtX2Rlc3Ryb3lfdmNwdXMo
KSBoYXMgZnJlZWQNCj4gdGhlIHZDUFVzIGFuZCB0aGVpciBBUElDcy4gIGt2bV9mcmVlX2xhcGlj
KCkgZG9lcyBub3QgcmVidWlsZCBhcGljX21hcCwgc28NCj4gdGhlIG1hcCBpcyBsZWZ0IHdpdGgg
ZGFuZ2xpbmcgcG9pbnRlcnMsIGFuZCBhIHdvcmsgaXRlbSB0aGF0IGZpcmVzIGR1cmluZw0KPiB0
aGF0IHdpbmRvdyByZWFkcyBmcmVlZCBtZW1vcnk6DQo+IA0KPiAgQlVHOiBLQVNBTjogc2xhYi11
c2UtYWZ0ZXItZnJlZSBpbiBfX2t2bV9pcnFfZGVsaXZlcnlfdG9fYXBpY19mYXN0IChhcmNoL3g4
Ni9rdm0vbGFwaWMuYzoxMjQ4KQ0KPiAgUmVhZCBvZiBzaXplIDggYnkgdGFzayBrd29ya2VyLzM6
MQ0KPiAgV29ya3F1ZXVlOiBldmVudHMga3ZtX2lvYXBpY19lb2lfaW5qZWN0X3dvcmsNCj4gICBf
X2t2bV9pcnFfZGVsaXZlcnlfdG9fYXBpY19mYXN0IChhcmNoL3g4Ni9rdm0vbGFwaWMuYzoxMjQ4
KQ0KPiAgIF9fa3ZtX2lycV9kZWxpdmVyeV90b19hcGljIChhcmNoL3g4Ni9rdm0vbGFwaWMuYzox
MzQzKQ0KPiAgIGlvYXBpY19zZXJ2aWNlIChhcmNoL3g4Ni9rdm0vaW9hcGljLmM6NDkyKQ0KPiAg
IGt2bV9pb2FwaWNfZW9pX2luamVjdF93b3JrIChhcmNoL3g4Ni9rdm0vaW9hcGljLmM6NTI1KQ0K
PiAgIHByb2Nlc3Nfb25lX3dvcmsNCj4gDQo+ICBGcmVlZCBieSB0YXNrIDE1MzoNCj4gICBrdm1f
YXJjaF92Y3B1X2Rlc3Ryb3kgKGFyY2gveDg2L2t2bS94ODYuYzoxMjg3MSkNCj4gICBrdm1fZGVz
dHJveV92Y3B1cyAodmlydC9rdm0va3ZtX21haW4uYzo0ODkpDQo+ICAga3ZtX2FyY2hfZGVzdHJv
eV92bSAoYXJjaC94ODYva3ZtL3g4Ni5jOjEzNDAyKQ0KPiAgIGt2bV9kZXN0cm95X3ZtICh2aXJ0
L2t2bS9rdm1fbWFpbi5jOjEzMDIpDQo+ICAga3ZtX3ZtX3JlbGVhc2UgKHZpcnQva3ZtL2t2bV9t
YWluLmM6MTM2MykNCj4gDQo+IEEgZ3Vlc3QgYXJtcyB0aGUgd29yayBieSBFT0lpbmcgYSBsZXZl
bC10cmlnZ2VyZWQgcGluIDEwMDAwIHRpbWVzIGluIGENCj4gcm93LCBzbyB0aGUgd2luZG93IGlz
IHJlYWNoYWJsZSBmcm9tIGd1ZXN0IHJpbmcgMCB3aGVuZXZlciBpdHMgVk0gaXMgdG9ybg0KPiBk
b3duIHNvb24gYWZ0ZXIuDQo+IA0KPiBBZGQga3ZtX2lvYXBpY19wcmVfZGVzdHJveSgpIGFuZCBj
YWxsIGl0IGZyb20ga3ZtX2FyY2hfcHJlX2Rlc3Ryb3lfdm0oKSwNCj4gd2hpY2ggYWxyZWFkeSBz
dG9wcyB0aGUgUElUIGFuZCB0aGUga3ZtY2xvY2svTU1VIHdvcmtlcnMgYmVmb3JlIHZDUFVzIGFy
ZQ0KPiBmcmVlZCBmb3IgdGhlIHNhbWUgcmVhc29uLg0KDQpJIGFtIHdvbmRlcmluZyB3aGV0aGVy
IHdlIGNhbiBqdXN0IG1vdmUga3ZtX2lvYXBpY19kZXN0cm95KCkgKGFuZA0Ka3ZtX3BpY19kZXN0
cm95KCkpIHRvIGt2bV9hcmNoX3ByZV9kZXN0cm95X3ZtKCkuICBJIGd1ZXNzIHRoZSBjb25jZXJu
IGlzIHdlIHdhbnQNCnRvIG1ha2Ugc3VyZSB2SU9BUElDIGlzIGRlc3Ryb3llZCBfYWZ0ZXJfIGt2
bV9mcmVlX2lycV9yb3V0aW5nKCkgaXMgZG9uZT8NCg0KQnR3LCBvbmUgb2RkIHRoaW5nIEkgc2F3
IGlzIGFsbCBLVk0gSU8gYnVzZXMgYXJlIGFjdHVhbGx5IGRlc3Ryb3llZCByaWdodCBhZnRlcg0K
a3ZtX2ZyZWVfaXJxX3JvdXRpbmcoKSwgYnV0IHlldCBrdm1faW9hcGljX2Rlc3Ryb3koKSB0cmll
cyB0byB1bnJlZ2lzdGVyIGl0IGZyb20NCnRoZSBLVk1fTU1JT19CVVMgKGRpdHRvIGZvciBrdm1f
cGljX2Rlc3Ryb3kpLg0K

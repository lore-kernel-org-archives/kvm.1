Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72D3B71CF;
	Mon, 20 Jul 2026 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589747; cv=fail; b=XaCW94rwuF5Dy4hq8ccPkKW3N4qeqadTkvqmWFIQ2ADGw33HM9t7mxxIQslDtSBPLsBKxJoOe9URbYIHwUCZy9l2itdkPZ1iYpLk6zk/Jka4VKB+19n9rNjhUfPiuIjrwVuebsEE8t0K7qmAO63n8FTnRfNVg/Y+qaZvtZwulBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589747; c=relaxed/simple;
	bh=ciHBgYnx9Dwbu5caJwZ42k659dqWFonpALUUCIR3P3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qn+JgORZlWS8Q3pVzkDClkxup+jPf8TkgUaOI/rKdlabrp5MlCkA2pSvpv73hgWotPuL0nCc4ycQ8Kf+EvNyJu1CDkd+m/L+35J4rVRFajo/ZMIrdPhUwSD5d2B09fHr8cj6lvsKlSxwCmLLdRzI1fnadXj9q/qMkwrOm8bNGBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1BzK95M; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1BzK95M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784589745; x=1816125745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ciHBgYnx9Dwbu5caJwZ42k659dqWFonpALUUCIR3P3U=;
  b=k1BzK95M31t4UFYpVCIMEo/zovOwXlfl3oE19f7rJoLfYicBCHlA8oYH
   r44QV7mHD/esRCpHpPSopIVrgtSKxtDJq/xxlOW9mFuBBopFldiZXNKo1
   BabWYn6bvwmaOIcxZjiMOEbU3xCWoV9PgmyN0/FvF7p2a7JYj7Ew29Fc/
   StrPrjt6r2VCHP6/+wPKFxrphKi4s9SXx6NOvaPqL5ba3lIsSSyqCGXfs
   Xwzfye0a/tl5syNsFtYYFTYoalZNuQSLYhs3HelbU2yst0DT1yB+9cnsk
   HbCGSBwU9Q8qZbkVMYHY66NGElfsj/zKWju4apvN7wOLdZOYutsZQVHXJ
   w==;
X-CSE-ConnectionGUID: UY1o/E+qQJSvvN0PF0eQbA==
X-CSE-MsgGUID: 59rUOJyvTii+BL+xQ+hpsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89076882"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="89076882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:22:24 -0700
X-CSE-ConnectionGUID: 2FFVUMN8TCa5jyHfFucL8A==
X-CSE-MsgGUID: Htp2vPf+T8y0JxeOrRtzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="282076707"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:22:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 16:22:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 16:22:23 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 16:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV3TubD1mJPmfeYgomyXBuBb0zSmurD7ZNqnwNhxog4LNoeklvS/yNJVqr1StRSN5aD69SvxWf6XD7zdPn7R1cBZTAAxwj06W0/72khnRg51ispcU99x8RadyygwL4rov1slH2LlhIuyoGotDJGYDOZjyskpQjEepQhhnJvtc+/Twt2gk009ItqxKMraLmr9dhVNu3mzGF0q//QEY/6j4NIOifcEZHoFzWat3yJbrrhG3/j5VQnyY+LsbXLm0Jf2qzGPh7ZXDSY8SauD9UUqwIlOUzujYHPN43b17Zxk0+K8Ik61xveLIEuJCV6f7R0KITCGOp0S8U50VnIo/bvPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciHBgYnx9Dwbu5caJwZ42k659dqWFonpALUUCIR3P3U=;
 b=q8W0BYj6J1ajdSIfamqZgHVhU5eGZNpXiV/U+21sIjEMdRFuiS+kd4SM1EFMcFr0dwetTrtPny702N5sf6DA+d3wPaNqzkxlRTdPYT7V9g1sb67e9c+x/jnlXWFnUwzaZCQm4KI9L0XMgSQN3LmQfmcDc09NIjGo5Kee3M4wOVNV31geYqCEudhuRjaOQ88ghPDJdtJYNjolvJoGKS8uN1YyAtpTE0o4nvq1NBXYKPa1ET81/wCW/4Maes5wGHL2ihl0I6eqrQRwcobdJYCPrLCn92koHNLFO3niADEa+KrG7ResA6Jz3ZOAI1Ih7DTQAGBgqrFII4MMENWLsGYJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Mon, 20 Jul 2026 23:22:21 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 23:22:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "aashish@aashishsharma.net" <aashish@aashishsharma.net>, "Gao, Chao"
	<chao.gao@intel.com>, "guang.zeng@intel.com" <guang.zeng@intel.com>,
	"dmaluka@chromium.org" <dmaluka@chromium.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "vineeth@bitbyteword.org"
	<vineeth@bitbyteword.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jaszczyk@chromium.org"
	<jaszczyk@chromium.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Dong, Chuanxiao"
	<chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Topic: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Index: AQHdFT1oryK9eXkZBUyCu3X3875SjrZxrcGAgAA4CYCAAFQYAIAExsmAgAAO0ACAAAE+gIAAAgIA
Date: Mon, 20 Jul 2026 23:22:20 +0000
Message-ID: <ca2aef4bd776ca9613a5614e14974e6fc188dd7a.camel@intel.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
	 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
	 <alpWONLi8h2T5WhZ@google.com>
	 <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
	 <al6eg7C-2sDBEAFD@google.com>
	 <a4f683a52c096d8a7cd7d6c4ab895fd41f197eda.camel@intel.com>
	 <al6r-2sAm2tVh1Wn@google.com>
In-Reply-To: <al6r-2sAm2tVh1Wn@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|DM4PR11MB6166:EE_
x-ms-office365-filtering-correlation-id: e67febeb-5cda-49e5-c986-08dee6b5bf85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: RGxA69TWvtA2Wt9dx+3QZnwudEmkUoaSrCJhi23SDODTvs0oLieZanqMe6++PpDwDuByLCcKi/plEOi4NrHV/yndxw0TYHkawG1QnkDQjydNqjcv23h2iFn3lX9uomxftnSUA+VK1dp8psXsiqEd28Alk7N13LZa49+dBxsW9SUCPhVP3YH5Htep/LC5ENbDIK0pbiaaoNxVneGytOSk1/fbZQVpMn9/1fNJ/jDo7IXF0wgjjD30yWIbIxnW26jZlDeLIdBwkmhPCsvX02Q1QKpGoZQyQQkKOR/iJQacnrA0v+Tl4p9Ez9MXlfhZnJ488uLYaQ44YOTIE7f+l//dKHHzKoauJNP1bumPeWi5HumsPOKlZeQAopqrZuMj+ymD2zE1udnygvByjUqjCw0gaRFYlc65eCNXHVNynCcy+VyRd5q0KlPsYgetWQIgCKUC3BTnkupt/VplC41xq8YXxhCntGnpd1KUsGHHSHldS/t6PAOLwcntAleL/kl9iuVpk0ldBHwmkEOvVc11uKeZNagx5OYSmiTPQ+6g1fxS/1pgzTdHE8E2EISs3VKq2U94Ob1WDJtnfNU7QA1g+4Kc5ZEZ66Zsi1TqmE4AIAVg48eT7UOHHvNLeL3mIfC9C50yRVCAym64nVLs4Fj8a2clYnk/3nS6R3WdiswBj5aoEPnky02N8uYwely+kp1yZlG8orCuw4sF7uVPMgu+jD9qmZJqtG61g65a5Jm0vP9GI1I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akk0a3hyTi9iTlFram0zSStkdVo0cy9uVmVrWHc5Kzc1Z3VYaEVSNFc4RXhD?=
 =?utf-8?B?QnJKWHdPUEFBUzdDYm1xZlZpOXg2dGxtV1RPMHcvanBGYUxMcFREb28zbmhw?=
 =?utf-8?B?L3JHSjVvbUJXMDFKZk1mMVZFQ2pnL2NqaUxFUEtmdklrOC90dGZlZ1BvQnZ5?=
 =?utf-8?B?bDF2QzVYaVI1akVDSXdZcnZDSlNtVmxPOENqSjBBRllzV0VPZG5wRlpFOWVU?=
 =?utf-8?B?VllCd0JHcDUzejVrTit3bjd4QlJiRzYySlhHYWh2YnV6ZTdsYzJrdHlzNGFN?=
 =?utf-8?B?Z2taNDlOZkFEZGE0MDhCZUZWM3UwNzF6RThwTUt6enZ5R21NemU2ODlyNmth?=
 =?utf-8?B?OXg3Wm1nOFE0MnAvR0lLZmdiNWhmd1pOR1l0aHRqNnloQTJZeE5xTUFTU3Mw?=
 =?utf-8?B?aHN2UnhTeDh6RG9YVjRDQVU1bzcvSVB4dExuaFFmbm5ZWHlaaTliQ3VqQmZZ?=
 =?utf-8?B?ejF0VWdGNGU1VkNOZ3gyUnB5SUdhekY1SE5sdWt1dGxEcW8wOG5lOEtqUXF0?=
 =?utf-8?B?QU04aVdMWFR4YjFISlVBNGxBZVIyUnZ6blY4UG9lcDBJaHBGRFVZSW5DazN4?=
 =?utf-8?B?aWNIV3lHeDQxZjZkeHhwek9vYTFHTHV6MmM5SHVWejV5RGE1OC9iRlA1QjNY?=
 =?utf-8?B?dU8vdWowSDY5UzRZWVVRQVhNbVA3cWxDUG56endSU0c1ejFvbnBOWlpVbkRB?=
 =?utf-8?B?TEJJcGhrME1aZTQrUE9pR2p4bFU0MFhLKy9zbGprczErK1lJNmZuekNJYXk0?=
 =?utf-8?B?MXRuM1JvVXZZNlRZNC8wZnlhSzZPUjVMTCtPemMzTW0vNTNGRktYNHRSV0sx?=
 =?utf-8?B?OEFGZkxlTEJiMWM0NmFwUk1zS3B6cnJ6RlEzZ0pyRE8vV1ZQTUZnQmVJUWZQ?=
 =?utf-8?B?TzhPN2lsVmVWUU8rZGxZdFQxeUFvcG1CbE1rOW1GUXNxNjYwZnlMSEpBZFFp?=
 =?utf-8?B?Mkdwb215MVFUeEdudVRpY0dXcmwrTG83Qmg2UVp4RDdaNExJNkE4N09KVUVG?=
 =?utf-8?B?dlh6RVpaSTYrTk05QVFOQkdVcW0rZ3FKb2dmYUFiNUcySzRWdUZ4ZlJnc09j?=
 =?utf-8?B?V2xVS29HUWpOaUdpYUVaakhKYll4bVJXM3hUK1lBMHdqZ2Yxd2I1dzZVOExN?=
 =?utf-8?B?UVhFVkt4c09YSkt4MlpmYjZKVjJSOGM1VFRlbGRuMk4xSEs1eU9EclQweEYr?=
 =?utf-8?B?ODZudFBEc0VzMGcvdWgyclkxb3piaDY3dGtjSlYraWpoQWtmeW5jRWdpTjRO?=
 =?utf-8?B?Nk9UNFJ1SEFtQmZTbWlxSXd4czFVYUZIcEhKWVZiOGVXUEVweW5IbWpPd0hS?=
 =?utf-8?B?bE9LREVuWXA3TjVRS1grZ1FuUUc2cWpvNTZtZGl4bFJFaXY4MVZvb0IyLy9X?=
 =?utf-8?B?TW85dVBxa3NTSktNY0xFUXk0eUhOYVBwUnVvT0hiOENYZ2VjV2hScUFIVFBi?=
 =?utf-8?B?bVpONllrV3F6R2lkQ0g3bFFKVHpHV2NkTFYyMSsvOFNHOTBtdnV6OGpoREdz?=
 =?utf-8?B?ODdWREtzZ1BweGhlWEM1TkdOaktMb1gvRDNDWWNDbmlCakJqNTExSzh5OFVs?=
 =?utf-8?B?WFlRWnF3RkJhY1MvemRnOWNsUDBremlBc2JVeUkzYlBPMktlUTdOZTVzTDlF?=
 =?utf-8?B?cVlFZk1BYnNZOTdzMkRNWURlcFc4ckJVaDd0NFZ0QngyMDNFVm8rWkJuWWs4?=
 =?utf-8?B?TjN4bFFMY3NveDI4N3lMd3FrMFYzbms4aXJQalErdFFZQld4a3lHb0VLWmRO?=
 =?utf-8?B?dmVDYXdEVmxZZXZxcUs1QU9GWnNkN2lrTmZVYTdqTndXS011TzF2VnJEUVhl?=
 =?utf-8?B?TGZMWFNqOGlPenpTa3lXSHFkZ1FHMUlwdERMT1ZOajVNRSt4cWJxTjg2NHor?=
 =?utf-8?B?YWFBYkZQUmxvMFoyUXdrSXhVaW5HbStvT3dWKzdUTFdNMjlWb216M01kTHJ4?=
 =?utf-8?B?SmNET0M0bjhBeUVQaTlDUE14a1ZQYnB2R2Y0ZEViWjZ1MEoyWUFkZTVyUmpH?=
 =?utf-8?B?NlNrcVQ2OWtucHZrWWRHTDNuREZlTXRKeVpYRjg4aGF2Zldod0oxSW91cUpF?=
 =?utf-8?B?UGdXeWRSYXdTVHlBNGRkN29ReS9BVUttYkNyU2RYbk05QVEwM21nTVRvRkRB?=
 =?utf-8?B?bWhqUDYzRnAvMk85M3hlRDJ2QkZrL0JoeXF5d2h6SFNtMFhzak45WVlSU0J3?=
 =?utf-8?B?djk2Rk1wMFBuZzBaNlkwWk03L1hEaFZKNDFUakNOcG5NeFlTMVpSTWVOOHZN?=
 =?utf-8?B?ZllNNEIrVGlzQys1KzdmVzJ2ZTlWRU1xbFY2dFVYN0tMZEJYc1FNZEk1UjJR?=
 =?utf-8?B?bm1KUjRhYVQzNEN3REVsZS91c2k0b0ZFdDhjaEQ2OFZwUDB1dzAvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADB3AA880B0A5A4B89B41DA74B79545C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BV4qmDfBcZMB5E9qVBWxxx2d+BIqlxM5UaTF/WRj4PXXw9pGo5Wh2waoZX3WmwvT1cyN/fbWeIrjJFvyF5OjdHJVF8NOHPKBHgNIFUi5Df59oDuWJ9mFywZ0CdLpMLao9LYnv33+iU6xZaTv9Ku7RXCwWu/y/qTC+s4xGFdMPP6w2A4wub5FOESwTlO3XFg/j22RE/iFmPiYizCtZI5LAxjuqZdpZAWNIC3mAzdfIZkWKwsQRbRvBafeiXCm0Dv08g3I/piQG7VHBTvhfPGBmL47gnmZEQrjNwYyuW9DoPb1BtH1TyeDSrBxJR+2jYx/HqNJWJvuY5ypfmwPNtoq2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67febeb-5cda-49e5-c986-08dee6b5bf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 23:22:20.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+u32KDwauQJp9F5/fXrSgGRpFzs+kPtHaOa0Ya92i0o/c+IlkZUcA93n4H6glwZzSqcmNWr/PXylkIf07LtWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6166
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDE2OjE1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNeSBvbmx5DQo+IGNvbmNlcm4gaXMgdGhhdCB3ZSBjb3VsZCBjb25zdW1lIGEgZ2Fy
YmFnZSBAaWQgaWYga3ZtX2FyY2hfdmNwdV9wcmVjcmVhdGUoKQ0KPiBwZXJmb3JtcyBhZGRpdGlv
bmFsIGNoZWNrcyBvbiBAaWQsIGFzIHg4NidzIGltcGxlbWVudGF0aW9uIGRvZXMuwqAgSG93ZXZl
ciwgSQ0KPiBkb24ndCB0aGluayB0aGF0J3MgYSBtZWFuaW5nZnVsIGNvbmNlcm4gc2luY2Uga3Zt
X3ZtX2lvY3RsX2NyZWF0ZV92Y3B1KCkgKm11c3QqDQo+IHBlcmZvcm0gYXQgbGVhc3QgYmFzaWMg
c2FuaXR5IGNoZWNrcy4NCg0KQWdyZWVkLg0K

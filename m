Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AF42CB1E;
	Mon, 20 Jul 2026 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589055; cv=fail; b=G/VxG3TmCqT1VnVg9V+GhA8LY96u8agJgn7vmiK76h9sUQfZ0ed3Ti/bHzl8BnKOez988E3FHvb86CeNrL9rv4tD7OTVZ0DYL8y0XwImD6zNiEJKp9BZDwZDK+51hbYylbThDflzRzXnu51gUjF+P++VgmQAfpRMJxt24MAcFTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589055; c=relaxed/simple;
	bh=ri0BsP7skdFeR2Tky+kOTk2JQSd4RFJxad41pnztyyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gEbi1OiJqDkof8rr4SCxeMgSdsnPzGUWmoEo1yEqz4hf/kZ+dOuuJxzt7NPi4Nb+jgrSd8Fp9HS7mSQ7N59ZmZXuV4yp4Gm9Dt5GXsLpXfYW+NvLTgEFPAibc4dZO8RyQ37OO4/huYl6jnWjZEsTDQ+yDZ1aXWbz9pL6uHH1Bcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUnWP5wB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUnWP5wB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784589052; x=1816125052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ri0BsP7skdFeR2Tky+kOTk2JQSd4RFJxad41pnztyyI=;
  b=FUnWP5wBHWCvsGuT7Kteqsp6Zuqg7SlNcAfUMPHwjEA4eRJoeBruxiHf
   IQ9ht5JtCu+rP1iZLHfFti/ZlE6uFzqpJMq8skq6/mwxRhAMPCusb+la7
   9ld26KKhQxyI8A1Jec7Hhl6ZzETzeyJQhKLgqHNzEpHS3CPdbdvKIY0bw
   GWJJqn82RTfNdcZhCvC0fDvUBqe1Vl7K64yZ7fxB+d1Z6ILse21AbEyFx
   zUEvZEm15EX6XgUops0XyWv83MHjoqwjn7mFXD1STS5xw6FKz8X/53qNJ
   c4hn7eZT37/qFo8MM8INNyo8B6T/YDueA1C0cCz/H5CUm9N3Bsp1gfxpf
   g==;
X-CSE-ConnectionGUID: 1o9fy1geQzqeFlrq4fvmFA==
X-CSE-MsgGUID: WqJfW+PISvSmD2lyGXdufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85057801"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85057801"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:10:51 -0700
X-CSE-ConnectionGUID: yWrHmRjUS2SvkV2bWDQs0Q==
X-CSE-MsgGUID: h0H56bXiQ4yf/C0+5IpU2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="287640253"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:10:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 16:10:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 16:10:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 16:10:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d76nP1T72zSwIW8pGfnbt8soDd7hf2yoxknm3jJKjFuBy5rZEicqSxL+E0spQD2j0TcWowM9ZDLvGSIrPVNyaslzLqQ0MZzzSH8gM50y2w9d7Vj3YowUnt/S2nRGqs3t0mOiSHkgOFiCqNZGi9ROknVTD7t0wkgWELW2cTcU7VtlGh/+roZkICNoWlURMKbQ/OtGY0/iJk3ndyGstufg1wUZoy1FaR79N2mn706oBl648e+vRf/QqcEeEXe83YS1JJ4T25YNJxFGNP6HTB0wAJc9v9FDSm3B0a9ITZuS8Hc8eC6Dbudr/rVi6ZNuiR9UsTUwuhj7DSC59W8U7oYFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri0BsP7skdFeR2Tky+kOTk2JQSd4RFJxad41pnztyyI=;
 b=F9vb0Ru895frYn4oHSaHNRxAxaHG5Yq570cCyIDQusag9y0PK3k0Hj7tvtHSEHgaWfOkHVhZL3O2OOD0ObGTgQ3ecVdtXB5p+CEfByiGq1ASqQiCpxslNYZvc/ffJgvK785XnHSunPvwJ3UoeuVpzlT1lgUl/KOsBo8roAOCG/KHtwv7jxn8slIPU0EeTkZ7YHB4DNY9F6zSN6vjBFH68fMhXrGLsYnZiVSIEn5Rpoiqzhke0Rp31LzVo8IRbqN/D8VjAK3LijTIDZg0+dmT+V7UlOU2BjevQFObCkeDJZS+GZgRbSdZbWxzBHXSXZX8Cwo44JqxqwPJHK9h6CLT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Mon, 20 Jul 2026 23:10:44 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 23:10:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "aashish@aashishsharma.net"
	<aashish@aashishsharma.net>, "guang.zeng@intel.com" <guang.zeng@intel.com>,
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
Thread-Index: AQHdFT1oryK9eXkZBUyCu3X3875SjrZxrcGAgAA4CYCAAFQYAIAExsmAgAAO0AA=
Date: Mon, 20 Jul 2026 23:10:44 +0000
Message-ID: <a4f683a52c096d8a7cd7d6c4ab895fd41f197eda.camel@intel.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
	 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
	 <alpWONLi8h2T5WhZ@google.com>
	 <af8fc5537970157b693a9bcdf134e14b29b1f1ff.camel@intel.com>
	 <al6eg7C-2sDBEAFD@google.com>
In-Reply-To: <al6eg7C-2sDBEAFD@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|CY5PR11MB6509:EE_
x-ms-office365-filtering-correlation-id: 0af96e04-6428-4864-7f5e-08dee6b42066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7FGVdDsZ9YrHfulX3kt4LKBGd1IqXOciy5xCEVGl5yCqU1hJgN8F5xcD1UQHoo92XP63Yx8nfysf9x7CyBFJ8tTHq89T/SURjAtb29KDBcEly7EEf2EMXRTHGMxgnVGBaP4WoXCJmA8eMbT/NzTqUf4sj/DBf8RFoJ2hauebEaEDOk7v2cQXSznfm5dDtZ/teb9mCWyDbtl2B+V8sko02GUPjH3OupsM/SfwLD2ml0EqKL0ES6Pz0evHfaXbC8fpW5HUz6sgV72IjZb1qX6xQ5FsJPPFAne4F8aXlc5moTwSupXsaazf/AxLdzBjkyaTP8y0XkX0AH6uaaZfC/kxz5Qksnx5N9hQqys5MI5XDQkRr+rcK1kO/2cM+XbxFYbF7e+Uss+Tp39d78cltnVymGrF3Z9pIRnpfZJpCSVvhmdMYMBkY/wEgJGXEnN8mj9K0TN7BxbrLIqB42ii4udClrWkha7sbo2yk9Fz0NgAndcZjueeYYUWruDU4AKmnpZxRCstoUzpFNCiLD+ZU5oZLm4xkXjAWcpsqjgTZJiMTDgIl02Hrbjl8bipsX2GhRmnOxJY5KcnM2A9vZggT4NjcjNpFahmeHF3vAE++DEQAXxfOBDRtDeL31VzXzkG0NUAQD8rwk/psPgl9XQeY3tyU17XCzjy1UnJ3Y0/Xl2zv86nKYeTw517bdT2mUL1spSq/7wwJh7CKALxTUurwDZGEnL3FoRon6BNuO/GshxqsBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWkybW5yZi8vcGUrNkhMWE5GT1hwaVM0dWd4aGcwdFFGVGk4ZlcrUmFzVFBZ?=
 =?utf-8?B?Mjhka1MxODUzb1pISkZiZmcvWVVsV1QzakI1Ym1vWDZseG5SRFVsVTd5R3J3?=
 =?utf-8?B?cEdVdXBpanBDeW9qWDFlMjJxUWRRMWQ1R0tWbEFpanp1TGVncHdhY2ZRS09Y?=
 =?utf-8?B?WjE4Y2VoOTdyR3g5VFg4TWFLV2lDdnFWY2E4UDIwMThaNjI1cVRiQjRyenp1?=
 =?utf-8?B?ajVFN0l4V2UrUEhYejdRWllIb2p3MENiNUdOSkZLK0pTQ2xOWUloaFYrc01z?=
 =?utf-8?B?OStiK3g3T1hlWC8vK0kwMVdoREdxNWNjYXdZVzRSZERRQjY4c2g3MTFiY3JV?=
 =?utf-8?B?VGhoN0szSVl0RlZHR0hldGhTS1dWUUxQV3loRHY4QjRTVTBXbXdnc1NOczJ0?=
 =?utf-8?B?dTJ1c3RqVVZOT2pUS09BY2RFNm5HTURQcmphKzFsZGtjVTlOR1JrM0ZWVnEv?=
 =?utf-8?B?NERLRWRwMjZjYmJlU1hTd3lWc1R1VW9DWUJ5UURNOEgvV3dMUjlKakFGK2Ny?=
 =?utf-8?B?b3lLYVprZ2kvbzdPZnZsczBNRHRpVHp2aVYrb3hNOWIzbDF0M0duM1NOM0lP?=
 =?utf-8?B?ZmxkaTJrK01UT1hGc1pqQUF3RjVnVC9kdHdUYTBFdFFxTDBDWmw4MzI3SjRL?=
 =?utf-8?B?Q2xlZks5S0k2eWRkSkhsUHAvYnpSdHFVR3B2NkRCZDBHT0pJZG1UeWVJSzlM?=
 =?utf-8?B?dHhONml0cFlrVEwrSXFVazVxZzh6cDVzenpNeXkyd3paNXVHTExEWjFQenMr?=
 =?utf-8?B?TWhyR0JDeWU5NUJqaWE0T0xEOVhSQXdkLzFLdjJndGdhQkJaTDhhUkRyQUh1?=
 =?utf-8?B?dnMzRTFTbkQxbEZLbGY3R0x6amZHdnlydGJoV3RqZFpzQmRrUFpZeFhkNkxi?=
 =?utf-8?B?TTZBbGJNNmJieHRqUzRpYm9SZ1JWZ2VNRnBVQUJIMmZ4R2g4Q1JIT2lKcXdQ?=
 =?utf-8?B?OVc1bDVNZ09qWjVSN0RGczdDL0ZyczNmRDc2V3hPTVFyMEdOZ01Ebkxoc2ZG?=
 =?utf-8?B?aWtPM2VEYUsvT3BrdkxpTVd2a3JrelVKclFJN09FZTh1VFRIRlpsYWRIVTFG?=
 =?utf-8?B?SHY2NzcwREZQNFd0bTY3RDJpQnN5QW1wYnJsK1hFOXl0eWViVVRsSlVRNU5i?=
 =?utf-8?B?VEJVcGJsUERNZUhpMVBmbEw4RkdyU0xSTW5rL3h5VEJLSDFHN3hWU092UzZs?=
 =?utf-8?B?c094OVlIME9Sb1VmdTJtaXp3WE5vcVUyWXdYVjl5UFZKTWVPTzdQNGczYnlZ?=
 =?utf-8?B?WU9namhUQ3R6ZTBlVTlucXE0Kzg3QTFzTFhQVWZLQnplQ09xWmMzTzJsWWl2?=
 =?utf-8?B?UTh0UHlSZkdnd2R2NjNubnAvbFk5TEhSRCs4SkliWUNMb2MxQmM1djg0ZXcw?=
 =?utf-8?B?akVRbjRneC9ZdjFyTXp4aXFqRFkyaEpMcjJFYzRIZlB4NWliQzVQVlMvbENz?=
 =?utf-8?B?WWxGNTliZWo0WmVKeDhKVjlvZkNUK1hlaGcxNGhoQlpEZWZVTUUrczdIUmdQ?=
 =?utf-8?B?ajVBbUUyTnB1UjNGUUtrQllxZlVoKzBIRERNWUVFRnlUdnFnZnBHc1h6bk1p?=
 =?utf-8?B?ZkJQSjFQeXY0dmtxaGRmZzk0RHZ1QTdoVTlPTkVlalRBaEg5aXRCVlZKTDFF?=
 =?utf-8?B?UGJ1Z1czalRWYis0TkhtTXFtYndRTy9LWXZMKzZONmRDSk5xekw0K3dzOEps?=
 =?utf-8?B?T0ZRa1JGb2tGZXBCbzY0amNscW1IMkdESVEzL1RIVnQ3QXdWQTZkY2h6a0ZM?=
 =?utf-8?B?OXFESkpnb1A0MGNLS3Ztbm9WSEVwV09XNTNGazE4aUdvWXo4andoSlA5MnF2?=
 =?utf-8?B?V3d0VDA2bitWTVZLNWxySjFqQURuNVkwUW52eExCM2FMa0VGc0tjS2JBeUsw?=
 =?utf-8?B?Zy9KWkx0MjdtaFA0TnhaUXZERzlkakQ2U3AvNm9OSGJsVEtKWUt3bi9XcnhB?=
 =?utf-8?B?TmJnZ2dqb0kvYWkzYXorN2FuMERFKzVSUW02M2c5aHl5ZWM3dzlNNVdHS2pR?=
 =?utf-8?B?Y0JFblRHY1ZXZGN5M3RaejY2VzVPaGhKQjRIVFk2MGtWWlJXeDFUc2dUNGI5?=
 =?utf-8?B?NitVci9mbisrcmQzdnpGUmhtZFc1V1U2cU9aMDFuWGhsc2N6c1h6dDJ0a3BB?=
 =?utf-8?B?VDcvbnZwbWxITXJpVFpYbC9Eb3U2M29sbm55blJUNGxrUWZ2Wm1wM3Q2dVFy?=
 =?utf-8?B?VlJtTTBlb3FTVUhxY050SSt0eURBMXZvOHAyVE10YmJyT3h0Ny9uVXdTQVVX?=
 =?utf-8?B?SzRpdG02bHZ4Q2hkNlBnTzRiS2Q3eU1uT2hiZ1FTbGR1Q3FmdThoMEYxOHdC?=
 =?utf-8?B?MlVYU1pDbitLTmRwSWlacCtyMy9lMHB0ai8rMmV5a0pZdE9ET0JyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CBE77C0D9B20B4AB91A165827659E0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mh5nRJIKUKJIkvYQ/9kJlhCMplbVAey6DwPlvtb2oSjnWwYMvxtxHrrrkCzuoQGhL5PZ94hk2aub9r0nykJUYn6WzlQxl5bFFprsBw/JWLakpeFfSzjd2k8T6kTgciwma58zBe72p29sUqAMyFkd6d28ucDaKG3SYDGAvbcR2pG4RiMvPZ9SfCkNEa9QW4DBe+ZpOmACRgtZMPKsLlIZU+Zw/gz3//Mx5GoQMwsn8SKkxLxTyzjb2F2ix6c7a8CfNByXA8FhSttgHK2R1+e7aN7oJbQd3s7dZKEhI1RORvf9mcNjuicQ5XZbp4JyZCeJv2iUY3sHSEVZ476hS1rKsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af96e04-6428-4864-7f5e-08dee6b42066
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 23:10:44.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUoOQRsKLD1SQlFqYB40QeRqmoNI8Qo6uqkR6wFhyFRyFw16LG/jg2Qui3mPrALhhgUc8AFaY/l1kdqyTJhRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com

PiANCj4gSW4gb3RoZXIgd29yZHMsIEkgd2FudCB0byBmaXggdGhpcyBlbnRpcmUgY2xhc3Mgb2Yg
YnVncywgbm90IHBsYXkgYSBnYW1lIG9mDQo+IHdoYWNrLWEtbW9sZSB3aXRoIGJ1Z3MgdGhhdCBo
dW1hbnMgYXJlIGFsbCBidXQgZ3VhcmFudGVlZCB0byBvdmVybG9vay4NCg0KSSB3YXMgdGhpbmtp
bmcgeWV0IGFub3RoZXIgeGFycmF5IGNvdWxkIG1ha2UgdGhlIG92ZXJhbGwgbG9naWMgbW9yZSBj
b21wbGljYXRlZCwNCmJ1dCB5ZWFoLCBhZ3JlZWQgdGhhdCByZWplY3RpbmcgdGhlIGR1cGxpY2F0
ZWQgdmNwdV9pZCBhc2FwIGlzIHRoZSByaWdodA0Kc29sdXRpb24gdG8gYXZvaWQgc3VjaCBidWdz
IChteSBmaXJzdCBnbGFuY2UgdG9vIGluIHRoZSBmaXJzdCByZXBseSkuDQoNCj4gDQo+IE15IG90
aGVyIGNvbmNlcm4gd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlIGlzIHRoYXQgdGhlIHZDUFUgYmVj
b21lcyByZWFjaGFibGUNCj4gYmVmb3JlIGxvbmcgYmVmb3JlIGt2bV9hcmNoX3ZjcHVfcG9zdGNy
ZWF0ZSgpLiAgV2hpY2ggc2hvdWxkIGJlIGZpbmUiIGZvciBJUEkNCj4gdmlydHVhbGl6YXRpb24s
IGJ1dCBzZXRzIGEgcHJlY2VkZW5jZSBJJ2QgcmF0aGVyIG5vdCBleGlzdCwgYmVjYXVzZSBpbml0
aWFsaXppbmcNCj4gdkNQVSBzdGF0ZSBfYWZ0ZXJfIGl0J3MgcmVhY2hhYmxlIGlzIHJhcmVseSBj
b3JyZWN0LiDCoEUuZy4gbXNyX2t2bV9wb2xsX2NvbnRyb2wNCj4gaXMgaW5pdGlhbGl6ZWQgaW4g
cG9zdGNyZWF0ZSBmb3Igc29tZSByZWFzb24sIGFuZCB0aGF0J3MgdGVjaG5pY2FsbHkgYnVnZ3kN
Cj4gYmVjYXVzZSBpdCdzIHBvc3NpYmxlLCBhbGJlaXQgZXh0cmVtZWx5IHVubGlrZWx5LCB0aGF0
IE1TUl9LVk1fUE9MTF9DT05UUk9MIGNvdWxkDQo+IGJlIHdyaXR0ZW4gYnkgdXNlcnNwYWNlIGJl
Zm9yZSBwb3N0Y3JlYXRlKCkgcnVucy4NCg0KRmFpciBlbm91Z2guICBUaGlzIGRpZG4ndCByaW5n
IGEgYmVsbCB0byBtZS4gIFRoYW5rcyBmb3IgbWVudGlvbmluZyBpdC4NCg0KPiANCj4gRS5nLiBm
b3IgdGhlIHhhcnJheSBhcHByb2FjeSAoc2tldGNoIG9ubHksIGNvbXBsZXRlbHkgdW50ZXN0ZWQp
Og0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaCBiL2luY2x1ZGUv
bGludXgva3ZtX2hvc3QuaA0KPiBpbmRleCBmZGJkNjk3ZDAzMzcuLmUzNGNhNTkyMDM5MyAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgva3ZtX2hvc3QuaA0KPiBAQCAtNzkxLDYgKzc5MSw3IEBAIHN0cnVjdCBrdm0gew0KPiAgICAg
ICAgIC8qIFRoZSBjdXJyZW50IGFjdGl2ZSBtZW1zbG90IHNldCBmb3IgZWFjaCBhZGRyZXNzIHNw
YWNlICovDQo+ICAgICAgICAgc3RydWN0IGt2bV9tZW1zbG90cyBfX3JjdSAqbWVtc2xvdHNbS1ZN
X01BWF9OUl9BRERSRVNTX1NQQUNFU107DQo+ICAgICAgICAgc3RydWN0IHhhcnJheSB2Y3B1X2Fy
cmF5Ow0KPiArICAgICAgIHN0cnVjdCB4YXJyYXkgcGVuZGluZ192Y3B1X2lkczsNCj4gICAgICAg
ICAvKg0KPiAgICAgICAgICAqIFByb3RlY3RlZCBieSBzbG90c19sb2NrLCBidXQgY2FuIGJlIHJl
YWQgb3V0c2lkZSBpZiBhbg0KPiAgICAgICAgICAqIGluY29ycmVjdCBhbnN3ZXIgaXMgYWNjZXB0
YWJsZS4NCj4gZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1f
bWFpbi5jDQo+IGluZGV4IDJkZjhlZTllY2Y2Yy4uOGJjNGY3ZmZkNzZkIDEwMDY0NA0KPiAtLS0g
YS92aXJ0L2t2bS9rdm1fbWFpbi5jDQo+ICsrKyBiL3ZpcnQva3ZtL2t2bV9tYWluLmMNCj4gQEAg
LTQxNzksNiArNDE3OSwxMiBAQCBzdGF0aWMgaW50IGt2bV92bV9pb2N0bF9jcmVhdGVfdmNwdShz
dHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGxvbmcgaWQpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gcjsNCj4gICAgICAgICB9DQo+ICANCj4gKyAgICAgICByID0geGFfaW5zZXJ0KCZrdm0tPnBl
bmRpbmdfdmNwdV9pZHMsIGlkLCB4YV9ta192YWx1ZShpZCksIEdGUF9LRVJORUwpOw0KPiArICAg
ICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmt2bS0+bG9jayk7
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcjsNCj4gKyAgICAgICB9DQo+ICsNCg0KKE5vIHBy
ZWZlcmVuY2UgYmV0d2VlbiB4YXJyYXkgdnMgYml0bWFwKQ0KDQpTaG91bGQgd2UgbW92ZSB0aGlz
IGJlZm9yZSBrdm1fYXJjaF92Y3B1X3ByZWNyZWF0ZSgpIHRvIGF2b2lkIGFueSAicHJlY3JlYXRl
Ig0KZm9yIGR1cGxpY2F0ZWQgdmNwdV9pZD8NCg==

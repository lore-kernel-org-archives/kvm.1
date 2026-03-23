Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FC261B9E;
	Mon, 23 Mar 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278247; cv=fail; b=F2NBZMo1q7DzWac3+I5Y02w5y2QpQYGTyjO6x2YU1Zm1+l7oL/DW1qexpNTyPbwOKVT1ykgr6rsUSg21qAwkkMf7PkLt1X7MUpmrBalT6oB/kUfxe5IWm7OfmvzylX8dFWEyGu+fUEK90FelqKaNMDrqOr394N94wQWLiIrh0Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278247; c=relaxed/simple;
	bh=/hN6rLHZaerwwQ6UcwIdzoHOQe8uQ/ZsemmHbz9oYB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsNXN1OUIGuAqvaTvwLRuU5PKe0JYQXp6gMlwnw00lXPNFECtPC6yp166z7mxlYJge9DzrldTOnpGjZw8pRscSZbS2EL5lIwrR5sCcgKvwTPQqrIPPA8Q3gKwRYlrBflDq2n8C+h4N9QQ1h+etxtCJv1mxAnj37rnmOW0rqjAJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gpH0BuZK; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LfYIYlpN; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gpH0BuZK";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LfYIYlpN"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NA1iIV3570698;
	Mon, 23 Mar 2026 07:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=/hN6rLHZaerwwQ6UcwIdzoHOQe8uQ/ZsemmHbz9oY
	B0=; b=gpH0BuZKyz4BKDpJC5PNraana+oxqx/jCIUUzvnZIh4TtsT8PmSKn1xy6
	ZVgZgRf+ohV6EdSMmeeSJBP+IEGhAq40k2keAhrysHuYyfxVMFtiBlPkfwUWVY9X
	ZG5zH51W/R5h/iQDvSVrs7Q6Cng+V0IyNlcOM2yqAGicLII1TLiI/RlU+y88iJj8
	q6IYMcpX7oNOP233kEgO/9b0R5wzfSf6ezsExFCocANziQYnnmiojfOrVhX4qLb0
	jxznsXo/YH8dLqW54T5bC7HaZ6NaWXf1RUXjCMcIh+nYuMGCjjISFBHcg9QPI6ng
	3f6BcLs9t2Eoln7pEoNzanOs5cdyg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d1rv3m031-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyXf1u8dhRE5Xa4VEzThmyJnGoHSiu8yQlf+BOvil6h2cGVeUKs1O+vZkQ4R6DbOW7gOCvPa9hRGOTqOQnDrF6G0RY9QtKpMQJengCJ669aZNT7w12MGgPmd7MebRNZEnxmZxuqsEXb61deaZBmP9IYjk8/5gWOaar8zsL4Z9AO9XtfVYu9v+4b/AeCLtrkkufOaqQzf9lC85nu9C8G9JDp10knADewfDuLaGAocgkdL8JtVguYDvjnrOpaYjJaK7ELFvFSOkMopasGdzlecnLLyWY/dzX1yRS8Z7xv2Qgzy3KTzpO8wWpMZzMyJMuU4EADHTRneWY57FFBcehp+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hN6rLHZaerwwQ6UcwIdzoHOQe8uQ/ZsemmHbz9oYB0=;
 b=hlwLGnqvkDN1oGgPoK1NFe7cqa+qQYNKmXJmavBdt3uLWJHbAnqDPO0kYAW3guGmPTHUaTE4vDtqKcQH8OLQKP349QnVuCbbZFW8r4PgJG4riiGfjUSs7/WCLDx/hohAY/zmD/O/X7aVcUMX+7vlqZ/kLQEnNupagaAFn7qD5Im7oug5AMOvc+dJbcfyqjc4eQ4coSovyXkd7FZrUKT4KIZ8sxIrUaee8DgNBcorYjaslsQdMVEwumNBhrEY6zApsO+X7Rhvbuj2//NXVO7CTw+rtsfHQmb0Z9+lTHIa62U1Dk3Ron9NSCgm4CX8QGs1bDLKput6zA7h6Yq/Tzjq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hN6rLHZaerwwQ6UcwIdzoHOQe8uQ/ZsemmHbz9oYB0=;
 b=LfYIYlpN/qjdQ5MYRVKq/1TXLhSqoEzE6bhTTMECDDhcigi2sDr3K9XFBA/WLiR98RynLD7OMuCaTW5dzaBhhZMjGIY7FjTpz48YpntJp6VbUSQvK/E3nOhm+MOCHShCFrHORPD8dZA0Cy7hUUvz6GVCQZDNoeW3x13kZDU5zpSPkTNpkz2MKNyodIsMiDAHm5+y/B2Zrx8dM1nGDN9IC6jyOmUbFUY630ECWhsydnpBK5IU01HGoElIkUpAp+Lq+9Lv13ZJ7SFbyy+8aDShUIuzqJmohSqfgZqiS9/ahWXk124M/wjF7+FCzkmNZTMBFoR/IArPQQdvokFrzK4GoQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA2PR02MB7772.namprd02.prod.outlook.com
 (2603:10b6:806:149::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 14:49:01 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 14:49:01 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Marcelo Tosatti
	<mtosatti@redhat.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Amit Shah
	<amit.shah@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 14/22] KVM: nVMX: advertise MBEC to nested guests
Thread-Topic: [PATCH 14/22] KVM: nVMX: advertise MBEC to nested guests
Thread-Index: AQHcuMcYdabLHrzi8kCLUfiwKhbEX7W8NsQA
Date: Mon, 23 Mar 2026 14:49:01 +0000
Message-ID: <11C29832-FA13-4A3D-835D-2AC7145D8129@nutanix.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-15-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-15-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA2PR02MB7772:EE_
x-ms-office365-filtering-correlation-id: 700afca6-c0ce-4d1e-e79f-08de88eb5248
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 te4R7CCjwfUdigEUcvNrafBA/OQ4jG0pBmBenpvTALVz7e1s40HemG0MJ7IjYtuYvJO4IxVSzii2e4vLZ0MVLgTV/Sotc2vxNDMvrR6vpt1/ucgPmZibDXKYs44/pR0Cs/jnpmUsunfW/FqiDfdM6KCwZ/SeM4sHe2l9Qg8ZpF09v+BdcyKymPrFQ/cIyQRvni7QPCvaLLMQv2kELA45+TcQouZhX+ZP1kYfhmqdWyzrHLBpSjrrfjmePrt7UmuiSCNzNe0PWPiQy7gjaaYttZcIHVigCVs+o6/ifT/xh6gALVUrl+0+XUk6q5PlO8VXFZADNdDyJucbIbRdFNi8DQQo0JK6hR9+nhiam91i4NL3JDEufyeNjqr2ykabd6cS2SrvAEZA4LKuD9koB9uZ/dlYI65S1NpWd2S4PIhDRADxI+7hmV3/YmtXgDRdpSrQO2JruVOjWKJKwMzNZzXTLRcspRnZEmsy2Vch1yeqaCgaAJS6L8tpnD7BsZBCww9DPh99NjTCcSMII/sHO2RuBZkAlYgi5QrZFRFU7KlCcaAkABtfVSGtq89HgWcLM+MQXCV+oWxwZ01zDZbxbGKgWVMw/rRozgBmA7uFGWtiZGhq2m87EYwMW3R2//zhjGLItwMm+wN4Qc8/FdmnyPCcSjq+QXVUqoHo1EWCmy6kzMUssT2Qi0mNcWoL2fPjq7jFQfpn5ddXSyYSUPQIvaSzL0wjmBY1CGa8biJtNsNikbQjqHJVWZM9+evo0EPDMtF/YVDuxvjwNr2ksEGg5xx2QAGx6Ak/tgseqbLPiNef9A0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1RkSFpyTTRISTQ3U09nS0lOVWxPR21ucXBVMEhlOVhRNXFOb1EzVEhCaUR0?=
 =?utf-8?B?QkdCRTVEYnN6UFh0SFI1ZWNnOXZEbEJnT3ZaN3dkbDRQTTRyZEYvODBGQTFk?=
 =?utf-8?B?K1ZITUkwM0ZFWjE4Qmw3VEdRMDVFdHc5aXlZYTNQTWtYcHNkSkxlQ2xYL1cx?=
 =?utf-8?B?VGpxRXZGTXhEMEVCYzlvc3VVS0w0MzRlTFI1dGZNZ3c1b2Q1aElWNGlleTZz?=
 =?utf-8?B?cjRyQ1NTZllaSWFTWC8zTURMYmduM3BnRGp2M1ptczEvdTRnWVNVL1FpcUY0?=
 =?utf-8?B?ai9SSXZSclY5d0xkQmdKLytCUnJVQUxnN0ZTV2ZGcEcybnVBeU5XL2hNYlRt?=
 =?utf-8?B?anZFMExQUkxSbW0wQ1hoRGx4aEpsRnRBZGdObEw1S2c3RFZULzBTY21VL1M0?=
 =?utf-8?B?Z2dJVkJFMDcvL2pPT2pFVk9TRWFBNUp6UmM0RHR2L2pWQlFnS0hud1laRkZw?=
 =?utf-8?B?ZG1nL0txalNIeXU4T1BGMms5TWJxbFNwc3JXaXcxQjRTSHJydk02V2pqeU1u?=
 =?utf-8?B?V055eVZFUy92YW1hRTE1SHBDZlIwNXVUUENKNEFia2k0Tkk0eU1CT3YzVnZ4?=
 =?utf-8?B?aHA3M0ZZc1BDVGlJRFlDdUtqblpuY2R5UTQ2WUpGTkRGS25uczlsNkFKa1dp?=
 =?utf-8?B?blpyK2NzcmNuQ2RrNlplN3JHcGRmdGhueGxqNmR3T0hOd1dQNWpmOHBGNW5x?=
 =?utf-8?B?UzdicjFjS1V3MkhZeGJRT0t3WVZVMzZsNnVEb0hmSzNNbmJuV1J2YVFRREtC?=
 =?utf-8?B?aUY0MlkwdzhSS0hjTzJ6SGpFclN6djdTa1h1dlVyR3Y0ekpiMlN6VytuM0ZF?=
 =?utf-8?B?WHR0WjRpQmFpNkRCeHY0YTBKMm5lL2gzVWkzeFRORFpJYW9kMEVKTEFFNzhD?=
 =?utf-8?B?NGZTck1ZUmRNdVNnNTUxOHoyaFJmN2NXNEMvcXI2cTNjQmVYWGtaOHhkd3ZI?=
 =?utf-8?B?cC9kTktpYi8rN21YTEVJaklKd0V6UGtkYzRhZWJaVytma3NVTmtaVUdWWDdC?=
 =?utf-8?B?MWEzU283QVc0ckpmbjJzd0JnQS9MZWFQTEdaY3BJcFgvQm44aWhGeU1Obktl?=
 =?utf-8?B?aG5EZHBIOVFhOVdmeUh4eTNiZVVmbVIxYXJxa3FXYlI2T1AyZzNwaDExTlIr?=
 =?utf-8?B?YzBwRkFpOW5oZXJsdmJheklJVitudlllaWZMSWNoQTI1MTAwZ25SNFZQdU1O?=
 =?utf-8?B?MUg3S2RiQnpIT3lwSGZQeDNuckl5S0ZCczJGMEg5eTQvWlovVzZsWlRRWnhV?=
 =?utf-8?B?NzcwZG5nK0E5eUtVdWJCZ3Ivakd4a3JQbFY1MEYvUXlHN3RvblRxVG5RQzI2?=
 =?utf-8?B?TmZMd3ZWSnArZ3E0VzU4VXRNYkQxNHFZc2xpanRweE5JbDJQTFB3WTVkeVFH?=
 =?utf-8?B?YlU5SHFjUlFtb3RnZ1pZb3NCam1ObWdyL3pHb2ExOEV6THV3UkZGdjNvWEti?=
 =?utf-8?B?aldrdktRNmVpTHdveklDS0M1YnNoTUNtenY0K1ZtWmw1WklKUHFtb296R0dF?=
 =?utf-8?B?bmd6TXRwQjAxallOT1lDQmhIUEQ0MmhHK3Q3R01JUml0THplbXNyRGZMK2Vu?=
 =?utf-8?B?RGRQQWJVMzB6cXkwT0J4aDN5RU1UN3VYSGFjOUJZMXJCRXY4Nzljd1l0VnJS?=
 =?utf-8?B?MXEycG41dUlvalEvNXF2RStJaXlVTkJGUnlGbVVBWTdEYmZHQ3R1VDNVaU5u?=
 =?utf-8?B?c2IvTnVVMmFFSXNzL3RjVkJMV2RDNjl3WUJPR3c2WEovL3REUGJaTXBqS3Fv?=
 =?utf-8?B?TXEzT2ppV2Rxc1VMck51UHQwTU9EWCtzNWoxVklaV2RGZWNrOTliMG81NnA4?=
 =?utf-8?B?dzEyb0w2a1JVR2V0Ly8xZ2czM2dDbGI2U2x6WEtBTUR6OTZyYVB5YkloTFpa?=
 =?utf-8?B?TEtiMVFTQ0ZRYXd1dmZXMHBxRUM2emFFcnZHOHlsaVA2ZWo1VC81YnBIMmVt?=
 =?utf-8?B?a2VvalFreDNWUDlEQlBTTGFDdVRhMm9ieUV6MitQcXNRSkVCK1Z4N1kzU1hT?=
 =?utf-8?B?aDUxVTk5RlE4dFBhcTJ0bms0NUpaRnB2SXdwNGVsMnZDNmNqREJnYW50U0pM?=
 =?utf-8?B?SHBETWo5ZzB2QmtyQjV5ZWQ5MkppTDU1a2QwbDNlbGpZdjRQNm81SlE3Mzkz?=
 =?utf-8?B?bHVZOFJ2K0E3Wk9aUXA1RVlERjIwaS9rV1Y2NjdZVnhLVzdwM1dPRHhRVmRG?=
 =?utf-8?B?NGRpeUM0aWkyc2VaeVFRait0ZmFtcTU4ZStjQXdDSld1SVoyMExPVVRaWmRF?=
 =?utf-8?B?dEdoRFgyZ0dBTG1HMlF2VkNaOEVzKzM2bHJXcWVvVWJrNXN6Q1VmeFZxa0pz?=
 =?utf-8?B?dlA3VG5QcXhtMldCOXZiOHM2SlJWbVRoRDRkbTVvcFpEM2FOMXF0c3M4akp0?=
 =?utf-8?Q?Qyqv1FBHxWqxxqRhaOcs+BmKWygb/CGH6Xhm0CFtFRIv6?=
x-ms-exchange-antispam-messagedata-1: RccSzvL6t+Rx1iAQgHIMzoYp7q/N/5glb2g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <946E55C552B0464488A59CE3A868D1D6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BA7ljjpeLNyoBjE5rIhPKDDGGsaq/8eoB11ddYQAMtgkybSQw07dgDAuOhW3EqInmwLeCnQtiQFH7Rf5bADp1uNSlWBQIOIDVn1rwNzHhnQJtw/lTslPZNRsjvxRVgbJra16rZsx7QMCMK0bHTiYNcqbVvzyUqDMS2eBEOy5cAaEXVSfh2uqMrXWY+3jKvC8SlkhqYCenpuUnrWFK6ty71k/ok4Z6wPnf/8x4aEYrvx/ubTYeNV8VirmcRw27xK7CJSGLcKrzqzoe7CNT52v2iZjpUwIMP2sWjj3ArhU2CClth1iQO5rgPiiQRby9r+D+HlS1xH7NnRAqw9L87ZUdw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700afca6-c0ce-4d1e-e79f-08de88eb5248
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:49:01.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xc7dnDUKt38iL1Acs4zTtiGUGV3wkox5uSD+PUWwAXg80HOpky9Z8NM3l5NhWQSJ1vNK2f3pkCzwtKIe8nSEpZXNQD2h0+56QH/RdrDVBD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfX+lEuONB5E809
 7UAcv8A41tD6Z4YOvhc1Z0d/hV/WqMX46PiXY7Wwxq2b6+0s+h1y8XUflxLVWUiXHEqBuZyXiu+
 eFGPEiN4YNe2h1bv6neBu2ot61lNJgwH0FbmBOPKAXkA2x19DppB76pntq2R25lGUcTXgv87DVs
 YwdV3qECdIRetDtLOsD1ygbZ6caByl8ozpfGwIGY1FdZRo5yxDhKGJAHP6ZyE2NhFuE7pw1KOeh
 DAprAC2n1/JmUi/UWihYG6xuzMeQyKLg4uGg9dlF7ED583BtlOf1CRlxxOxDRsrHxl/7uXQYEDU
 kTEBKJ2EtTmteUFwQC6gzKd0vnfJvknH4ZL742dZApnNVc0D8sZdawmZRIaMCvKA3Yp1P++MGIH
 InrPpTEEk0zvXXu9IAxxqbBkYJyqmSruEkkic/h8LxQoCY3kQVi1NeprR/2Wss3+KpQOTHlgKvW
 HAJC1v53V/mvlWNSgSg==
X-Authority-Analysis: v=2.4 cv=bM4b4f+Z c=1 sm=1 tr=0 ts=69c152e0 cx=c_pps
 a=MVTdNaybHAW3nHwJGrV5wQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=zrgLkORtyKN3I3bQ_BgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: RkgGKZXiryfMU6gDUXos8GrTvOOwQaoU
X-Proofpoint-ORIG-GUID: RkgGKZXiryfMU6gDUXos8GrTvOOwQaoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDIwLCAyMDI2LCBhdCA4OjA54oCvUE0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gRnJvbTogSm9uIEtvaGxlciA8am9uQG51dGFu
aXguY29tPg0KPiANCj4gQWR2ZXJ0aXNlIFNFQ09OREFSWV9FWEVDX01PREVfQkFTRURfRVBUX0VY
RUMgKE1CRUMpIHRvIHVzZXJzcGFjZSwgd2hpY2gNCj4gYWxsb3dzIHVzZXJzcGFjZSB0byBleHBv
c2UgYW5kIGFkdmVydGlzZSB0aGUgZmVhdHVyZSB0byB0aGUgZ3Vlc3QuDQo+IFdoZW4gTUJFQyBp
cyBlbmFibGVkIGJ5IHRoZSBndWVzdCwgaXQgaXMgcGFzc2VkIHRvIHRoZSBNTVUgdmlhIGNyNF9z
bWVwDQo+IGFuZCB0byB0aGUgcHJvY2Vzc29yIGJ5IHRoZSBtZXJnaW5nIG9mIHZtY3MxMi0+c2Vj
b25kYXJ5X3ZtX2V4ZWNfY29udHJvbA0KPiBpbnRvIHRoZSBWTUNTMDIncyBzZWNvbmRhcnkgVk0g
ZXhlY3V0aW9uIGNvbnRyb2xzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9u
QG51dGFuaXguY29tPg0KPiBNZXNzYWdlLUlEOiA8MjAyNTEyMjMwNTQ4MDYuMTYxMTE2OC05LWpv
bkBudXRhbml4LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+IGFyY2gveDg2L2t2bS9tbXUuaCAgICAgICAgfCAgMiArLQ0K
PiBhcmNoL3g4Ni9rdm0vbW11L21tdS5jICAgIHwgIDcgKysrKy0tLQ0KPiBhcmNoL3g4Ni9rdm0v
dm14L25lc3RlZC5jIHwgMTAgKysrKysrKysrKw0KPiAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3Zt
L21tdS5oIGIvYXJjaC94ODYva3ZtL21tdS5oDQo+IGluZGV4IDJhNmNhYWMzOWQ0MC4uMDM1MjQ0
Y2NiYjVlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vbW11LmgNCj4gKysrIGIvYXJjaC94
ODYva3ZtL21tdS5oDQo+IEBAIC05Myw3ICs5Myw3IEBAIHZvaWQga3ZtX2luaXRfc2hhZG93X25w
dF9tbXUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25nIGNyMCwNCj4gICAgIHVu
c2lnbmVkIGxvbmcgY3I0LCB1NjQgZWZlciwgZ3BhX3QgbmVzdGVkX2NyMyk7DQo+IHZvaWQga3Zt
X2luaXRfc2hhZG93X2VwdF9tbXUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGV4ZWNvbmx5
LA0KPiAgICAgaW50IGh1Z2VfcGFnZV9sZXZlbCwgYm9vbCBhY2Nlc3NlZF9kaXJ0eSwNCj4gLSAg
ICAgZ3BhX3QgbmV3X2VwdHApOw0KPiArICAgICBib29sIG1iZWMsIGdwYV90IG5ld19lcHRwKTsN
Cj4gYm9vbCBrdm1fY2FuX2RvX2FzeW5jX3BmKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7DQo+IGlu
dCBrdm1faGFuZGxlX3BhZ2VfZmF1bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZXJyb3Jf
Y29kZSwNCj4gdTY0IGZhdWx0X2FkZHJlc3MsIGNoYXIgKmluc24sIGludCBpbnNuX2xlbik7DQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS9t
bXUuYw0KPiBpbmRleCBhMGI0Nzc0ZTQwNWEuLjY0N2RmZmI2OWQ4NSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYva3ZtL21tdS9tbXUuYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+
IEBAIC01ODM5LDcgKzU4MzksNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChrdm1faW5pdF9zaGFkb3df
bnB0X21tdSk7DQo+IA0KPiBzdGF0aWMgdW5pb24ga3ZtX2NwdV9yb2xlDQo+IGt2bV9jYWxjX3No
YWRvd19lcHRfcm9vdF9wYWdlX3JvbGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGFjY2Vz
c2VkX2RpcnR5LA0KPiAtICAgYm9vbCBleGVjb25seSwgdTggbGV2ZWwpDQo+ICsgICBib29sIGV4
ZWNvbmx5LCB1OCBsZXZlbCwgYm9vbCBtYmVjKQ0KPiB7DQo+IHVuaW9uIGt2bV9jcHVfcm9sZSBy
b2xlID0gezB9Ow0KPiANCj4gQEAgLTU4NDksNiArNTg0OSw3IEBAIGt2bV9jYWxjX3NoYWRvd19l
cHRfcm9vdF9wYWdlX3JvbGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGFjY2Vzc2VkX2Rp
cnR5LA0KPiAqLw0KPiBXQVJOX09OX09OQ0UoaXNfc21tKHZjcHUpKTsNCj4gcm9sZS5iYXNlLmxl
dmVsID0gbGV2ZWw7DQo+ICsgcm9sZS5iYXNlLmNyNF9zbWVwID0gbWJlYzsNCj4gcm9sZS5iYXNl
Lmhhc180X2J5dGVfZ3B0ZSA9IGZhbHNlOw0KPiByb2xlLmJhc2UuZGlyZWN0ID0gZmFsc2U7DQo+
IHJvbGUuYmFzZS5hZF9kaXNhYmxlZCA9ICFhY2Nlc3NlZF9kaXJ0eTsNCj4gQEAgLTU4NjQsMTMg
KzU4NjUsMTMgQEAga3ZtX2NhbGNfc2hhZG93X2VwdF9yb290X3BhZ2Vfcm9sZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGJvb2wgYWNjZXNzZWRfZGlydHksDQo+IA0KPiB2b2lkIGt2bV9pbml0X3No
YWRvd19lcHRfbW11KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBleGVjb25seSwNCj4gICAg
IGludCBodWdlX3BhZ2VfbGV2ZWwsIGJvb2wgYWNjZXNzZWRfZGlydHksDQo+IC0gICAgIGdwYV90
IG5ld19lcHRwKQ0KPiArICAgICBib29sIG1iZWMsIGdwYV90IG5ld19lcHRwKQ0KPiB7DQo+IHN0
cnVjdCBrdm1fbW11ICpjb250ZXh0ID0gJnZjcHUtPmFyY2guZ3Vlc3RfbW11Ow0KPiB1OCBsZXZl
bCA9IHZteF9lcHRwX3BhZ2Vfd2Fsa19sZXZlbChuZXdfZXB0cCk7DQo+IHVuaW9uIGt2bV9jcHVf
cm9sZSBuZXdfbW9kZSA9DQo+IGt2bV9jYWxjX3NoYWRvd19lcHRfcm9vdF9wYWdlX3JvbGUodmNw
dSwgYWNjZXNzZWRfZGlydHksDQo+IC0gICBleGVjb25seSwgbGV2ZWwpOw0KPiArICAgZXhlY29u
bHksIGxldmVsLCBtYmVjKTsNCj4gDQo+IGlmIChuZXdfbW9kZS5hc191NjQgIT0gY29udGV4dC0+
Y3B1X3JvbGUuYXNfdTY0KSB7DQo+IC8qIEVQVCwgYW5kIHRodXMgbmVzdGVkIEVQVCwgZG9lcyBu
b3QgY29uc3VtZSBDUjAsIENSNCwgbm9yIEVGRVIuICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rdm0vdm14L25lc3RlZC5jIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYw0KPiBpbmRleCA3
YzU1NTUxYTI2ODAuLjdiMDg2MWQwMjE2NiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3Zt
eC9uZXN0ZWQuYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jDQo+IEBAIC00NjAs
NiArNDYwLDEyIEBAIHN0YXRpYyB2b2lkIG5lc3RlZF9lcHRfaW5qZWN0X3BhZ2VfZmF1bHQoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiB2bWNzMTItPmd1ZXN0X3BoeXNpY2FsX2FkZHJlc3MgPSBm
YXVsdC0+YWRkcmVzczsNCj4gfQ0KPiANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBuZXN0ZWRfZXB0
X21iZWNfZW5hYmxlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICt7DQo+ICsgc3RydWN0IHZt
Y3MxMiAqdm1jczEyID0gZ2V0X3ZtY3MxMih2Y3B1KTsNCj4gKyByZXR1cm4gbmVzdGVkX2NwdV9o
YXMyKHZtY3MxMiwgU0VDT05EQVJZX0VYRUNfTU9ERV9CQVNFRF9FUFRfRVhFQyk7DQo+ICt9DQo+
ICsNCg0KY2hlY2twYXRjaC5wbCBjb21wbGFpbnQ6DQpXQVJOSU5HOiBNaXNzaW5nIGEgYmxhbmsg
bGluZSBhZnRlciBkZWNsYXJhdGlvbnMNCiM4MzogRklMRTogYXJjaC94ODYva3ZtL3ZteC9uZXN0
ZWQuYzo0Njg6DQorICAgICAgIHN0cnVjdCB2bWNzMTIgKnZtY3MxMiA9IGdldF92bWNzMTIodmNw
dSk7DQorICAgICAgIHJldHVybiBuZXN0ZWRfY3B1X2hhczIodm1jczEyLCBTRUNPTkRBUllfRVhF
Q19NT0RFX0JBU0VEX0VQVF9FWEVDKTsNCg0KPiBzdGF0aWMgdm9pZCBuZXN0ZWRfZXB0X25ld19l
cHRwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gew0KPiBzdHJ1Y3QgdmNwdV92bXggKnZteCA9
IHRvX3ZteCh2Y3B1KTsNCj4gQEAgLTQ2OCw2ICs0NzQsNyBAQCBzdGF0aWMgdm9pZCBuZXN0ZWRf
ZXB0X25ld19lcHRwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gDQo+IGt2bV9pbml0X3NoYWRv
d19lcHRfbW11KHZjcHUsIGV4ZWNvbmx5LCBlcHRfbHBhZ2VfbGV2ZWwsDQo+IG5lc3RlZF9lcHRf
YWRfZW5hYmxlZCh2Y3B1KSwNCj4gKyBuZXN0ZWRfZXB0X21iZWNfZW5hYmxlZCh2Y3B1KSwNCj4g
bmVzdGVkX2VwdF9nZXRfZXB0cCh2Y3B1KSk7DQo+IH0NCj4gDQo+IEBAIC03MTQ1LDYgKzcxNTIs
OSBAQCBzdGF0aWMgdm9pZCBuZXN0ZWRfdm14X3NldHVwX3NlY29uZGFyeV9jdGxzKHUzMiBlcHRf
Y2FwcywNCj4gbXNycy0+ZXB0X2NhcHMgfD0gVk1YX0VQVF9BRF9CSVQ7DQo+IH0NCj4gDQo+ICsg
aWYgKGNwdV9oYXNfZXB0X21iZWMoKSkNCj4gKyBtc3JzLT5zZWNvbmRhcnlfY3Rsc19oaWdoIHw9
DQo+ICsgU0VDT05EQVJZX0VYRUNfTU9ERV9CQVNFRF9FUFRfRVhFQzsNCj4gLyoNCj4gKiBBZHZl
cnRpc2UgRVBUUCBzd2l0Y2hpbmcgaXJyZXNwZWN0aXZlIG9mIGhhcmR3YXJlIHN1cHBvcnQsDQo+
ICogS1ZNIGVtdWxhdGVzIGl0IGluIHNvZnR3YXJlIHNvIGxvbmcgYXMgVk1GVU5DIGlzIHN1cHBv
cnRlZC4NCj4gLS0gDQo+IDIuNTIuMA0KPiANCg0K

Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2526FDAC;
	Fri, 17 Apr 2026 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776388718; cv=fail; b=DLcT1JusR1QVCiIY8Sx3wx9pSSMhjYdHC8Tn3iCC6NK8XhAyY/yXF5TlCUKkddc6O0qLxIAj2BA7mCRtumMFnTuUCp013KJOox4qT3lHW9AbeH4wykt0TfDDQBmVDi9EDIsOGnMXZy6dtIls9cJKYIxmbyyrpxbyWz/pVUHPbUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776388718; c=relaxed/simple;
	bh=wG2dApnAuOhqCinnEZ+VSqgb8fUdrSxKnM0t7aOcThs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umNq5Uhxpd0R4xgdDtT+R5S6i+76g5cMkTJGBoGBLYT8SuQ7aOBzi388XccFNpCchNRzXmubl/Yeq8AA6RR9aE1sPGieNhZQVmv4qnnAxJCVaKA4cXuvbEq/VqSsh3/whjr1kK+tzx+Li4Bq8Q925GzKGmqYzj0MDFyXB9E9VEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=XBOYo9uz; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=YML85eP1; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XBOYo9uz";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YML85eP1"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GMuVmY1821490;
	Thu, 16 Apr 2026 18:18:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=wG2dApnAuOhqCinnEZ+VSqgb8fUdrSxKnM0t7aOcT
	hs=; b=XBOYo9uzzLLendhYyh4gc3haJ0akm4cFjP5BHDlOhB2uuT8fi2kQ8ZLbK
	QslQv1XV1gwoAEIe5wK/vMJjoPT+PpczGJ1wKZ8vdBH8gGVThyKqMCJu3YNHlFhH
	7cf/lfz6pLzA+7sv4f3tTcjemd+pEOt11RBj4wDWd+cak6XWYdavxYHkcJiIs/Bw
	WRdu3g7yDQ0SpKTdaeUKOWnZtStwDcVMDGzqU3oM0QLL95Df44RM1qDU3YKheDTK
	qGfa7kFMH6WlYQ/sVtPYmosBbeHIJb1a42v9t+75V+26WJSQ0oAhVECHT3v8rKtH
	ZQZQr9N5RYKn7oQZJJZ2VyWR9sUjQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020125.outbound.protection.outlook.com [52.101.193.125])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4djm4sb7c2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 18:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvp+2MfZBIVlmXrj1Bl9MeHmLVGaD7Qs0OGKwGPCDK++VARUuQf1F+AYHBK11Xt5LTI/G8sEunrVr514P9hWCDpF69737jjJCtKCoQYLSBQ+FFb9x1ZHN+/trF9nwd/MqgOW8zatigz151w/mlVZnWMbgG3idUzecAH59bZp9wXk+pthNPo1dPi7i1iRNxs3DScvBWiAJB4u/C29fy3IioH7qOw6KS3UoIF5twLdHQfFTfTVJw3LH5QvCa/+e8mKt2vMmBBzuvPjHkgcTIwuRfEQxty4qIWs6K8rAaN2NBzeOCqxYcunbl6w1e4l1/i+xP1uErbwOdEHz/wBdHCYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG2dApnAuOhqCinnEZ+VSqgb8fUdrSxKnM0t7aOcThs=;
 b=LgvvoWXif3mxMkmYICTQ8hl8Pb2jZ4Y5Ze83JJNZWQAakl3fRBHCo5UsGp0rvSqZLoVZYj4jxcZ9/vdjDwChX9MZ+g0PMEuaosTn8gtNsqOfNDNbj3z1Tnt9Wtcp2/avnHazMyCGg4ei3RQG/Y6NCSTQS+f1dPg3V1MH65P4HjXzDdcWXMUIukRJ2tuiZ2d6My+UFdR0oAUlkvIIjRn9jqHcNnb3BUklRfAGCLTud+SzyQT1HdkbThwyERncbbllwKMRDhbgFfOlrWaR9v213N/KApJcy/Qpn++gk+FP7aiMxKY62G4G0Kwc5hqu7jsTaMG0aS5ont819ndBZ+Po3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG2dApnAuOhqCinnEZ+VSqgb8fUdrSxKnM0t7aOcThs=;
 b=YML85eP1qt+8M+P0GcaPnch8v6UT86GPbmAhlm4v3nYmF35FJyLpi43m7I5WPLrECQasTD8tRhLqT2DSD/Xxfp1Ibjbc7gdfOAAnDWa4HGT9GW8/uHr9H6QvZlLj/OvxDtr75Ytwf6/Sw844Vb1k2Q5R6dpXbZhLf7N4USufzCJqtmUWkQkw/IXL2hXITsZlObAzRepzJJAMgczqOkPfmPdXxTDF3yHo3CYC+dO2mWQv+gKmaUqzZGLoYosA1kJUrQar/C2w1372cIWxoWw+/aIhNzd2/eJf/iJwaIYs+04wJ8jbv07bRy7/UT2d99gnKov1SMdZ+HKmVcrsfbClDA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CH0PR02MB8133.namprd02.prod.outlook.com
 (2603:10b6:610:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 01:18:20 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 01:18:19 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania
	<nikunj@amd.com>, "Shah, Amit" <amit.shah@amd.com>,
        Sean Christopherson
	<seanjc@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/27] KVM: nVMX: pass advanced EPT violation vmexit info
 to guest
Thread-Topic: [PATCH 16/27] KVM: nVMX: pass advanced EPT violation vmexit info
 to guest
Thread-Index: AQHcx25Y9WtQYWtQpEKzGYjig8/WtrXigT2A
Date: Fri, 17 Apr 2026 01:18:19 +0000
Message-ID: <CA9801A2-376C-4E71-90A2-8426F7188335@nutanix.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
 <20260408154217.458420-17-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-17-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CH0PR02MB8133:EE_
x-ms-office365-filtering-correlation-id: 61da2437-417c-4507-60d7-08de9c1f3618
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 CUjd3195nfKVX3vx+/ZsHwHhHT+Ovmra05ucDVNEkamtSdZqHZMxeU05trMnICdjerIKlM/NB1V5oa/fYSq/sYxG7uFVhTYWQY09eQyM+FnogUjsvvWWvGnUHxELQN6u/L+xAtDPhX173KLMKc2Xd5duv9WHa+m0lfDlVENraTv0rnCK5QnVQmv6bhEQ7DImtbU88FPt0O6GTUN8OXf5gbHh3k7LK17Ci/A7Wn3/8V+6jGdnd3IpCeSpo00BuOaqdga7PSGgnyOu9gVnQvhIwu/JUwRPCko8HB0Cffza8SAmvFUGrcfAS5MxxUlsBNj45vp4oQuHQrCA50nATZ9MYBWCIcrYiHYxmXiMTDpZFFpA7lrDQ2R70P90ul8zeeO8n9Iq4IPKyw3BcAh+oM9l4RmUa5w5QbWhNGwOyriOkbt+VCEJii8zxKXaZ2fp/6pZS6Up8F8bWkR7Jt7g3Hj+Ng8ZhLBU9jL2Cmte3cl5cD02jb/u49tK35e2q2WOTQIR7zjMh4jSu5NXxw9ax3333+Ug65okoQmBfWtBVePEQS6zPD0+4PiX6w4t1O2/1z+SVF2Qo/4GRiCyXqq1ExGgjNlLK66UQQNYPoyq1Kovp04yqWm5WWdE58EhCDUgZsYIjc0/C34UHHzmuX2UwmAUC4498UkOnmT2D3Bo/Nucygoa5zhrkDg/gXxNWoKGrJvl3hkdcrxMzGyGF7otQeNPMFF1RkrAMXYzW7bav5xBrvDOaPwGwFVWz59h/fg4JgF2aSALNtvicoGrJuXq+X7PinEWw446DRyaMRKFMvRTkPs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDBUb3pvVzd3azdRdUwxU0laNDhUZXZXYXpOcWNVZ3JUY2ZKVlMwSVVyK2Jz?=
 =?utf-8?B?WG1KN2t0dHpkUEFPd2RobHIyYktBMElPSmNXM0xRaXZNVnJTTWRBQ3B2VDBV?=
 =?utf-8?B?TFk0MWtTVUpPcExlOVNGN1BhTzM2b0tpdUY0Y1B4VWJpQy9CcTRZaGxjYmpT?=
 =?utf-8?B?TG43UFRtaGNBeWhlV3VUTW1pU0RYQml5OHNBaHZTVDZUMHdGdDFISkNrWVk1?=
 =?utf-8?B?N1ltelBwRWxpSmswcjl1UW1RR2trOENBVGRDVGdsem5PNm9DRmNyOWhBMjlQ?=
 =?utf-8?B?STdlc01ZUU5Ea2pSZFN5SGRBOFYxQ0gzMVR2Wm00ZG5KVzFwNEJnSDV0Y1U4?=
 =?utf-8?B?eHY4T2ZSUG9GTGtPRG9FVU5jMlpyVFllL1I5ZTZEcTBMTXN5UVlLZUU2bndV?=
 =?utf-8?B?QzJNRjBrWU0yUXRBVWowL0tERmtIbHNiejRpWFp3dnZOZUgrYm9qUjE5ZTl1?=
 =?utf-8?B?SVFUNDJ1aWNSMDhXeGlKdWJzcTFob05lMnlWRU9ORUpOYU5RSzQvRkVHQm9G?=
 =?utf-8?B?YlU1b2draHZrb0dMUnN5U1M0OGVEWS9MTmFhSlg4dEFLR2Y2RE00R3Uwc3M1?=
 =?utf-8?B?b2JkZzBYV2hKdlNhbkJVUm1PekEvYmFhOHFKcXE5d01TZ1JXbi96bzdwMlpG?=
 =?utf-8?B?RHRSdkh6WjNBa3JrYUFXbmROakZlaTZEV2c3bCtHM0xJOGdCMkx1K1B6dDlm?=
 =?utf-8?B?WnQzVVJWV1BXQTQzbXJxNHBadGhDOWpHZ0FzVlI2Nm5pM3RXM2hUR0wwdSsy?=
 =?utf-8?B?RzNaUmxFcG5SUzdrYnEwRGlmVTZ6UEVTS3d1U0wxQ0JhVWFPRkFacG5CVG10?=
 =?utf-8?B?bTN0WGZrcGFyNllYNk9OcVBBNUwzMHYwSFZBR0J4ZnhkYlRFTEpqRnFPNWpZ?=
 =?utf-8?B?TFlGcWdWcG80OHpSK0hRNlc4TGsybWJWN2xtTlh2YnBnVmYwVEZKQTYzOGd3?=
 =?utf-8?B?dWR3S1psRm5KUWhpcXk5eFFFSFp5dkZmYThaM29lRlcwRlQ3cENlQlRWQTlw?=
 =?utf-8?B?T0NGeHFpemxrc1VnUUZaSFhVRStGSkJqQ0lYUDlPb2NiVnVhRFBmanJxVUxj?=
 =?utf-8?B?WDVoU21iYnBvanB5RitDNzAyRytUMU8zWFBRcEVvNkVDY3FFTUtHOUJvRis3?=
 =?utf-8?B?OEhnVlFjM3FoZElwREVadXRkS01OaE5MRjltc2pTbHBZR3N6cTNMUkltYkJj?=
 =?utf-8?B?VjQveEhCbGFlM0hCR29CemgrcXl4ZWdDVEhhVytaeHBpZFpmTkppNFZYTmJT?=
 =?utf-8?B?VnZIVTdZTW85c1g5L0VwL1M2L1pFN0RFTFhMcGVQK2ZLSHZQb25kMDRSWUR6?=
 =?utf-8?B?bTV0RGV0RmJEdTR6M29UdnpKL1ZBZEZsVnhEWTA1ZUNwelVWODZkUlpEd1RS?=
 =?utf-8?B?OHN3d1ZZMEMrVE5iTlFlcS9zT3VHVVJ4Wnh3bDdLdGJxSE9JVTdNRzhLMm5u?=
 =?utf-8?B?YUE3K1NwWUxLTXZEM0tQczBXandYcUlPSE0rY09EelkvZm5MYmhNckdIRnUw?=
 =?utf-8?B?QldCSWpxdUlzTEFUNHpkZWxEZDRVNXliTlJtSU1HOHpDSkVFOHo2cDAzSjFJ?=
 =?utf-8?B?RjRXbENwTG90WW0yNHNrM0tVazhQVUZ6enBuZUpBWUhIcGJnYzFBYXQvZFFk?=
 =?utf-8?B?WUlWMGljZUgxOWFqRWl5Sit6NkFMYlp4ZDhKSGMvLzk4WDJJeXdtd2FRenMv?=
 =?utf-8?B?ak1CUXNZOUxVdWlCcVkzVFpRTFkyYU1vWmIwU05vNTFmR0RJSHZYZzRYZG4x?=
 =?utf-8?B?SE9keWRwVTNidnp3dUxqTnRwNitxZlFVZEFEYlVjZFg4ZHNWOTgrR2pxNWNv?=
 =?utf-8?B?NkUwME5KcjJYeVNzM3RzUXgzVlJ6Wlpva3pmZGdTZEJPbVlIcCtwZFhmUFRM?=
 =?utf-8?B?M3pYcWh5OHNid0xiUXFPcG81L0xDQVJoWVNCM0NOSEgyaDhJaERzdjdSRVJD?=
 =?utf-8?B?Z0ZLQUxDVklmSmI3c1hVUVJoWHkrRHRBeG1mYlFqVUZtdXJJL3ZrVDZXeHRl?=
 =?utf-8?B?dlNCOGhvK21LbzVsbWljOVpHNHNmd2Y0Z1lMZ2N0dFo5cmt1ZTBFTHlhOTNy?=
 =?utf-8?B?emJ4VWZwV2NQbzRqRk1zR0FLOUNPenc4dDVLSktCUVhFQmtKNnZSOWpPLzFj?=
 =?utf-8?B?eWJKYjQwMlhPUjR3UVV2VmI0YU9yZTVIYzRaTlJNYkZqTXhhVzRxZ1l4eExY?=
 =?utf-8?B?TDdyWTRLNzYxOFZzUk9oOGMrM1NZUVAxK3lHZVBwT1pYQ0lFbG8xRXNEZzJV?=
 =?utf-8?B?TFF1ZnV5NzhYVmNoYmpndE9MTUxxd01qMzlsMy9oTjh1WC9MbWE4Zzh4TUdM?=
 =?utf-8?B?ekx0TTVKMUVqeGFpZjNzRmtiUmJDSVJHUy8yZjBKQnNSOUh2WlllaE42ZGlB?=
 =?utf-8?Q?nfmhIKKGNU02S53qGAIG7Zkvh+kbOo5tNezORNs4/T1Qx?=
x-ms-exchange-antispam-messagedata-1: V/5yrjbbBy4f/szWSKBcnKIuLx4yAUyvrDY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94AEB4E9EBB72F4D807C4F2D9BEB1A03@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cI8kxV0/o4+S4QGmASbToVKMCx72THq7/PFk6l0t8K6MST/m//mRsRbDDvWCcadGxDft9YU2HUUmLzDdLPJaBFHf5y3MolZnW1jdUwjEF6v1Q3D/ueibvVgw4l+EOf+RqDHXSKBl7UVEfDZ8LMRBydn1ckyoS8D+TY0GFlIuX2G3UYWX5BygZnWWVCM7ojVm3ioFqLFMHsZZpCpJJM3w/PO7As3Bimvn5tXu2tasxPQJ1Si2kTFMWMdF0NCOWXXvOKxcins/XWQtwUl+OOwt8xPZ7WbGwXQF+1WtT6Mq8VjJqOp0t5Cv27hQsq0quzew42DiYuze1LXVDMxn63FezQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61da2437-417c-4507-60d7-08de9c1f3618
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 01:18:19.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 773VBFYccmZINHDruyKxtfeE6plpEXlB7iju59eG+TUfHtgTVVN/6B2gDc37zCy5BUri7DTK+zopD43XpZrMf+kSBvSb35GUT5NQ6kUqiq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Proofpoint-GUID: e4ovnAAigOTyonEJazO4KJjiaU2X3re2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAxMSBTYWx0ZWRfX5gCBssDkrpys
 FqM1XJyqPlOVLYoaI6bv2i3VLFXuApRcUQhtxT01LzWz6Au0XVDPEG95hmGA/l+sHSEbJ6rieAv
 IfpCv649bWj8U0gxRFCd6z06BZZVlwbG12IKMdH6g8sbNzQ1SFrQNx3tpCICOh1LY45H+1C7HzI
 I8OyY2SiMxDRyUT1TGn6tJZdxpiV0RR1YGcC/+96oRvvHudHJKeZs/6Fz7SkYxjukRloGLTqvzG
 X0HMijnSPiUtd6+eJ2TodcjCZgxOYKBnZn3nfJPFxDAWHWfpou1bAdVvPLPcO/s4f0Z1XdDWZ4q
 /8ePPFnbDjiZNC597Sa15/G6//a0s6vROleej1cH1hy7wiMGRzQpvD+qf46JVeQWl82QZr4fwBb
 shFThxipJ8EIUOMkEDIl46wS45qGA5oTvQ+r7t6N2WCbMtABG5Ydue8oInAbXLOngwHsFNJqX+y
 xCanaBce/9q/3pUHGYQ==
X-Proofpoint-ORIG-GUID: e4ovnAAigOTyonEJazO4KJjiaU2X3re2
X-Authority-Analysis: v=2.4 cv=R+4z39RX c=1 sm=1 tr=0 ts=69e18a60 cx=c_pps
 a=bwebfZLPylI8eKm9xdhY/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=20KFwNOVAAAA:8
 a=TRcOQPxCuI9uzd1TiPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDgsIDIwMjYsIGF0IDExOjQy4oCvQU0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gS1ZNIHdpbGwgdXNlIGFkdmFuY2VkIHZtZXhp
dCBpbmZvcm1hdGlvbiBmb3IgRVBUIHZpb2xhdGlvbnMgdG8NCj4gdmlydHVhbGl6ZSBNQkVDLiAg
UGFzcyBpdCB0byB0aGUgZ3Vlc3Qgc2luY2UgaXQgaXMgZWFzeSBhbmQgYWxsb3dzDQo+IHRlc3Rp
bmcgbmVzdGVkIG5lc3RlZC4NCg0KSXMgIm5lc3RlZCBuZXN0ZWQiIHRhbGtpbmcgYWJvdXQgdGVz
dGluZyBkb3VibGUtbmVzdGVkIHNjZW5hcmlvcz8gDQpPciBpcyBpdCBhIHR5cG8/IFBlcmhhcHMg
bWVhbmluZyB0byBzYXkgInRlc3RlZCB3aGVuIG5lc3RlZCI/DQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS92bXguaCAgICAgfCAgNCArKysrDQo+IGFyY2gveDg2L2t2bS9tbXUvcGFn
aW5nX3RtcGwuaCB8ICAyICstDQo+IGFyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMgICAgICB8IDEz
ICsrKysrKysrKy0tLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmgNCj4gaW5kZXggMmI0NDlhMzk0OGQzLi5mY2Q2
MjM3MTkzMzQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oDQo+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oDQo+IEBAIC01MjQsNiArNTI0LDcgQEAgZW51
bSB2bWNzX2ZpZWxkIHsNCj4gI2RlZmluZSBWTVhfRVBUXzFHQl9QQUdFX0JJVCAoMXVsbCA8PCAx
NykNCj4gI2RlZmluZSBWTVhfRVBUX0lOVkVQVF9CSVQgKDF1bGwgPDwgMjApDQo+ICNkZWZpbmUg
Vk1YX0VQVF9BRF9CSVQgICAgKDF1bGwgPDwgMjEpDQo+ICsjZGVmaW5lIFZNWF9FUFRfQURWQU5D
RURfVk1FWElUX0lORk9fQklUICgxdWxsIDw8IDIyKQ0KPiAjZGVmaW5lIFZNWF9FUFRfRVhURU5U
X0NPTlRFWFRfQklUICgxdWxsIDw8IDI1KQ0KPiAjZGVmaW5lIFZNWF9FUFRfRVhURU5UX0dMT0JB
TF9CSVQgKDF1bGwgPDwgMjYpDQo+IA0KPiBAQCAtNjA2LDYgKzYwNyw5IEBAIGVudW0gdm1fZW50
cnlfZmFpbHVyZV9jb2RlIHsNCj4gRVBUX1ZJT0xBVElPTl9QUk9UX1VTRVJfRVhFQykNCj4gI2Rl
ZmluZSBFUFRfVklPTEFUSU9OX0dWQV9JU19WQUxJRCBCSVQoNykNCj4gI2RlZmluZSBFUFRfVklP
TEFUSU9OX0dWQV9UUkFOU0xBVEVEIEJJVCg4KQ0KPiArI2RlZmluZSBFUFRfVklPTEFUSU9OX0dW
QV9VU0VSIEJJVCg5KQ0KPiArI2RlZmluZSBFUFRfVklPTEFUSU9OX0dWQV9XUklUQUJMRSBCSVQo
MTApDQo+ICsjZGVmaW5lIEVQVF9WSU9MQVRJT05fR1ZBX05YIEJJVCgxMSkNCj4gDQo+ICNkZWZp
bmUgRVBUX1ZJT0xBVElPTl9SV1hfVE9fUFJPVChfX2VwdGUpICgoKF9fZXB0ZSkgJiBWTVhfRVBU
X1JXWF9NQVNLKSA8PCAzKQ0KPiAjZGVmaW5lIEVQVF9WSU9MQVRJT05fVVNFUl9FWEVDX1RPX1BS
T1QoX19lcHRlKSAoKChfX2VwdGUpICYgVk1YX0VQVF9VU0VSX0VYRUNVVEFCTEVfTUFTSykgPj4g
NCkNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvcGFnaW5nX3RtcGwuaCBiL2FyY2gv
eDg2L2t2bS9tbXUvcGFnaW5nX3RtcGwuaA0KPiBpbmRleCBkZTg3NzBkMmZjZmMuLmY1ZjllNzQ1
ZjIxZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL21tdS9wYWdpbmdfdG1wbC5oDQo+ICsr
KyBiL2FyY2gveDg2L2t2bS9tbXUvcGFnaW5nX3RtcGwuaA0KPiBAQCAtNDk0LDcgKzQ5NCw3IEBA
IHN0YXRpYyBpbnQgRk5BTUUod2Fsa19hZGRyX2dlbmVyaWMpKHN0cnVjdCBndWVzdF93YWxrZXIg
KndhbGtlciwNCj4gKiBbMjowXSAtIERlcml2ZSBmcm9tIHRoZSBhY2Nlc3MgYml0cy4gVGhlIGV4
aXRfcXVhbGlmaWNhdGlvbiBtaWdodCBiZQ0KPiAqICAgICAgICAgb3V0IG9mIGRhdGUgaWYgaXQg
aXMgc2VydmluZyBhbiBFUFQgbWlzY29uZmlndXJhdGlvbi4NCj4gKiBbNTozXSAtIENhbGN1bGF0
ZWQgYnkgdGhlIHBhZ2Ugd2FsayBvZiB0aGUgZ3Vlc3QgRVBUIHBhZ2UgdGFibGVzDQo+IC0gKiBb
Nzo4XSAtIERlcml2ZWQgZnJvbSBbNzo4XSBvZiByZWFsIGV4aXRfcXVhbGlmaWNhdGlvbg0KPiAr
ICogWzc6MTFdIC0gRGVyaXZlZCBmcm9tIFs3OjExXSBvZiByZWFsIGV4aXRfcXVhbGlmaWNhdGlv
bg0KPiAqDQo+ICogVGhlIG90aGVyIGJpdHMgYXJlIHNldCB0byAwLg0KPiAqLw0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyBiL2FyY2gveDg2L2t2bS92bXgvbmVzdGVk
LmMNCj4gaW5kZXggY2RjMzVhMjcyOGQ5Li5lMGVmMmNiOGYyY2QgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gveDg2L2t2bS92bXgvbmVzdGVkLmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQu
Yw0KPiBAQCAtNDQzLDEwICs0NDMsMTQgQEAgc3RhdGljIHZvaWQgbmVzdGVkX2VwdF9pbmplY3Rf
cGFnZV9mYXVsdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQo+IHZtX2V4aXRfcmVhc29uID0gRVhJ
VF9SRUFTT05fRVBUX01JU0NPTkZJRzsNCj4gZXhpdF9xdWFsaWZpY2F0aW9uID0gMDsNCj4gfSBl
bHNlIHsNCj4gKyB1NjQgbWFzayA9IEVQVF9WSU9MQVRJT05fR1ZBX0lTX1ZBTElEIHwNCj4gKyBF
UFRfVklPTEFUSU9OX0dWQV9UUkFOU0xBVEVEOw0KPiArIGlmICh2bXgtPm5lc3RlZC5tc3JzLmVw
dF9jYXBzICYgVk1YX0VQVF9BRFZBTkNFRF9WTUVYSVRfSU5GT19CSVQpDQo+ICsgbWFzayB8PSBF
UFRfVklPTEFUSU9OX0dWQV9VU0VSIHwNCj4gKyAgICAgICBFUFRfVklPTEFUSU9OX0dWQV9XUklU
QUJMRSB8DQo+ICsgICAgICAgRVBUX1ZJT0xBVElPTl9HVkFfTlg7DQo+IGV4aXRfcXVhbGlmaWNh
dGlvbiA9IGZhdWx0LT5leGl0X3F1YWxpZmljYXRpb247DQo+IC0gZXhpdF9xdWFsaWZpY2F0aW9u
IHw9IHZteF9nZXRfZXhpdF9xdWFsKHZjcHUpICYNCj4gLSAgICAgIChFUFRfVklPTEFUSU9OX0dW
QV9JU19WQUxJRCB8DQo+IC0gICAgICAgRVBUX1ZJT0xBVElPTl9HVkFfVFJBTlNMQVRFRCk7DQo+
ICsgZXhpdF9xdWFsaWZpY2F0aW9uIHw9IHZteF9nZXRfZXhpdF9xdWFsKHZjcHUpICYgbWFzazsN
Cj4gdm1fZXhpdF9yZWFzb24gPSBFWElUX1JFQVNPTl9FUFRfVklPTEFUSU9OOw0KPiB9DQo+IA0K
PiBAQCAtNzIzOCw3ICs3MjQyLDggQEAgc3RhdGljIHZvaWQgbmVzdGVkX3ZteF9zZXR1cF9zZWNv
bmRhcnlfY3Rscyh1MzIgZXB0X2NhcHMsDQo+IFZNWF9FUFRfUEFHRV9XQUxLXzVfQklUIHwNCj4g
Vk1YX0VQVFBfV0JfQklUIHwNCj4gVk1YX0VQVF9JTlZFUFRfQklUIHwNCj4gLSBWTVhfRVBUX0VY
RUNVVEVfT05MWV9CSVQ7DQo+ICsgVk1YX0VQVF9FWEVDVVRFX09OTFlfQklUIHwNCj4gKyBWTVhf
RVBUX0FEVkFOQ0VEX1ZNRVhJVF9JTkZPX0JJVDsNCj4gDQo+IG1zcnMtPmVwdF9jYXBzICY9IGVw
dF9jYXBzOw0KPiBtc3JzLT5lcHRfY2FwcyB8PSBWTVhfRVBUX0VYVEVOVF9HTE9CQUxfQklUIHwN
Cj4gLS0gDQo+IDIuNTIuMA0KPiANCj4gDQoNCg==

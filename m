Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401C23B62C;
	Mon, 23 Mar 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277366; cv=fail; b=Iq8Ng/ieG/1bqNFdrSGqafQdTWBh2Bo8zYbuq64Vv2yUOPsG/9f9P1cfQzNymKnvKb5c6c1IUcpdKJK2aezf1FQaSrAxrrByRVT76qBAGw0HQ90i3/Z/2yRa+uXyLfDYlmuQKPAKOQtpgWer/bnLw/NbfRk+Fts+SCESg6FCwQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277366; c=relaxed/simple;
	bh=uLdU2nkosoFisDdQy8EaAgbVpdjlYdlIZ2V0H9p17EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzAvfHu+L+S3rDoSAfsSY4ckTZNV0e7no7Jkw4379uBF/+rUHIFqn18XZ8sUssuLVb20OpM28JWU65iNeQPnc0YJmwrj2olg0uulBSH4C1X1/vxfQEvjBacSGhAbv6pD1sJWVDURi1Ua1ZBcEwtwqyMm6zxnGDIyNUBAFC2WMuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=El+p2w8i; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=h7fBH7au; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="El+p2w8i";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="h7fBH7au"
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N9BAVp1889173;
	Mon, 23 Mar 2026 07:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=uLdU2nkosoFisDdQy8EaAgbVpdjlYdlIZ2V0H9p17
	EY=; b=El+p2w8i3u12RwkwpVhu/iPo4NEiSNXAHlH6nV1YY2WPeFTNf3sAQwRlx
	o29/rJC1f2Q4PFQVvVIgFkd4UYT4tF0GxXGHVFzB/R+GasetcTq2XDOkcEY2YcLm
	9LP1pWqgeD+4Za/pe6uAIDbm+GCV1Wwr5KlGQ9uBktW1rkh2d3JICqNetAKm86Xq
	zFBMfAaelFr/QGSZoUSiGxGR6SiHbvhHTJhy5xwyoFOtSv7bjkDplyQcB3KsgyBQ
	ob5w7Ba8DH2jXrgMPkTruHln3xlrhglOHjgVYvMUCQlRhCrvR2RYIrSDri083rpr
	B65fGEXO58MSXB9wiu30hlleDy+6Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023086.outbound.protection.outlook.com [40.93.201.86])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d1tnc3w5a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkzhYMoOeemNWU8oQCUEH0TJO9/JX1rNIdUfK+D+NaSpU6bhV3Xi85Fy+ku/fCPS5tOmU7SUmIZz+7uYlVBg2Xd2ybZc9CEfok6WKb7w2F08oqth/NM4QlqGPQQyESuzmR+qXk4fA0HGQ5tjAvNEgCtLiXWVV3xcYLPEAhdB8eOsOfLCfW3tN1JjPZ4PqAx980m1r15n4ONKmK2BhU2IRFajjvLi4IG8MsswYcZeQEyG1+5SbmcJQQToUHwjD9QsDvJxHh80AyV9z+MKYTM6EA1zaHqmMzj5W/PnWTwpfq5kZ8Gr/O2oZ2q7amAJqD/OhhVc/2aXqYVQ8m8Ds3+2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLdU2nkosoFisDdQy8EaAgbVpdjlYdlIZ2V0H9p17EY=;
 b=Hfc5R+TevIZNUXdEjUYCNtXN32e8Bvh/D9DaH9pBwd0SkhVJE8/uPJX63xLpHgODhwjgVcHPOGUogB+gwSa/nph6wlsGLrPGvmKG/9YUgDIp2R4IyupCxdyKBEnbZssaQ3ZpY1Jzb2A5/LDEx6J9X5oln/k9hEhkLc5eVshyHmcggxPYfUvoFPJ1zK1ZI00cEETorTlyt1bl0roJ5vg90fZ5o/GQJBVrAXIYdPIXszEONyXyYfoSGH/OG8Go5LdWc61dS5lbKXq7O2m8Am3S7/Owdpjpn9KMBKu0O1t5LQzrUwAIZfztrWnIUIQ0OSSdGOI8nAdsy23w9HnyVmO9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLdU2nkosoFisDdQy8EaAgbVpdjlYdlIZ2V0H9p17EY=;
 b=h7fBH7auBjlQdxBQYmzPdKARDStaoX8IdMsZp94xY8896mRavPax7TMK8Lf03USzljfFE43mgE55Ml1pZx7T04/ycgfU/EuuKxNaXkZDHDRFksNUl8ZF68LlbOJ48/WRQwQU1DBZwhq9ODvS1CN4eng/8isPAPdoGAwqTC8OEGM/kp+XdWBkrY7J/vYOzp8Im7NOZhLCpFvrifJgvLmMhbEPNQiiBQB5c3oyC8CjSJ0CxBRC86BVO7Q/IyYvToMxqvnleIEFqcR/13Fv7sUdXRtAYTshqgvpBJ+X0ztgAylvZKMj5d9spc4h+Y7Av8zcB3QxO677n87P5qWO7Q6nlg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA1PR02MB9112.namprd02.prod.outlook.com
 (2603:10b6:208:42c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 14:49:13 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 14:49:13 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Marcelo Tosatti
	<mtosatti@redhat.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Amit Shah
	<amit.shah@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 06/22] KVM: x86/mmu: merge make_spte_{non,}executable
Thread-Topic: [PATCH 06/22] KVM: x86/mmu: merge make_spte_{non,}executable
Thread-Index: AQHcuMcM6PfpczdN9U+hRQ+19xttx7W8NtOA
Date: Mon, 23 Mar 2026 14:49:13 +0000
Message-ID: <C3A22373-D747-49BB-8B59-A57A9ABD3CC3@nutanix.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-7-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-7-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA1PR02MB9112:EE_
x-ms-office365-filtering-correlation-id: f889a28b-64d9-4fb5-27d0-08de88eb59b7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 GqYREz2bfOpqUdC3XzXtpErXPXf8CS12S66oZf8HSSc7WrSlVqR/yxsmYd/DLJ+WBmVnZOdeIqzT26S2pqVNNBzwlpqwcgV9/aVszpLS33F6CVVteRkPm4UBdwBSMZniOw+wdjXh03KDLp9kS/TP4hO2lb81P9T49F0EI1B+Ctc4546Dz/wfN3eRUQCZR+kGapE1VfXrhxFCgEiWggiEYjuTZrlYBQVpLT8xfpm9q9NUrZVkjbSOszciGa9ed5CzYMqZRz3oLzLN9jnOy1Jqtnxz+ebjZyG2ixGK5Mbh56JpKNvbCjTzbUffH27prjAkT8kVpcK6Gtu6m/ivT+7vMOUGruMXKqF5JIVX++8b1GshXAiAxjhBjlih5pnZ0hdytl25NDBMC9FjW2pLk5g+AIjDItfuKTv9wBb/Ub1+RaZULpwhOyaC+k0Qv2hcOS0UV6GwmxuN7Nk3vc9zAsfht5QFk4fbmlDguyD7pA/GjlW1TVCjVvtlDFfo5UmlvdQwbgNgWhyAruiQhrAZ78guUqQOBQPLFmU0SSJeIjqcw+/fNRWTim+qSr1Pq3qokFSD3pPwTf9/6NxsRsuoopUWYDk7itcwfCaP8t1lZyFKu6BbBQBKKBCrxwqjg2UoVJUYHX4Tmdqm35qsuphqQ4KjUqNfzTc4g0HV7GW8213r88TvTzQgf/hzvz67ik9bZ+V2MGfFJFQzywwcGjNR3qL/n/xIPDeqCEkgAx42P9Z1Y5/UuzT6T5hekAsor/Zh9webcHAHfO8Khamp13GkfAcouQkbHCpUkSXgFBA7MBuvu9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clNKVUx2MUUxMGdLZ3d6RnhOK3o3QURzWnY0ZmNOOUl0TUdOdzJ2eWtBSU4y?=
 =?utf-8?B?L0lPaFZKc3VRN1duVlVQaU9hMVFzY3AwUVo2WlJMRDI1ZTkrRVluTGxIOVk3?=
 =?utf-8?B?NWQ2TmY3TWRUR1ZjYkd5YmxtcG5TbG9YdDVNWEwxMTNqNVVsSVBGaHFwVEtx?=
 =?utf-8?B?SlRtSkptUGRBN3ZwYlVVbWNWQlZvNklVVXFZbkU4RDZBaEdQU0VmTC9lMjJu?=
 =?utf-8?B?QzNtMjcyMzR2VGNwMG9NWGh2bi8zVEtUTnRLdDRwRldvUWpUdnhRTUsvZC81?=
 =?utf-8?B?Sk4rMkVsQUEzSmxWTUxBbjJMaWpDamlkeXRWV0taYkdBYVEvbzNHQXNWOGRo?=
 =?utf-8?B?bEtuNEFVOU5QV28yTUx1ZGJLQUh3a2lGam9uUUVYOGFtZ3B1Z3RUcjZUUmVC?=
 =?utf-8?B?b0EwSUhPWkhwNXF2WEIxQ29TYVZGeFZYSjZ5dEEvWVg5TGh3a3RkWHpvQlFr?=
 =?utf-8?B?T1lsaHUvRDk1LzAyZ3hZY2c0TTNMZVNkS3dJaUlacEpoTm1lM3JBYTgxQlhK?=
 =?utf-8?B?cllCVmZBWldsQk02RDVNNEllK1RYMVZlVU9PSEJiMVd2cVd2OEZDeUswZ3RG?=
 =?utf-8?B?RkxLenRUZk83M0lhajEzZnZ6VUxQRUNackgwVkZTRVhDSS9tWFhnK2h6eklQ?=
 =?utf-8?B?VGRmblJLaURic3pBaXdrQ2lUWjh2WTVHSm9jRUFDTzR1cHJSeDduMjltbkdQ?=
 =?utf-8?B?NFZwRjc2VzF1VnBMTXh6TWFEbXJkdlZsWHVlRE0vRWhoMG9ERWRqMG8zeXQr?=
 =?utf-8?B?Q0Q1SVdTcGdmWWJJTGVubXFVRTJSZE5ZckJBWDZuakNHblJzZjJYNnNEc1dS?=
 =?utf-8?B?cTZpMGlRUmJOb1IzaFlVSzQ1VUtjRUZOd3ozMmcyNXk1b3hZYXdheXp3ZU1M?=
 =?utf-8?B?bTU1OWdJa0UrbjliRkZDRTIxL3g4YnNQSDgyVVdlM3dkb3VEdXBjRFJ4L2s1?=
 =?utf-8?B?a0FWRW5ReWgwcmhlU2ZjeThwckVHdGxKam8xYnpyTlQ4akFSL25uTkdFVWFR?=
 =?utf-8?B?ZWtjOHV1Rk1jckk0ZWU4Z1lydzFUcUJoSFRnaTNMZTU5THF4SWpSbkMvRW92?=
 =?utf-8?B?a3BkNVhvNnJMWnhzVXFJakhzMHBESWc1Nm1YS1JWMHlZMTE1VXNrdURtVEdt?=
 =?utf-8?B?Ri9XU3EzZ0xpaXk5Ny8vNkxjT05LV2xONG9WVjFjQ3p2Y1prZ0toemJLVTNO?=
 =?utf-8?B?d3pKamZJN1VvR2NwdnV5YlVWUytTNExBSlQ1cE9lbEUxa0syRUI2aHgrVnQz?=
 =?utf-8?B?TVo2Q1NiZUloQmNncUxvamNveU1sY2VoSVY0ZjIzcUZVRURCYU16VE1CbDZD?=
 =?utf-8?B?bTE1M01qdmpLbXIwcmtxSmg0TTFiNDUvbkVjVUZHZFR5b3NBaFI1S1BFdjVK?=
 =?utf-8?B?YTlHYkFoMTFaVURKMEtBdGVPZGlxUzdUU1BGMVlPUHNlSTB4cXRvbFF3QWVa?=
 =?utf-8?B?ME5DdXBNMElIc0xSZFpvZVhOMWdoM0NhZzJnRkhEK2NGckF3cXdwMXp6Rmkz?=
 =?utf-8?B?Tk9EcjY4NVpzdUtqQlFxRmlHSGtPaitjYXZCQ2JmY0trYjlabktHQnJOOFR0?=
 =?utf-8?B?SndON3M3a2tOYTMyUlBLeGV1Z0dSVlJxN0xxQzl0cllJRWhYb2wzKytGQ0xZ?=
 =?utf-8?B?aGozWHRlQTFCWkkvYytVejdnQzlsRHUrTEFkWFBTbElGNSt4alN4N2lBUkVT?=
 =?utf-8?B?YTVVYktUejJHMVd2dXVJek9YclFUUm1lN1NpeEZzRlJrazFHandJZGhKOS9p?=
 =?utf-8?B?UzhIVGpIZ0dwN0E5cWd2QnArNk13ZkhkaUVBUHMyRE1IT1o1SjVkc01QS04x?=
 =?utf-8?B?WDBoTVBjcitDbEllOVBjbFBGUkxNdFcwTTUvWk1IbFBSLzFzZkFtRVQ3dTJO?=
 =?utf-8?B?bUZ3ekFIZEk5OVF0eUxqS0JJOGJ3MkN5WUhOb0R5ZVgzMG1YdnJ5WW9XRU12?=
 =?utf-8?B?RSs2VmxHYnBSc3ZQN1VQVUQ5R1pIZ0MrOUFWc1JKdklmQk9wWllGRElDTmov?=
 =?utf-8?B?Z1d4WHpPMk1Dd2gxK2l2dDlIM0RTTmhobjNPTzMydnpIcFN1QkkzVVdDejF3?=
 =?utf-8?B?elgyekdJdVJxd2c2YmgrSUdKTUtNNFFEMGZHK3RobzRRMXBwbWtYaytub2VZ?=
 =?utf-8?B?SU1zZVIvY3BwaXZ3UmhXclV0bktpMm5mOUU4NmVkZDVOMEVVT3IzRWg0TFFR?=
 =?utf-8?B?RFI1cTFBbGx6VTBMOVRhcjVHb0ZLSmNoNlU5ZHBZbzdwSmNYOWx4Yk5pUUIr?=
 =?utf-8?B?RzA2UVdEV0wrVmVISHdaNFVmUmpCdmI1NnhIbmMxbXJ5cDhSOFdMWDNpZnQ1?=
 =?utf-8?B?UHNhdjhVSlJoVXI2aitrSFNCazl4MGNoeHltb3k4Ly9vbzRFZjZ3bUtWbzZ5?=
 =?utf-8?Q?p+MaatKKMnbeRlHMv6AeBjnT519NfT0OZ9I6yXOyG+sn3?=
x-ms-exchange-antispam-messagedata-1: Vy6YL4DXeLV4wCGAKshteiotmE4a+9N5xPo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <436E02A65F9F6E4CBEF64FE996E28EA3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ULIAMs23urJ2t/FVHocU+wzyEDF+u1M/ICiyvdsYS1BclwGiD07OO1DNXtz0KmOPCvxC4lgLHUuOTupYF9Kiqpj8pJHuKqGgkxME6NypZUAsCml3FjRfRf+Zq3eMpVuBLSnAKi7MXiRhNjMOD4M2X23dihnF4pa+kSRgYWi6c8AU6+vYE4gUr6G/gi2XrZVWhv3XNpSqUVFsq4kxEdv0MINQs3UDIJwRcsuqdH5dcdbeXNBykK2hY/YwHviMV03wlfeKIUgTU7OAdn/KIgIry66zPiEuNdcKK0y6ydOhqTh2F/oTnt0noeHdr9lNjCsplQKk8mAl6qX1fmty3BEniw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f889a28b-64d9-4fb5-27d0-08de88eb59b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:49:13.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUOTc3DE3R4VpZvzb9v0u4GeiD1mjkuaJJ8dguJsh4NAuA+ckpXnOj2g/DNWw3225xe5y5zEpIIaLV1RnPWLL2Zd46Ery9n5/7ru7WPD9Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9112
X-Authority-Analysis: v=2.4 cv=eekwvrEH c=1 sm=1 tr=0 ts=69c152eb cx=c_pps
 a=abZUFfWgJRaQ0xfFFz1/lg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=20KFwNOVAAAA:8
 a=QIpOhTbFIyU867mQdmYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6n6egbKawnhy6SwkMeq7AmTyR4pTrg4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfXzgtxcd6Xb2X3
 S4Q/DuzwOnVQXBqz+AYR02kVtjQTS6ZCOAjv8KK9fCVK8pFpPONVozt/jq4mYTHdN6gnZj2ONAd
 hWMRkvJKIhlzBOIun1oj68yooXelIvxA/qtydCi/X0h31APv0Sj1JmmIXYLEO7NrXhZ5W2O/qH5
 XXuqVAMWk7EH5JkhD1J1kq7LxpR09YR6I3JphSBq8sfPTXyzAKi5xESQVHSmNXlUl/IIIUsZuSN
 buZcTtGUp1U7gpG7MqBk5ylaCkqxrdKRJQptmVFADLqxXqD6rdAFQofn4vbAWNBiz6poIWAGTyk
 dMs0iIwi7Y0n0G21czhVChIPi2uCHj9GjVgRfM+BoG4KtXu1Y4DmzcVHjYS0t12nNpwT/KKzpCd
 d50IXet1TRY6/dzl6Pl+B6fuvFi43d+pyOP+lmhTWBbF3B+0eQPsq+NSh/UU4FdpMCgmB0tG8QF
 8CNJ7yZs7m0sQ5z4+Sw==
X-Proofpoint-ORIG-GUID: 6n6egbKawnhy6SwkMeq7AmTyR4pTrg4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDIwLCAyMDI2LCBhdCA4OjA54oCvUE0sIFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gQXMgdGhlIGxvZ2ljIHdpbGwgYmVjb21lIG1v
cmUgY29tcGxpY2F0ZWQgd2l0aCB0aGUgaW50cm9kdWN0aW9uDQo+IG9mIE1CRUMsIGF0IGxlYXN0
IHdyaXRlIGl0IG9ubHkgb25jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkg
PHBib256aW5pQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiBhcmNoL3g4Ni9rdm0vbW11L3NwdGUuYyB8
IDIxICsrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21t
dS9zcHRlLmMgYi9hcmNoL3g4Ni9rdm0vbW11L3NwdGUuYw0KPiBpbmRleCBkZjMxMDM5YjVkNjMu
LmUyYWNkOWVkOWRiYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL21tdS9zcHRlLmMNCj4g
KysrIGIvYXJjaC94ODYva3ZtL21tdS9zcHRlLmMNCj4gQEAgLTMxNywxNCArMzE3LDE1IEBAIHN0
YXRpYyB1NjQgbW9kaWZ5X3NwdGVfcHJvdGVjdGlvbnModTY0IHNwdGUsIHU2NCBzZXQsIHU2NCBj
bGVhcikNCj4gcmV0dXJuIHNwdGU7DQo+IH0NCj4gDQo+IC1zdGF0aWMgdTY0IG1ha2Vfc3B0ZV9l
eGVjdXRhYmxlKHU2NCBzcHRlKQ0KPiArc3RhdGljIHU2NCBtYWtlX3NwdGVfZXhlY3V0YWJsZSh1
NjQgc3B0ZSwgdTggYWNjZXNzKQ0KPiB7DQo+IC0gcmV0dXJuIG1vZGlmeV9zcHRlX3Byb3RlY3Rp
b25zKHNwdGUsIHNoYWRvd194X21hc2ssIHNoYWRvd19ueF9tYXNrKTsNCj4gLX0NCj4gLQ0KPiAt
c3RhdGljIHU2NCBtYWtlX3NwdGVfbm9uZXhlY3V0YWJsZSh1NjQgc3B0ZSkNCj4gLXsNCj4gLSBy
ZXR1cm4gbW9kaWZ5X3NwdGVfcHJvdGVjdGlvbnMoc3B0ZSwgc2hhZG93X254X21hc2ssIHNoYWRv
d194X21hc2spOw0KPiArIHU2NCBzZXQsIGNsZWFyOw0KPiArIGlmIChhY2Nlc3MgJiBBQ0NfRVhF
Q19NQVNLKQ0KDQpjaGVja3BhdGNoLnBsIGNvbXBsYWludDoNCldBUk5JTkc6IE1pc3NpbmcgYSBi
bGFuayBsaW5lIGFmdGVyIGRlY2xhcmF0aW9ucw0KIzMzOiBGSUxFOiBhcmNoL3g4Ni9rdm0vbW11
L3NwdGUuYzozMjM6DQorICAgICAgIHU2NCBzZXQsIGNsZWFyOw0KKyAgICAgICBpZiAoYWNjZXNz
ICYgQUNDX0VYRUNfTUFTSykNCg0KPiArIHNldCA9IHNoYWRvd194X21hc2s7DQo+ICsgZWxzZQ0K
PiArIHNldCA9IHNoYWRvd19ueF9tYXNrOw0KPiArIGNsZWFyID0gc2V0IF4gKHNoYWRvd19ueF9t
YXNrIHwgc2hhZG93X3hfbWFzayk7DQo+ICsgcmV0dXJuIG1vZGlmeV9zcHRlX3Byb3RlY3Rpb25z
KHNwdGUsIHNldCwgY2xlYXIpOw0KPiB9DQo+IA0KPiAvKg0KPiBAQCAtMzU2LDggKzM1Nyw4IEBA
IHU2NCBtYWtlX3NtYWxsX3NwdGUoc3RydWN0IGt2bSAqa3ZtLCB1NjQgaHVnZV9zcHRlLA0KPiAq
IHRoZSBwYWdlIGV4ZWN1dGFibGUgYXMgdGhlIE5YIGh1Z2VwYWdlIG1pdGlnYXRpb24gbm8gbG9u
Z2VyDQo+ICogYXBwbGllcy4NCj4gKi8NCj4gLSBpZiAoKHJvbGUuYWNjZXNzICYgQUNDX0VYRUNf
TUFTSykgJiYgaXNfbnhfaHVnZV9wYWdlX2VuYWJsZWQoa3ZtKSkNCj4gLSBjaGlsZF9zcHRlID0g
bWFrZV9zcHRlX2V4ZWN1dGFibGUoY2hpbGRfc3B0ZSk7DQo+ICsgaWYgKGlzX254X2h1Z2VfcGFn
ZV9lbmFibGVkKGt2bSkpDQo+ICsgY2hpbGRfc3B0ZSA9IG1ha2Vfc3B0ZV9leGVjdXRhYmxlKGNo
aWxkX3NwdGUsIHJvbGUuYWNjZXNzKTsNCj4gfQ0KPiANCj4gcmV0dXJuIGNoaWxkX3NwdGU7DQo+
IEBAIC0zNzksNyArMzgwLDcgQEAgdTY0IG1ha2VfaHVnZV9zcHRlKHN0cnVjdCBrdm0gKmt2bSwg
dTY0IHNtYWxsX3NwdGUsIGludCBsZXZlbCkNCj4gaHVnZV9zcHRlICY9IEtWTV9IUEFHRV9NQVNL
KGxldmVsKSB8IH5QQUdFX01BU0s7DQo+IA0KPiBpZiAoaXNfbnhfaHVnZV9wYWdlX2VuYWJsZWQo
a3ZtKSkNCj4gLSBodWdlX3NwdGUgPSBtYWtlX3NwdGVfbm9uZXhlY3V0YWJsZShodWdlX3NwdGUp
Ow0KPiArIGh1Z2Vfc3B0ZSA9IG1ha2Vfc3B0ZV9leGVjdXRhYmxlKGh1Z2Vfc3B0ZSwgMCk7DQo+
IA0KPiByZXR1cm4gaHVnZV9zcHRlOw0KPiB9DQo+IC0tIA0KPiAyLjUyLjANCj4gDQoNCg==

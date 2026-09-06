Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38237FF75;
	Sun,  6 Sep 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718430; cv=fail; b=Cbo2u7MLkSJcEWPQsLAkH3z+d/mVupXVc+BPvjjxGeHSoxlKtI2L9H4zo00YRVlbYpWqTkzfD1gqJZEhETtgf2KmUFH7P/t3YjUV381EnMfYh9shIicwJAHpcDqXGCfYXi1RKY4zYddu5lyQYBvJw4i5Lxe9Nc6DcYFHDEmXl7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718430; c=relaxed/simple;
	bh=RtaQGvoYG/F6+ZkvII6bgZ3srI/ADiyXShnNFKr94nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pn/7QnHw8NvbW8Moofkz8cawm974brogUKhwCaFbrG4FTyWqVayjpgyG6x3lTtj6Hk6ZpTiVDf+hfg6Kmsk1u+5Va/XRMSmqw165jHBGJEDuUewFlFpAUxbnZFWvn3zZRp0YlsqH0fY7/oT/IfERJRkkpiPhdlGhAfk9o8uf5fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVPJlPrm; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVPJlPrm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6jVzXlJUuKBS+Yfp19A5WUNUIhf0csKnKNeX3cYnic06U57hKJncf3huPKOW5P3bX655jMbyiRyQHZv4O0ehffbI2hicdLEY5SB33jzCCTfa3FpFSdY8Zzd49U9vHTzKB2/YmX7CgyikCQbwOFKeYa6sh0vqVkpJ0qTGefT++goYNL72DJnlqwP2WhvREudbxG2UpVc9ca41pcOdGxpiCHngfJjdHzYUG97z0T+C2BZDlU1TwEhbMuOYXSAzfiYtoQJlW855W/GSFROocgn7WfQwfbxdUfol/LRpgqKEwH3RcPsuTDkyhXpVzQo9Ngsmo8USEZEf5NcZxVNqVbVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtaQGvoYG/F6+ZkvII6bgZ3srI/ADiyXShnNFKr94nc=;
 b=eSiRCXMmTAkyYE26geAc1DF/fA+lXaCb1pr7iWLGpbWsZFQTnJFphfLOk88YZ1a13JGm2qAaowVxD6ECpc4Cj6AvFK1bZE4or5hFECutqWmUoZkgLkWxL/RoKrTPe58fj2CDuRV4dGnH4sp46fOCp6DISUxdWjfcwgRuu2oqgX1rdoI1HufE9ZQHZkW5infzlWUBfT5/+ssiESoFRbF9Po6kgmoRPR09hECk3U6oPyS4WG01oB8pg+dygpwQACbS+dNCxqMn89rPDo1T9WMSID0+ReZamJEhtY54bgBkV/9Wth3I3xYiBpj+SlUXImg8dMshSA0EdIaMlBnu7sAiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtaQGvoYG/F6+ZkvII6bgZ3srI/ADiyXShnNFKr94nc=;
 b=RVPJlPrmRdrivfUe37O5mhO54kvjW098CqB5gOujGxWUVuquq+bcb0w6VPZNtYFyg4lay1C6xN1Vq3wrxRIBEoU1sf7Vo6NpT2O0y/QZQMe3O/9PTYxctl+TbCeWoA3MEPcoBbs+wswAQgUxPArNrDNRT6g6E70bX5L5sp7FxZE=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 18:13:47 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 18:13:47 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] KVM: selftests: Skip xAPIC IPI migration test when
 forced but unsupported
Thread-Topic: [PATCH 7/7] KVM: selftests: Skip xAPIC IPI migration test when
 forced but unsupported
Thread-Index: AQHdOzl+OJg2iA2slUS4WxgpcUqNGrbB4HaA
Date: Sun, 6 Sep 2026 18:13:47 +0000
Message-ID: <cd4e0e3e149b41887d0350845016743f5f24065c.camel@amd.com>
References: <20260903001625.2792367-1-seanjc@google.com>
	 <20260903001625.2792367-8-seanjc@google.com>
In-Reply-To: <20260903001625.2792367-8-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|SA5PPFDC35F96D4:EE_
x-ms-office365-filtering-correlation-id: b7e3f36f-30e7-47fc-a850-08df0c42982d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 0P/e8BB4Rd4gghI/7f7JSoRjJDpFSuamyfrBJRkUq52owr9DFSq8tU4U9DpeujWY1d3SE35s7Dyhch529DbrBGXml+qPMm0J1Xu1KBVqiCKqnchXHORF4EUaF7fb0mtlo9ZJYbNre93I03QnpdPnFQBRU3ke4ZBVJ0EIiRyMWiv6N7hSc3RslmMjbuTl8yb6XrnEQGV4SW6QHFP6LyPoYM+9IsQ2c8m24m0ZbFCnGdWaQlKl/7XSjrAONmeXqsnaJEMuVjPBVW/wV7QnMJTu+ITdLmIbtt2IyoDpBtmhMun7+cSRLH/fNrNuAikgatDVNhOx/qUT0GS4VWe6tZvnRRzVU3RwzCOT2l8GCU0CR1eusv2e/wFcFsUTAcY2zyS+jh7+LzXXUl3t+0DCuuj3IarBxbenWjoGpf2oRf73C5MKtp6gKihJDGHocQj6QhPt4lUa5a3tOffOv9kfewoC9sSoC95duf9kf4xvQYZmCu2/heOCBLI4jjj1G2aohDwJXSSW7spmZSVztNrQSvL+KWXsQ96ehSrhDGuo7d/FsocIkQ+LXPNeRJDlXyEiRpSxPJbtd07UwD4tYXNhcC9JY+HWic6EkalqcEaP3uqPEFYcspooZCYCXIK3/fahKxT/HmOcuzUXcZNs5z8VapYQghqsLryCO6GeNFMqCb5e0js9e7MP0SXN4JFOm6cOTVILAyPKqGAvNaqSpag+TwyWVGWoT0oXFid3E7k9WF7RUw4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2tOY2FuYlROb0N1N1Y4TDdFWUkwejFhTzVrQmgyN3A3eERKTml5aU5GNDhI?=
 =?utf-8?B?WmVUODZFMHIwVWpQYVhnVlVlNDdQZVRacHBhQlk3bjJjK08ycFZHa0NVS25Q?=
 =?utf-8?B?cnhmMzQ1WUhMZGp1a0dDUTlwT01lYU0wb0EvMzR3MGpoSE0rbjlkd1NrbkRq?=
 =?utf-8?B?cVpyUjB0ejcyZXJ5amlDQjBFL2w0TkZYTWNreVc2bWpmZVlhWDRtbWVxR3BT?=
 =?utf-8?B?ejNnMnVvZWxyTndsYkxKWXczSlJob2hubWRpWGVOZmxaSGU0ZmxmMHRWaGN0?=
 =?utf-8?B?dlQyTHMxd1lsanNxdDN0V2lIbm0zTU83SVZJVFRVTlBYS2F4WWlpeU45NkRh?=
 =?utf-8?B?R3dmQ3dXWXZ2a0hucFhFM3A2Z1NuWHZLK1FiUVVNTUhlMkJaYjhRTUdjVEow?=
 =?utf-8?B?dWdLVUdVbjZXK1hoR3ZRNUcxcnhWR3hSeEZpWDhiVmlwZzY2VTFFWGY2bWd3?=
 =?utf-8?B?WW5KY3hzZ3lIWE1hUG13Uk5DZUFMV1JOSjlYek9mVys3elFqS3g3U2JmSHpW?=
 =?utf-8?B?TURvYzByT0ZrQjNjSG5Bd0g4cEo4NWtGVGo0cHFmN0xxRzdjYzJ3bDgvSmVZ?=
 =?utf-8?B?WWYvTHJVa1JDMTZPcUZlL1YzYVliS1dmeHVnMFFrUFk5WTNtUU5qNHBBN1Vj?=
 =?utf-8?B?b2xEWlpvQUpaTTE3TnFyVGU4dHJhb3IwSDNQWGFsRXI4dVZMR1dhZ1NXQ0dn?=
 =?utf-8?B?cVN2Rm5ObUJjNTJnN2krL2hWSVV0WEVNVWd0YmxtdFhwVkwzcHppKzNSZitB?=
 =?utf-8?B?bVhIV3Bmc3ludGpUT25WdnZxQUt0cGpRaGN3VXpxam52MVV1N0UrWi9RcXp3?=
 =?utf-8?B?RFZTZUE3amxNTzNBMitVVVdKM0lYQzdWWExHcmNGK1hJSjdBcW8wRm9nM0d2?=
 =?utf-8?B?NE1kdE1YM2kxZzloc28yTnI5QmRsSHN1TXZKM1o1VENoZ0J6WG1wZG9EYms0?=
 =?utf-8?B?QXM2SnRDSExmb3Zwb0ZFemdheHJPdWsvdGdlS25QNHN4cVRvVjZ3YnE2NDdD?=
 =?utf-8?B?dHVpeE94QzZGb0hGMFNDTE9QdUVGRXpqYm5WRXJuOVo2bTFtRWowVjU1VzFw?=
 =?utf-8?B?bGUzVXhKV1FMNURJbXR6T3o0MWlHUGN0QzdVWE5FVHhOdWhYcVNPdEtoRVM1?=
 =?utf-8?B?VzhsV3dTdzRUTkgvYmRHYXJleWYvb2FmajNTYnB5WG5icUdyM0NSUHpZNVp6?=
 =?utf-8?B?Vkt0Mk0xbXcvek5NUkRyYm9PNEJUWVRrNER5ckF3eGRmWlRLYWVEZUN0dE5J?=
 =?utf-8?B?WG9vbURZV0NSdm02YXByOWtaYllKcjlPWk1OUC9qMGZYcWN6dlJwQ1llQ3VE?=
 =?utf-8?B?ZlQ4WnlwOHZkdzhLd010eUgyMjRDMHZ1cmNBeCsrbWZuVGN4OHJzaEUzdVV0?=
 =?utf-8?B?bHUwUmlDWjdPQyt6QzFINnBzSGZYTWZrZE5FbTdURDJvMVg0cE9GUUhXcEtW?=
 =?utf-8?B?Qm1Db0UxRUMyVWtmRERxK2VPZ2lwd0x0RnQ5Mmtaa1grcHcvWUgzdWpWM0wr?=
 =?utf-8?B?UkgyMnFpRWlrcUZJS2hjN2pqNVF3WUdVNmg2T0pCRlV0K3pGUm91RjB5ZW9y?=
 =?utf-8?B?U2Z2eEtZSjdFazB5V3JzTXgvTTdUN3JMaU5UYmVRSzE5S0Q5Z01wbS9DWHBS?=
 =?utf-8?B?eHlFR09zczlmQkp1K0h4bjRCd2R1YW5GQnN0RVJkS1VUVXVkR1ByM1NiZHR4?=
 =?utf-8?B?WkNGTDMrUUhPQm1NWUlQNThKNitxaVl1aHRVbUxBQnF2ZFJCYU1iZHkyQVZO?=
 =?utf-8?B?T1g3cklrcHZpQUlJdkQwcU9qRXNQR25LVWJQOW5qNys4eUk5Y0o5cEV4aVZ5?=
 =?utf-8?B?YUFveFRUS1R5V1dUaTNwanQ3eU9wMDlJVklwZmQ0NzFBVDFqa0dJbC9DcjZu?=
 =?utf-8?B?SGxHazlKNkJWR0xTSEsyQW9BZmdIemxRODR5NXRPYlh4VnRtQTkxSDVqbDJW?=
 =?utf-8?B?SkxkdHZBSnlaTHAyUWdrYzQvS2d6RFJTbkdqazJQeGcvZ284bEo1SmJYRmt1?=
 =?utf-8?B?azVGbUlWdGF6Tlp2cjNnYUc5bkFUK1ZvdktXYXZwNnhaVkI5bG4yaDdXdHAv?=
 =?utf-8?B?YWM5K2pXU1hKcHVaQXp0U2dsSlQ5VXJxRXM4MktEa1FGRFNWU1BZUFRKWXRC?=
 =?utf-8?B?NjdSb01ka0xDY2tubTVTZnlhb1Q0dnYwSHpjNW1JeGVWdldJOEl0MWdFWGhQ?=
 =?utf-8?B?RkwrYUxXZ3FkV3hBeEZkaEd5eEFsQk45R2xBeEZIeEhJQjJ4TytWL2Y0MkFZ?=
 =?utf-8?B?TXJ0ZlVpdksyckpwV3JVUDVpYlRSWlBhMDc1eWg5S29hd096QVRhYzdMMDUw?=
 =?utf-8?B?WkpsZ3cyemZ4YmJMRk1Eam83WkU3aTZRb3lyYUd2VnBrb2hXdlk4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA3F2728995E1248A1AB0064D5FAEB14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e3f36f-30e7-47fc-a850-08df0c42982d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 18:13:47.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL2YC5XblTi61dbEkLuQOoxmA9Z45UdIplUrzIxJFj+6UeJvjFN8kby7DPWaCvrCgLhRyeeCPc6E6YJU0gdTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE3OjE2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBTa2lwIHRoZSB4QVBJQyBJUEkgbWlncmF0aW9uIHRlc3QgaW5zdGVhZCBvZiBmYWls
aW5nIG91dHJpZ2h0IGlmIG1pZ3JhdGlvbg0KPiBpcyBmb3JjZWQgYnkgdGhlIHVzZXIsIGJ1dCBp
cyB1bnN1cHBvcnRlZCBkdWUgdG8gbGFjayBvZiBOVU1BIHN1cHBvcnQuDQo+IEZhaWxpbmcgdGhl
IHRlc3QgaXMgYXJndWFibHkgImZpbmUiIGZvciBvcHQtaW4gYmVoYXZpb3IsIGJ1dCBpbiBwcmFj
dGljZQ0KPiBkb2Vzbid0IGFsbG93IHJ1bm5pbmcgdGhlIHRlc3QgaW4gZm9yY2VkLW1pZ3JhdGlv
biBtb2RlIGluIGFueSBraW5kIG9mDQo+IGF1dG9tYXRlZCB0ZXN0IGVudmlyb25tZW50Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+
DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Ni94YXBpY19pcGlfdGVz
dC5jIHwgNSArKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0v
eDg2L3hhcGljX2lwaV90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hh
cGljX2lwaV90ZXN0LmMNCj4gaW5kZXggYzViNTA2ZWI1ZTdmLi4yMzYyYmYyNzJlODAgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODYveGFwaWNfaXBpX3Rlc3Qu
Yw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2L3hhcGljX2lwaV90ZXN0
LmMNCj4gQEAgLTQ2OSw4ICs0NjksOSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQ0KPiAgCWlmIChrdm1fZ2V0X251bWFfbWVtb3J5X25vZGVzKCZub2RlbWFzaykgPiAxKQ0KPiAg
CQl0ZXN0X3hhcGljX2lwaShydW5fc2VjcywgZGVsYXlfdXNlY3MsIHRydWUpOw0KPiAgCWVsc2UN
Cj4gLQkJVEVTVF9BU1NFUlQoIWZvcmNlX21pZ3JhdGUsDQo+IC0JCQkgICAgIkRpZCBub3QgZmlu
ZCBhdCBsZWFzdCAyIG51bWEgbm9kZXMuIENhbid0IGRvIG1pZ3JhdGlvbiIpOw0KPiArCQlfX1RF
U1RfUkVRVUlSRSghZm9yY2VfbWlncmF0ZSwNCj4gKwkJCSAgICAgICAiTmVlZCBhdCBsZWFzdCAy
IE5VTUEgbm9kZXMgdG8gZG8gbWlncmF0aW9uIChub2RlbWFzayA9IDB4JWx4KSIsDQo+ICsJCQkg
ICAgICAgbm9kZW1hc2spOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQoNCg0KUmV2aWV3ZWQt
Ynk6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNvbT4NCg0KVGhhbmtzLA0KU2hpdmFuaw0K
DQo=

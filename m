Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012050.outbound.protection.outlook.com [52.103.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AD3C73E5;
	Fri, 27 Mar 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596783; cv=fail; b=Tpb5EL4jvjvIy/Hj+5Bya5tUhCCSxBdps7oVMYC3m+AF4gF0ey53g0iczvVIaiiEsD2n/2zw+1W7v7omapKnkrPUus23Cb8o7QUte3bhYrWGqwH7pbiMrZWQUnGoOeUqOdx9XhuH9t5cH//pZ3ftux0h7cn9chRvWIBxRjc1mjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596783; c=relaxed/simple;
	bh=gQC1DhjIf7Yr0jBQ+mYLKk+JF5bM+yLIRy8BQwgpDsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIcF7l2mV4vhOOd6N52FKgux/niroe81F4qOEnjaWbi6SDyajGVJ3dA6vGSlrN/qq+nObMGMjenv2FgnJ0m1C03Bmd9rdqoVtEpyw/Dxs2zBbzHZak3FYLZf1+vudR1gjKNwOnY625n0bFaFtUBF+A1A5+gDv9WPjnPaP6EPd1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ZidjQOc2; arc=fail smtp.client-ip=52.103.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZidjQOc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STYj6wiPuT4cuZ5TQyvXCgBN5B2fanD32AI+5V2ml+oDf1vr7E5nPVJRR1p2TUA23+4Z2swAYUIDxgxC97HEf79ymtRX0AUDu5WOuXoawlD12C2kNlsxVsCC3c5JH9NlOzWVSTaqYVnfeq+XIXfMdLddCSnXYWDyXzJcVEjuudj33VcSHt/DYvJ9EF9+Mr4X3QmBS/8Mbk0rFsnYS/gJSY3XP83hj9/EIpL4yiXiZA58iWRONLGkCdJFTyjzmpHdoD2IUFULG2vc7aIJlfIxJdZlM6jG8z3BwxzM9cfFP9TGVhmnf4BLYc/5yyMEA8Aa20exanN+7xzlCxsR6kS1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkTDRM/XwSnoRYsUvtRCj6GlRBBdTM6LsaKGQGv11+E=;
 b=s768NqIeYshL34d1A+41XG7LrcaAkLl8mjZ5e/ndgx/QHkGCtGyW1hi8lKFDuE/5pwYkdrbAHark5x6jy31OEGdaHq8ZWmeTIRifeM/52ZSwx3LjEaaz3Mtwo53EuFhDEvhJ7c0wUW5AdqdbhmUURTALPtQyWyIpgo6ax21MlcNpL5tPhDXjfcq9jB9Mja9rQTxWeBCTlfUYm2K5NaMwBCWLVkz2AL22uYwIyGhIOfr1xKLpIFwZrSZorSfzFkJUbibL2xz5sK5Kzepk8+F010wbkbopjkJwQVoCF4fjAQcqD4o3hDIQHsZYlb1s7kVRr00Tcm2AtW2mm0p6++1H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkTDRM/XwSnoRYsUvtRCj6GlRBBdTM6LsaKGQGv11+E=;
 b=ZidjQOc2RqJ9K1wtf/uZ44l3Ux+qw8C3aGLTGPNdaAoFHBopyRil3FXVbM+Duc+zT30QTcSMzYBGV3hRb0cCnJVS79JukqrGtdjfIiN7xoYQeSPZPxC6QKfdklWUGAind7dDCOa2fGKp5Fvnq+wCC094zfbo+gr/FceeDKFY3saX/USlNoLPJRPK49jwNG0akLw8tPjhPrd8Xfbj1iFQUCau+KK10WPKUAKmpG3V006f4kE5bQEZU76T6xx8061wCwMFSRSKR5LjcJ8ML0k6wNNW+HWi38iCjqho/GP13J9LgGpsrWKIfCXzKdXyLZ1XSv2XIldjzF1mBbTXQlVCZQ==
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com (2603:1096:d10:46::5)
 by KUZPR04MB8894.apcprd04.prod.outlook.com (2603:1096:d10:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 07:32:50 +0000
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d]) by KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d%4]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 07:32:50 +0000
Message-ID:
 <KUZPR04MB89253B3C9F8B22D713705C68F357A@KUZPR04MB8925.apcprd04.prod.outlook.com>
Date: Fri, 27 Mar 2026 15:32:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix double-free of sdata in
 kvm_pmu_clear_snapshot_area()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
References: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To KUZPR04MB8925.apcprd04.prod.outlook.com
 (2603:1096:d10:46::5)
X-Microsoft-Original-Message-ID:
 <b3d5fd11-440f-4472-a0a1-bd3a16dd7486@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB8925:EE_|KUZPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab756d6-d2ec-46b8-5fd5-08de8bd30c4f
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZmcv7cN2CQdJd4XVKwegu/4uZqsT57xel++9gN9tdu1qSXrli7jAYAsF7tpRRG1iDVo6Y/f8CkvvIgaJLbFdmhauEwE7WSCXZen3ZBAlWGG8AaAnPCK85vcnRA+GNA9IUxDj8B0uYfNa4TlJUWxmwKYbq0jd0C0+eqKss9Nb5k+M7iUf94PD8ONnX2f+Uw7T0SQeLM2qhrWvqyFONdY4skno10pNkdgSZyxu1gwvHlxsy7TxCreXiQLPIt1qtUm8YGE8jlofVShhQ89j0cMShzQ5iaD4lCNdjLpXHDVbjDbZzNwV7yV2tD5QrcPq13fUjrVz//G5bsmhZQszogmRE6N5mYqWC2/YxdxZXgnU/MyTO4XkYemySoRkkf4c4cY+wbx5qSv3sAid92tDWYvK6UzUVTdhteJJxH/Q26eRAHyuUD9lhHeE80qlr+4bLGxRf6YIpKsS4kAcDwd/lCIYYD+qT9RYcgq5RXsvIc/hPOrHFIJQUzEomF6N13ykkdKXy5UI2C6yI9PmdtTG4GeufX/fuEBF3tJrX+mu9xrH0rZ+XBC5OY/xzuVQrb3xAUwPNcvpYpaPxiesToiriq2+OvDg14PorJPuQpGrJ6Hu7CAY0wGO7xyyMk0A5cFIclFidiXJIE+8PEeI0HH1qrXo92POx3rl8iG0KCrgGN7HpCAamNDhZSdsMPTYniDptRBn37wSphUwTsaDYNYFUYqqQ7hXZhrahKbgGLTg6lbjaJXqiR6XZmYijou4y7Lr3u8JfcaLRxmvcU4np3yQKLjvnuEMKUu9WVzJ7LbkH+03ZMa1/Xh9uIBe1dQ
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|51005399006|12121999013|7042599007|23021999003|19110799012|461199028|15080799012|8060799015|41001999006|19061999003|40105399003|440099028|3412199025|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnlRNVZXalRwN3ZBbUR3QVRZcXFDOXpKWEEwakRFVGpCd250cFl6VlNUZ3Fu?=
 =?utf-8?B?NjBubWU3M1FwWVFNcXI2V2dFcXhYYU9KTi9vNStWMlJlMjNFQXV3UTdYay9j?=
 =?utf-8?B?ekFJam5Cbk12eEFuMXNjbXJQZFlhZUFtaVdoNW9TUmJpdnhjZXdaWDEwNnpC?=
 =?utf-8?B?QjZYUXpXZHY0aWZOY2NWSGVFcDRwSnFWanUwWHV0SVFiSzdBbEtScXRJbmV3?=
 =?utf-8?B?ck5wL3FmMzh5VmlxTUNpaWY3UDdxb1R6L3pSWnViek1mY3lCSi9hYnpqNVBs?=
 =?utf-8?B?Yjl2akxMV3NBY1h2VDZnRXYrYVg3QW5ZUi9XY0pJRkFzTGhleHpERUFDejdl?=
 =?utf-8?B?MWFuZ3FoR2lDL05pbXltNm11OGZwWUp5Z1BLNzhxcUp4T2wrNGZxdmtFaTBB?=
 =?utf-8?B?MVVycHpXc29SZ2lva1J1NEU0a1hvU2U4dGZVRHV0enFXdGFidEhJUjhHQjJr?=
 =?utf-8?B?SXdaeUFGRDZkQXkzc1paRHkxSHhVZS94WVJDT09hOTA4NkpURmk3aDEvazBF?=
 =?utf-8?B?UDNITkptUkRiU1FmTmNpdVpzSXI1SmtPdVNGSlE2cUdXbnRTT3JHaEZ4SWw0?=
 =?utf-8?B?bnVxd0wwdDUvb0p6UGwrZ0s5dE9TNFY2N2pXanB5RDh6ZWhKdEJtb05FMGR0?=
 =?utf-8?B?a3JYNjBJckZqa3VYbkVTc0F6RlVwYkE2enR4K056RUFRZEVLdXBUMzhRK2pl?=
 =?utf-8?B?UGZQV243MGhnVW82eWRYSzdaR2djdzJMcnVzSkR6MVBodHNOV2FRc1BBQWto?=
 =?utf-8?B?VjBQTCswOHdCVmUyaUlRL3pxNGVncGxwQmdOY1lRNXk4eVpRS0Y4REtUSEJm?=
 =?utf-8?B?T201MjdFMWx0YXMzV05RSExBWlJ5bG5XL2JXVVVVeUVrU3pXSHRvcFYrQ2Np?=
 =?utf-8?B?SEVRZTN5bFlnUGhZbG0ydFNWS3hjT1pWbE85bmN1QmVMbGNCbTFWTVBFWE9S?=
 =?utf-8?B?ZE1BdXhBd0dLU29aNnVSZlZlejRCeXkzT3ZPSTZ4cDdPTG81WGZ2dnVWV0pE?=
 =?utf-8?B?eUFtOFpucmdjbWFUUWlkbWRvSlAxQTBmS25MTFh4VGVweERDc1oyWlRZWHlj?=
 =?utf-8?B?dzRtdEEzTHZudTNUMUlGY2tRREYraGU2L3hCaVFnNGdNbXdWakU3ZVNoaFpP?=
 =?utf-8?B?RDZWaWpyblU2bTVlTW9ab2RENVdzekVXbTBDTVh5cnBBL1BpZHREYk5WRWxk?=
 =?utf-8?B?Y1FualZYQTRHUFpGMFcyVjh1QVIxZ3R1Y3UwRS9ON0t0SHFrU3pramJwcXgv?=
 =?utf-8?B?aEhLL1ZXeU51VEdyRGRXenE2cjhnb0UzUy9YZk1CQWptVHhVUlYxUnR4Zmpm?=
 =?utf-8?B?a2RIQnZLZG5DeTlGNHROVk0zVnJGb0R2cGpiaERjVExtbGhvU1huTTdpRzlW?=
 =?utf-8?B?cTI4Sm50RjUyV29KUVhFcnlvQTlabFBtNDA0QWVCTWZGa2lKZzJ5OXgybEUw?=
 =?utf-8?B?dGVyZnlET0FsbkNhTFN1RWZHTFg1dEF6ZVZ3REtSS2Y1ZlBjVE1RRFVLaG5p?=
 =?utf-8?Q?O6j79PyGZ2pfKeNSOMu1WK/WSg3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1E1QmNJcWpVTmlKZzVOSldtUG0vUDNpN1dEMXdCQjJ3TFdJYmM4M3YrM1Ix?=
 =?utf-8?B?OW1ZTHkzemI2WmVzTko2WGRVREc5TnhsMk13Y3NWRFZ0Z1JrT3lXeVM3bGNB?=
 =?utf-8?B?RGpXR2RQREkrRnA4emoxY1pkVTlqdTd6Zys0dU1tV00zQ2xlS3BFVEFpTHhl?=
 =?utf-8?B?eFNhL0N3T2w1NzBKeHBkTnNCNmo4Q3kvNlF0NGlndDl4VWFmV282NHZSK1Jv?=
 =?utf-8?B?S2ZyV2R5cEVVVWE0cGprRi8xM3dJYWszcUwzRkRDRzNudkQ0T3RvdUhMbUVm?=
 =?utf-8?B?cEplTGxmUnlnMjJMMC9JWTR4RWpVZS82LzNFN25WYnhjcUcwMDJ0dzJvVXpa?=
 =?utf-8?B?Z1FtbzNidGNmTldHc29NTjRXOEhwUmtVaFIvVlFIWUk5UStDNDdWeHRhZWpo?=
 =?utf-8?B?cjh4bDdxekdOc3lDNWRkeWJBdm94Q3JrdFlTc2FmUndQdVNpdzV1Mmo3N0dZ?=
 =?utf-8?B?dXBxRzhXZDVBR2xYVlhOTXhzWW1Zd2xraVYxamZtWUlzU1pzamV4SXN2b24z?=
 =?utf-8?B?Q0VlQ05TU3o1L0NDbTJmcXlsTVpOTHhpMzUzL1pwQzJiYkVPdzRKRmdzZG5D?=
 =?utf-8?B?RlJFSm5qaWhUZjZCcng3U0pCS1dTVkFiV0NkUkxRZythak9XRjRiRUNTekpY?=
 =?utf-8?B?VnBTUkgvTmxkMmNoL0VoTEZlc0tSbVlha1dCYXhIY2ZPNjd2L0Q3VWhtVVBJ?=
 =?utf-8?B?NmtUVEdnb2RyZkZMN1FIK3BYdUdRaVRtQjZ0YXdMTG1tREVmRk92TkN1K3Bz?=
 =?utf-8?B?dThjWC9aL29yb2FiU0FmTDNDajdIMHk5WUFkMkJuNW5pbGJTMkdKOENubUV5?=
 =?utf-8?B?Q2hvMlZ6NTZ5YW1zcEMrMk5FM2diQ0xHNTRROUc5TlEwa29NSUFSYTRKWXhC?=
 =?utf-8?B?WWFOYTlHQ29WZ2ZveFEyQk5HYW00UlgxeE8wbkVXVS9neGp1MHVnbzhjNHUw?=
 =?utf-8?B?ZzlGaitNWHNjaERUcHdla0J5eWM5Y1pneU53Y1VJd3NVOWZvTENTMHRTNm82?=
 =?utf-8?B?WDdRWTFUMnhxazdkUXFuYml4K01OU0tVQjVDc1pDZkNDb01IYjFlTU9GSXBS?=
 =?utf-8?B?emRuM1E1VURFcnNyaFJBcjBkSk1OOWE5OUFmQVlwTEczR0JUSW5ad01zWHRK?=
 =?utf-8?B?dUg1S0NlcW5iZ0RPQ25iaGRhbjRHSFpzSmpVSTdNZnMvRExhaUhES21HNzdl?=
 =?utf-8?B?RDBncUxtL0tvdnVuODBRdWp0SCthT1JRK2MrcFZlY255YTRZWDZCOGtZTXA3?=
 =?utf-8?B?SmZZWWhsbDlzc0JWRDF4U0RlbmNIQS9aSUlqN3hudnIyVDZTNmNiUVZnOFV4?=
 =?utf-8?B?aUJDaFNOMEgxYzdWNzJBY0VFbm9jRWZaY0Z6ZHZ4TE5STzB4UllBN3hQcHFB?=
 =?utf-8?B?b2VQRkdvZ3daZ0N5OXM5Z1VaOFZkMHBnTmR0bDVXTUV6V2xRVFpnb2FtVit2?=
 =?utf-8?B?ZlJKVzRUVjBKaVpzZFhwcnp0WGxpSCtCbFl2WCtwUWFYSGo4YjZsZlJ4bmda?=
 =?utf-8?B?cllnZWRlc3dRVVR2TDlkVGxYSHJkQUxnTllaUTBRb2k4L24wWDBMZFBZYTc1?=
 =?utf-8?B?SlNGcmdXeWxRMWx3azFBdTh6eEsxQmhUazRqUFZwdDZhWWJ4Sk1hdWlXd0Zh?=
 =?utf-8?B?dUp4ZzVPSjNveEtuNXlUMlEreGZOZy9wUkwrbUZZbzVkZEVQd2VyQjVPU1p3?=
 =?utf-8?B?SUdWeUdGSTFIZnc4VlFxZHlPRzZBcmZmclNUOGVaVXBuaVFBVklHLzFXMURm?=
 =?utf-8?B?RkVVc0xpZis4TkR4U3RrTkR5aExza0JtSW00S1Z0QWZQcXBtM21rTE9ET0pY?=
 =?utf-8?B?dVhkUWE5MWFQYTVyUUhtZkxVbG1ZWHhXQXJ2Q0RSYWozT1puUEs0a1hSdnRZ?=
 =?utf-8?Q?aCk9qkF2b67bv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab756d6-d2ec-46b8-5fd5-08de8bd30c4f
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8925.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:32:50.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8894


On 3/18/2026 5:29 PM, Jiakai Xu wrote:
> In kvm_riscv_vcpu_pmu_snapshot_set_shmem(), when kvm_vcpu_write_guest()
> fails, kvpmu->sdata is freed but not set to NULL. This leaves a dangling
> pointer that will be freed again when kvm_pmu_clear_snapshot_area() is
> called during vcpu teardown, triggering a KASAN double-free report.
>
> First free occurs in kvm_riscv_vcpu_pmu_snapshot_set_shmem():
>   kvm_riscv_vcpu_pmu_snapshot_set_shmem arch/riscv/kvm/vcpu_pmu.c:443
>   kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:74
>   kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>   kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>   kvm_arch_vcpu_ioctl_run arch/riscv/kvm/vcpu.c:1008
>   kvm_vcpu_ioctl virt/kvm/kvm_main.c:4476
>
> Second free (double-free) occurs in kvm_pmu_clear_snapshot_area():
>   kvm_pmu_clear_snapshot_area arch/riscv/kvm/vcpu_pmu.c:403 [inline]
>   kvm_riscv_vcpu_pmu_deinit.part arch/riscv/kvm/vcpu_pmu.c:905
>   kvm_riscv_vcpu_pmu_deinit arch/riscv/kvm/vcpu_pmu.c:893
>   kvm_arch_vcpu_destroy arch/riscv/kvm/vcpu.c:199
>   kvm_vcpu_destroy virt/kvm/kvm_main.c:469 [inline]
>   kvm_destroy_vcpus virt/kvm/kvm_main.c:489
>   kvm_arch_destroy_vm arch/riscv/kvm/vm.c:54
>   kvm_destroy_vm virt/kvm/kvm_main.c:1301 [inline]
>   kvm_put_kvm virt/kvm/kvm_main.c:1338
>   kvm_vm_release virt/kvm/kvm_main.c:1361
>
> Fix it by setting kvpmu->sdata to NULL after kfree() in
> kvm_riscv_vcpu_pmu_snapshot_set_shmem(), so that the subsequent
> kfree(NULL) in kvm_pmu_clear_snapshot_area() becomes a safe no-op.
>
> This bug was found by fuzzing the KVM RISC-V PMU interface.
>
> Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/kvm/vcpu_pmu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..ac1b9a91a19db 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -441,6 +441,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>   	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
>   	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
>   		kfree(kvpmu->sdata);
> +		kvpmu->sdata = NULL;
>   		sbiret = SBI_ERR_INVALID_ADDRESS;
>   		goto out;
>   	}

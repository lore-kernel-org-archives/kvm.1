Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793265328;
	b=JgvWi0SAFC6ppOR5YN77WfXSC0kCn07kJP25G1iBCr+HHZRD7o7zFmwnD5ZlpjYyzNbS
	 NxCY4JXuPr9HQ7WzFPl1KnregBTeoCgb+IEbe3mmQBp7e6NzPmW+2nhe1TMPc07sJm4Gc
	 tLLKl3iWG5g10gmcV1Hp8calE2vZa9+4Zlxg3rkU1zUwm+WTAwWRlsLP1vTYybAb7ie9m
	 aZSbpWY+DFCfNTwEBl8lht5hrW1byZlWbrxRyW1tIn59DR/HadU7vlCcsq5qUbSNT8prD
	 HCD8JU7manroJ2mGSiCPtNGKf1Q8FjFCGOqlZuLNZzk4d+AniE5+GXLTSIXHn5xigoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265328;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/2subHrFBeObK4wiPBbPw/jQbMz9pMJq6JDAfADd/N0=;
	b=E5q4M6u9TwF5lI7f6g+tCaHJ6ryCpRP9Fak8fj7vYQxNSKetCng/ct/kCbpe2DTBHieO
	 Gv9bCJK9nh5VWeembsUzBWXQ+5Ha6RUbPxLr6nng8L/mDxG8MtlprLIEFJdrTKZFwqSrN
	 8r9v/EtVM89lPuKsWj3g6cepZmalPNAFYwxdUmVXpZFsUqhbd7GiyFhTezyy4FVhqK88Y
	 EJciLX3YqlX5fvUWNvrZJ1QsYyauarajb9VDozIliZAUf0WkAbVpOJTha20w6Yg7f0fkX
	 ECPk+kiVEu1SoI3Akmrf8i2R9zMwnWn30Kh0rtzWwsCKQyhFnG5YqqBgh54Xt2wTJUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=YoyHnvQW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.63
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3A606A31A;
	Thu, 29 Oct 2026 09:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=YoyHnvQW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEKtiiq3hTpttQPCMBM+FI5gw5GhT/pwqSlwzB+cdyACC3/ZrUl48jlm1aqDdM6dyId2Ib5IMwENWGbTfuBEurH9pe7XEoHRBAWn9KASsY2h6ZkFGIU+1LCRO+5nAyy93USyPrV/CZnx/67uAQ3NN+6PPGbtyWytgy/It4BCUxlXQsUtw39PDd6yUcvZ0m77cpzEEKeYIJ2I5Pq4UVbVLrlZYkiIKsYv6plvyohiTnPWhP1QQV3UJ3aExwl4Z8PUUbTa7Ahjv2/HE+AVIYst4wCJLmnDWUyVo3Z8T3lIly2EFYQ3xPPH26lY8LOd4zEMRzjEhUPKm/9QtnujgkRhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2subHrFBeObK4wiPBbPw/jQbMz9pMJq6JDAfADd/N0=;
 b=nLuXZ/bIIYxYcXNmOiisceHeSbhaSZVF16kXejiAkWoTpy+963YxIs7VwoV5lFDJNbupeDK0v8bWqvlCXprdHJY7njue/LznZtLLcIj8oPEpS6YI2YxFtWjnsUcST36oOFMwdIxzPWI6pHoux5bcBAAJ4OjoSPVDwb96fvv/brNZL4EMzEH8OmNsEIdzYBwb1eSkiGz3m8/tKSqVd9W2L7wgPJwgNsTuePi4Dqf9WRImpdmpumDnfNbwT/KjFwqFNHCm33oXKaBizFtNgCQClXLxx1OhZkr9fFoA+xpxpAURQeOxx8bLhXkzKCDT6AkQJjYt8zQ+IK5EeWEthW+zJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2subHrFBeObK4wiPBbPw/jQbMz9pMJq6JDAfADd/N0=;
 b=YoyHnvQWZ6dFFoGt2AiaIrBcqL2Lm+Hrvq+7ZV61KXxdyqMj5aWInw0PLe4TuzwJXZvm/QzAuLHvLZ8JksA0OAM+CS0z0ATsbU5yWKxTqze/qJYx53y2HGibSzEJV4qQtdQgHqNg32wAizwQAh1QjnIQywtwUqAsVPC3cMe3GhhOpfgNbwPWHOYIQgzMlwsdmpMrBpJ8pgL4aAVVaTTJm8JCoE/lCJkTvOGKBxNoJdBPUhFcxxP9tlWxyfqnMGszJrgR4BTiMDkoMQFwcYVUz5xFdWBrf7ogabBedcWCQ3HRMZbfk0QPXY+4196IYRSto7bo8EsEZtRBirEgKfKltQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYSPR04MB8167.apcprd04.prod.outlook.com (2603:1096:405:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:15:22 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 09:15:22 +0000
Message-ID:
 <TYZPR04MB7491A2FF4DB08B00DD53E315F36E2@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Thu, 29 Oct 2026 17:15:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: KVM: Add hart-to-vCPU mapping for faster MSI
 injection
To: BillXiang <xiangwencheng@lanxincomputing.com>, anup@brainfault.org
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261029082426.706302-1-xiangwencheng@lanxincomputing.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261029082426.706302-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID:
 <7380a506-9360-4e56-a21f-6ac1ed43eaec@hotmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYSPR04MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 57067b8a-f77a-43a3-6eed-08df359d287a
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KM6CoYXTTNjh34iAhmnTq1Hy6s1oAGoXaV4xl/jIf6IqZZiBWkwDquqwfajn70azy70trndHAcwSGhcgl81Sg/r5Dajfq/5U/eoPFKcY9yFF8eYHuLdPeyGKPv5kO8GyVpmefyl/jhRjDs+rfpFNuZVyUOkuSKI7vxUs4LZRsdw//Mm5epEG2Fpt5mxrSfQIItS2GcUejSLB9bbxc5zHLTq5cob4KzXZeNxfjivbF5e64zVZAiAfLhvzqLavfD4fSdedLc0BzxAIjTuDm4DEis05KW9dp1Rah9mIVSBD8Q9LwmtmgQ39RrIknzCTm9RrmUeEM9Kv8AEjW45nuMf0qjONUZGKwLMR86gUAaRs8aVJ8Mfv/HlVoAyqJe5HZa8WErwyTXmF8co+0sX+fPhCruggFD8p4smA32JfLV34zGdbV3iZNpUKrn72LbuXYG7syQUTxYjj52qjRrx02xtEnoeWmNGeLbL7iI9Azf5HlIqTLu0DSYehGRvjGm08dzpFARxS9qazHEoT331bmSt8qTBZ72kZJBl2nNGjpLrowhAHmwSa09JWfZNNjzSii+NKmT+vKKqJcB7KcJ56gcCczEWWMpZWGTE9dKkeHTB1zkWfETrbyvS4Liyne8zFcKXdi07nMzEImeqUOkTHlqqQnL3XiUPQ/sIDLhEHXE5PtLuxO8Ew2qZDOUyxC1KxdkWWQLrOV9kKqrbAubPPs87e7QGomCZd9T40nnh4bXdDh5hf995dg8AKV+jqRUcam7d6/PvzLftUDAGcLBKxxPBNVfTW1EkOgTuu1XrzcxmEWM4My2jkIdWlpt9gyK+pFtTaZPAU8Dlho24FT/vBBFS8o9o2ih8LWuLm+GiIqv3O3N96A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|19110799012|24121999003|15080799012|6090799003|22091999003|41001999006|8060799015|55001999006|19101099003|25010399006|4140399003|4302099013|440099028|3412199025|1602099012|40105399003|53005399003|20061999003|10035399007|30101999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TldSNWV5SDgvNmN6OUNmbWNYSEdFVmRPSmFscUFqN2VwTEliR1diTHJUd1Rv?=
 =?utf-8?B?QU5mcjdxNUJETVhubVBjZUpQNTVtd1A0bFpvMkFIeVdEa3hWZWw5bU5uMXBN?=
 =?utf-8?B?alVONlhvdkVmSUdoc1NsU3ltdzJIZ0ZZNHRuVGVZZ20weFpHcklzclBLNm4z?=
 =?utf-8?B?MjNQTkFuRkdvNVJ0NDBhM2lxV0NacEZMT3YzUVFwb2JPcWFBYWFvYThxSWxo?=
 =?utf-8?B?VnhEUG02eGhnc092T0RoOVFUR0ZWeWx0TEdtaFExTmRKZUdtWFRIQTcyOE1Y?=
 =?utf-8?B?dGNhUjg2YmViZUlzUlhsbWJFMDc0cWdGVW14dCtLb3k5aTZRMWI1WEpzWHNv?=
 =?utf-8?B?eDdLT0JGSmdvRmZibi9VaGtBbVB3Wm9HeUwwTXR3SnJTdys4YnlzakNOOFF4?=
 =?utf-8?B?UnNib3pqcFRMU2dGalU2aTdsTHcxNlV5T2pseDlPc25vOXZzWU5qT21GaUt1?=
 =?utf-8?B?Q2h3Rzk4TS9iTlpESzQyWWE0dHZuT3UvWEJVRXNDcExWSkw0cE5IdnY4VGUx?=
 =?utf-8?B?ZFBtb3dQREdBcGJiTXlTdjU4VU1aU01DZzEzYURpSWRwbkVxTm04VmhxdEZB?=
 =?utf-8?B?S1ZJVnNwZEFOdjBVUDRXWnZQR1dyckdyS3JvSnhKWU9hUzQyL29xcCtUd3FG?=
 =?utf-8?B?L2lYZXgvVjc5dDMzTGIxMlZmRUdWTVZkdk1TcEhzdjZnZE5RdFBpL3c4VUZ6?=
 =?utf-8?B?WGtiZXY2WHNNQVBtRmFLWHFIWVFsd3JiSncxOXVYWEJiNkVQVDJ0Z2RadjB3?=
 =?utf-8?B?ZTFiOVAvbVdCckpzYk43SXBodjMva0I0NkVOYkEyc29LaDRXZkg5ay9MYnNo?=
 =?utf-8?B?dkpYNXlhMGY0TGJNdTkzOFRLQks5WHB5UXE5MTR5WWFicisxV3drd3phY3ZC?=
 =?utf-8?B?R2YrN3NlK1U3U0t5bjlsc1ZXdjhlbG5PaGR2MHdTTmVLQUtPZ21IcFJmVGxU?=
 =?utf-8?B?UXg4eXJGMlk1ZDBVWGRqY3BVTGNib2w1MzJwczFRY015Q0V1WkhVVERMeE9G?=
 =?utf-8?B?cUoyUy9PZ3dGTG0xVzNaVHpkbnJOTGJJKzRYb2xJb0MvU0Z0UlVhMGpYQUJI?=
 =?utf-8?B?QmFuVDBoclplc3RUdFRBZEtqaFlWL1dKZ29qN1kwQlZ5WVI5NmhnWVhxMU4z?=
 =?utf-8?B?cC9CWHl2eVFGc1M0bGpWZkhQaXl1Q0ppTkJibTdkemwrUHpjcGNqSDcrZUxz?=
 =?utf-8?B?N3V2RnJqQUNRVTdJbFgvdklaRWpFU3ZxTkQwMnI2YVo3NEg0K3JFUUFJKzBV?=
 =?utf-8?B?ek1zaEp4R1NlQ2R5a0FickFNMnBMTTlHRmtDMVcreVFnMDJzU2xjU0dhR0M0?=
 =?utf-8?B?S1BXZlJ0cEtCTHhockNVT0FJbHg4bFpaMWNEU3dvamJvOGZKbDBvL3dGeExH?=
 =?utf-8?B?QnJmenpKKzRiQ3lKQnlKd1k3MmdDOEhLNjlJdWx5TTJuYk9wdnJNdFdXcU4z?=
 =?utf-8?B?NG5YUXlBK2lIZUJBbmFiWWFlZTFGcVJCZ3JISHRjTVBGMVVBSWZTczJ6Zmk4?=
 =?utf-8?B?MWN1NGpySEJkeFJzZFdGN3UwbjhjZVcwb1BGelM3NjVJaHF1MjlEQzVXOWlJ?=
 =?utf-8?B?ZzdrdHA3SHRkTUhwR0lhTThpTUg2V2kzdXltNGJjWWtmWEpoeTZxTEtmUFZX?=
 =?utf-8?B?ajdjOUprMTVKakVlWU9uYWN0WFhwV2c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFrcnZhczA3TlFUWXBKblk3di9lVXRBK0FNR01HWTczaUw4ZzNlRVZORmtR?=
 =?utf-8?B?SVNhV0ZZYXpDM1pnT0hBUmcrWnVvNUF6T1FuWDFLMm1YVzlUV0cyZ0h4VWJN?=
 =?utf-8?B?OTVXcW9KN3RpanllYjZnaTNERWxRNTJPTXFhbkhab3JaVU1MUEVGQU92NlhQ?=
 =?utf-8?B?b1lueGhqbUoxcy9sN1lWcHhEYWd5K3YvTzlQTUZwUlNWSmwxSklHcTIzZnFw?=
 =?utf-8?B?K1NoQzBtQnd2UWF6TmQyaFNjTmhIRUNkVTIvQkpRbERDa280c3l6WE11bHRO?=
 =?utf-8?B?U1B4SkoydllEeHdyVkdnY0NpSi84V0lZdm1YaHF3MnJtOHhVY0s2bUx2WW1W?=
 =?utf-8?B?dHRrUEdQWTliajRnTmRPNVlIckZseW1sRmltOVZaYmIxVHlHVjREUkpOLzR6?=
 =?utf-8?B?cUt2aWx6ZU1PWUMyZHR1Y016VmlxY2duUy9kVGJYRkFkcHlYelVVUXZlbWZt?=
 =?utf-8?B?VjZXVkdlUHViY2xHOGsrUEhWY3QrUHhoM2JmaU16RTdVRmhFSG5DMWU2cEx3?=
 =?utf-8?B?cVZOU0NpSmJ4ZEc0ZmhBb3k2YjFLVGJ1dDArWlJKRzl5RUdWL1VkeUdQRjVj?=
 =?utf-8?B?bGlCQjFsM29CZ29QZGhTSHF1VzZOSzFKbDFSZXkxSzBBYUtPalJ1Z20xQjQx?=
 =?utf-8?B?Zm1LQjlWNGI4aHJNY1VyRDNucWJ3KzVQWGhEY1lqMWdWMFhFaU9YVmU4WlBH?=
 =?utf-8?B?blQ5dVQxZkFDck5PbVVLaVJpNmxQbHVURDl2U2g1cmZOQzZNNDB2ZG41SCt3?=
 =?utf-8?B?MGsyaFNzbm12Nk1iMzhRV0VJYzNiOUZOR2haclRGbk03cGN2NTRCRlNHbUFI?=
 =?utf-8?B?Y1JRNHFOTXFEWHlxQkorTGFVT2QxWTFNYXNNb0lkWndNRXBVL3A0Vy9rVStr?=
 =?utf-8?B?UGpQc1BBcEU2bmVlcU5ESEdCK3ZuV0ZFNzk2TTA0YUs0Yjdld0x1WkpPN0hD?=
 =?utf-8?B?YXIxa1FidGNNS1VJd2F6ODB6d3Q3RVpsNG9GR29TL2haTm5jNzc3M20zZ0to?=
 =?utf-8?B?T2N5YnRkK2NUUXMxbjRINDd1UWRDYVBUeStnRGVyZW9iMUYvZmgwVmNFMzFM?=
 =?utf-8?B?N00xd0E3MWtrZXNndEVVcXk4N1FQcU1FakFWL0s2N2swaG1YSVV5TEJ6eHBS?=
 =?utf-8?B?V2ZsSXNDdGF1OEh6Z2pwYktlalVsU2hJS3FyemloTis1OXFkL2RScm90SWZl?=
 =?utf-8?B?Tkt5MWlEZ2lka1g2WStKN1oreDFiWHYrcU5QZ2dYQ0NjYjZpZ3h2TDlJSXVN?=
 =?utf-8?B?bDAvZUJxaEQ3dWZuUGRWd1hhZHRmdnNHblh2QWpIRDVFdlBJcmI5UXVWZGJE?=
 =?utf-8?B?cDdsUzFqZ0phUERwNnlaclZ3RFl3c0NMMkUyNldQRUJaZ29Odm1vSXN1eUVk?=
 =?utf-8?B?czQ4ZWpnMWZ3TjE4c0xYT3RheHNzeFdhanBOMS9ReTFQODhpRDViTHpNMmZI?=
 =?utf-8?B?T3BuK1FSejJBTm5Pa3liSTBMemdnTm96QVlpNlVYckRqNTZKeHpUaTBLMUQ3?=
 =?utf-8?B?ZUw1TkJ6TEh2Sno2Wmd4VjZNcEdNczBrdXFNVERGa0VhNkdTcVh2UEYzakU0?=
 =?utf-8?B?Q2dqb0w3emhhMDhWUEE5eHRzTjRvb1BkVkxYcmU3Rmk4MUUza1JYZ1o5Smxu?=
 =?utf-8?B?NmhDYlhoQTFmamEzeWFiNi94NTAycWJTTjNoWnYrbnQwejVhZHFqSEQ1VExw?=
 =?utf-8?B?SGRUbCtaSytBcFdGclRnM1gvMDdMQ0h3MldNZzcxdjRCTGJWSG5tdnNURzEw?=
 =?utf-8?B?TUFxckp6V09rQ0F0SWloMEF6WVNMMGVpSU1aczN2ajlCNTAyaER6VWpBUk1j?=
 =?utf-8?B?em9WQUl1aTNWQVFDc1VQaDh4ejRlVEdTYTB6U1RVa2lqOHdvMkJzWnRCeHpa?=
 =?utf-8?Q?Xs+yA5Xu/tS5W?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 57067b8a-f77a-43a3-6eed-08df359d287a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:15:22.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8167


On 10/29/2026 4:24 PM, BillXiang wrote:
> Replace linear searches over all vCPUs in MSI injection paths with a
> hart_index -> vCPU xarray lookup table. This avoids O(n) scans on
> every injected interrupt and improves performance when the number of
> vCPUs is large.
>
> Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
> now use the table instead of iterating over the vCPU list.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> Changes in v2:
Hi Bill,

The change log should be under the tear line.
> - Use xarray instead of normal array to handle incontiguous hart_index.
> - Link to v1:
>    https://lore.kernel.org/kvm-riscv/20260730093614.983508-1-xiangwencheng@lanxincomputing.com/
> ---
>   arch/riscv/include/asm/kvm_aia.h |  3 ++
>   arch/riscv/kvm/aia_device.c      | 50 +++++++++++++++++---------------
>   2 files changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
> index ab03f853e507..3b075f18e1d6 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -12,6 +12,7 @@
>   
>   #include <linux/jump_label.h>
>   #include <linux/kvm_types.h>
> +#include <linux/xarray.h>
>   #include <asm/csr.h>
>   
>   struct kvm_aia {
> @@ -47,6 +48,8 @@ struct kvm_aia {
>   
>   	/* Internal state of APLIC */
>   	void		*aplic_state;
> +
> +	struct xarray hart_to_vcpu;
>   };
>   
>   struct kvm_vcpu_aia_csr {
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index efc7c0bcfba9..a415a8c10967 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -259,6 +259,8 @@ static int aia_init(struct kvm *kvm)
>   	if (ret)
>   		return ret;
>   
> +	xa_init(&aia->hart_to_vcpu);
> +
>   	/* Iterate over each VCPU */
>   	kvm_for_each_vcpu(idx, vcpu, kvm) {
>   		vaia = &vcpu->arch.aia_context;
> @@ -280,6 +282,11 @@ static int aia_init(struct kvm *kvm)
>   		/* Update HART index of the IMSIC based on IMSIC base */
>   		vaia->hart_index = aia_imsic_hart_index(aia,
>   							vaia->imsic_addr);
> +		
> +		ret = xa_insert(&aia->hart_to_vcpu, vaia->hart_index, vcpu, GFP_KERNEL);
> +		if (ret) {
> +			goto fail_cleanup_imsics;
> +		}
>   
>   		/* Initialize IMSIC for this VCPU */
>   		ret = kvm_riscv_vcpu_aia_imsic_init(vcpu);
> @@ -299,6 +306,7 @@ static int aia_init(struct kvm *kvm)
>   			continue;
>   		kvm_riscv_vcpu_aia_imsic_cleanup(vcpu);
>   	}
> +	xa_destroy(&aia->hart_to_vcpu);
>   	kvm_riscv_aia_aplic_cleanup(kvm);
>   	return ret;
>   }
> @@ -557,30 +565,25 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
>   int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
>   				   u32 guest_index, u32 iid)
>   {
> -	unsigned long idx;
>   	struct kvm_vcpu *vcpu;
> +	struct kvm_aia *aia = &kvm->arch.aia;
>   
>   	/* Proceed only if AIA was initialized successfully */
>   	if (!kvm_riscv_aia_initialized(kvm))
>   		return -EBUSY;
>   
> -	/* Inject MSI to matching VCPU */
> -	kvm_for_each_vcpu(idx, vcpu, kvm) {
> -		if (vcpu->arch.aia_context.hart_index == hart_index)
> -			return kvm_riscv_vcpu_aia_imsic_inject(vcpu,
> -							       guest_index,
> -							       0, iid);
> -	}
> -
> -	return 0;
> +	vcpu = xa_load(&aia->hart_to_vcpu, hart_index);
> +	if (!vcpu)
> +		return 0;
> +	
> +	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_index, 0, iid);
>   }
>   
>   int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>   {
>   	gpa_t tppn, ippn;
> -	unsigned long idx;
>   	struct kvm_vcpu *vcpu;
> -	u32 g, toff, iid = msi->data;
> +	u32 g, toff, iid = msi->data, hart_index;
>   	struct kvm_aia *aia = &kvm->arch.aia;
>   	gpa_t target = (((gpa_t)msi->address_hi) << 32) | msi->address_lo;
>   
> @@ -595,18 +598,16 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>   	g = tppn & (BIT(aia->nr_guest_bits) - 1);
>   	tppn &= ~((gpa_t)(BIT(aia->nr_guest_bits) - 1));
>   
> -	/* Inject MSI to matching VCPU */
> -	kvm_for_each_vcpu(idx, vcpu, kvm) {
> -		ippn = vcpu->arch.aia_context.imsic_addr >>
> -					IMSIC_MMIO_PAGE_SHIFT;
> -		if (ippn == tppn) {
> -			toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
> -			return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
> -							       toff, iid);
> -		}
> -	}
> +	hart_index = aia_imsic_hart_index(aia, target);
> +	vcpu = xa_load(&aia->hart_to_vcpu, hart_index);
> +	if (!vcpu)
> +		return 0;
>   
> -	return 0;
> +	ippn = vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SHIFT;
> +	if (ippn != tppn)
> +		return 0;
> +	toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
> +	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,	toff, iid);
>   }
>   
>   int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool level)
> @@ -647,9 +648,12 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>   
>   void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
>   {
> +	struct kvm_aia *aia = &kvm->arch.aia;
>   	/* Proceed only if AIA was initialized successfully */
>   	if (!kvm_riscv_aia_initialized(kvm))
>   		return;
> +	
> +	xa_destroy(&aia->hart_to_vcpu);
>   
>   	/* Cleanup APLIC context */
>   	kvm_riscv_aia_aplic_cleanup(kvm);

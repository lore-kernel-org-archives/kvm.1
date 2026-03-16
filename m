Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012051.outbound.protection.outlook.com [52.103.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E30386C04;
	Mon, 16 Mar 2026 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653055; cv=fail; b=gjxGBM/kaYscqkeRsbWUbf9j4frPR+kWpuVxuN6zhsoTjHzQpY4W6SkaVX5Cx/WhrXF8hj2qFNn0WD773hziC1H8HoSOWrg7qimsLKVCiDijaWi9/eJl4dN9AQHSVZvkBCNe0fBk2Bt3WGv3ChbdoKryPWjGwLMfKlELYPOX4+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653055; c=relaxed/simple;
	bh=/fBShkrtA51jGUcM8vOPZWpFQSyfgEeL31aUWrxX80w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2frLw6C9CEbYUI7d13Y0Pl4ICQHL/hLf+SLKo8vssNvvk3WkgQIz9hKymn9wNxNhGbOXr3PI55erIjg+akul5oGdiipBAS2OWxnypDZRrsgX57GlQTxyrDXL7d78C26PAZySLHq09BPpkEnqzBIDAgi8X4Xg8aRNbrQg188h40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ZqqfA8Xa; arc=fail smtp.client-ip=52.103.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZqqfA8Xa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYKXRe/lf9t6lfovegODWZYSBt1lz3ew6MxJ1Wr4Yg6y6OAfI5t9tbWbhEQxUz+st4vBzI+2HvJB1bCeEe/HuHumzUHyAVbeBU5RjZ325bb9P5dCuXRDkV+4qfJetL5bKH41fwHP177B9bYBjG4KWwDjJWHWsw09wt3Jery+GXxmH2Iz0ZXehGov+otaeL0OUq2Ey272OwAl1ns9lxoJD7R61uLtZTO3GiPyJp6euAS7GFstm1TeuSY1tAnWdj7fEKLYWYgssp9LbCydJoioUH1sBcO3WgNjtwBRtl07f//Wf49tjePlDZhzs7GpQtWh5qLHmUwqIuMShsrNQ11v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xVpX1sTLSy1uOLWLTDmKZsw8xGm7wswnQExa0dzagE=;
 b=szct8mytYVHe5DPSApatxk6XU2jyGyTCgi6wSpGruamXUgAO5mi8ihg1GeZlceb41h9WuZh/R+J65uQuCUBvb9C0ywN7vXgrbvWkTjaATQQZNiyPzFeVZzLydZkOqqigUEnjDWtta5EOx4rVOibTkeEUF5DyyNvMuwL8b/RTSQDKVRYus/SVQ4pGtfD1f1eekUURWk1/AGYSwXeBg/YyC8Am+W7OzKPhuCukLtLHZysN85jTcQsOlFxzDx2XMdXaPRrpkAFqKzse2CbhmCKF2JFcPVrqBB8bCzt2oETBEZuUTCFAVec3UAfy07498+GIeyQ9k1LIcUhtL/+lOajpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xVpX1sTLSy1uOLWLTDmKZsw8xGm7wswnQExa0dzagE=;
 b=ZqqfA8Xa6vJwlW/WWr310L02+jdNB73WxV5AMa0KP3u3Zvy1X+NyWjrsrFF2jyzy4l6frul/+CDF5+2QtjFRfGzdKihybfB/e/xVna+3ghGEUGNnJ53bX5QQ8s6MRtsOKs0nV4f0Tu3wvlasyIRwQre8BdDGTz5w7AjMus2pOUx/Fikm9O1nKmGsF+RK+aYsHl/ADF19cPHN9w1Kn2CAIudBH8LSFLwBINCkNhvIUroVe1rIspJrBNu4oOpslsjK0rCIXi4hEXDSw9ABnQ4jk9z/HcnueguTdjJXrWc9o7+2IN9iRfqPZAih0wP0CVpPczTjwLxBMyXXM4S6CVVUSg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SI6PR04MB8283.apcprd04.prod.outlook.com (2603:1096:4:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 09:24:06 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 09:24:06 +0000
Message-ID:
 <SE3PR04MB892282928C3FB021CCF23AE4F340A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 16 Mar 2026 17:23:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] RISC-V: KVM: Batch stage-2 remote TLB flushes
To: Jinyu Tang <tjytimi@163.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>, Andrew Jones
 <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260307130452.721375-1-tjytimi@163.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260307130452.721375-1-tjytimi@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <892b2804-c69a-495b-8f59-187baae2cb3b@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SI6PR04MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: afd547d6-970e-4bd0-a5e2-08de833dc529
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799012|23021999003|41001999006|5072599009|461199028|7042599007|19110799012|51005399006|8060799015|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uy9wcmNxV0drdUV4SjNIUUhheWk0WWEyK2lsUHdmUzB3Q0RrTU5xUlRBZUxJ?=
 =?utf-8?B?STRRc2EwNzJCOGtGREsvVnY5SExaNWd2NllHUTkwZ1l5STBqRGF0NUZPckg3?=
 =?utf-8?B?RHJiMVJ4ZnMrdXU1eFgzeUFoWWhtOVE3c3BzcTFGSVhiRHNYWGxBMXQ2S2JJ?=
 =?utf-8?B?OElGNk95V2JRUVFXT0o2MDNaTmpXQWROR1kxZWM5cFRneHB2bEhCMVFvVUI4?=
 =?utf-8?B?M1JFcGRTaXdiSXBmMGtNUEFPYzR5VG5xTWJINXJQVXlNV1dGblNDbDRoVWk4?=
 =?utf-8?B?NUNOMytIVjg2Rk42QkkrOGR1OENHS0JJbElVdU14YkExWnVGQTAzRzFBQ1E2?=
 =?utf-8?B?aGxUc1pQQzF1aUsvM01xWC9za3JIMWk0N3NBOERGcEVLdHJxOHdjQmtnZnBv?=
 =?utf-8?B?d2UrWFF3U3V3cHBEZzlLNFJQOWVEVXpCUTdCSGptajhWRGhmQWduTGtFODUx?=
 =?utf-8?B?WXpoOERnaStxcitOeFRSR2xZZ3VzTXNlWi85Wlo1THgxNERzV05SVTJ3ZHdj?=
 =?utf-8?B?SFNVUzNaVjFEZ09yMDZvVXVuQTRJalA3bXdZR2UvaFpWN2pwSmdoTUp5eTFv?=
 =?utf-8?B?UmtyMzNGZHowcWpkWXB5cW1vaXB3M1BvVFZ5Q2l2UGJpUjQzYnlGaFU5N3pr?=
 =?utf-8?B?djcrajZkMndnU3duYkNET3Z4enVSRmhSQzN1SWtGRWgyVWNOVVduSGRSUlFh?=
 =?utf-8?B?bTVlVjNndWV3Q2dPUXJ5RVVURHJ6RWhMZDFZZjBFYzlMeVZyNlloOGdEaFdY?=
 =?utf-8?B?VVFmb2RuMSsxQkk1ZnNpUTdVN2pLbENFeng5NW1lYkZpOFNKa3VTN0V1bHpk?=
 =?utf-8?B?cCtnNU9VWWU1RGFvWmY4Ymc5QlNZL1QwdlNnOWtwY0lObS84d0NBNVZKOEI0?=
 =?utf-8?B?YnVXVjlhK1lVV3lnL1Z1QjBQVFBla2Z1QTdPT3FER3NGQ2c4UElCVjVNOFJ5?=
 =?utf-8?B?K2NsOW5xaUt4d0J4b053YTlGSmFvakE3S3BjU0UzcldGOUZTNVE1TEpINTEv?=
 =?utf-8?B?ZEhaUEhROHlRRG1WcE5mTGgwMzZvWWdRQjI4c3VZQ1EzSUtzdC9mazdqZzdx?=
 =?utf-8?B?N2NRcnVnZ3F4RFVobnBSdGhMVzZCY0hyTm9vZUdBNngrUHB0cUNtVkcyU3NS?=
 =?utf-8?B?Y2d1MFVxZStBYnd1VHlnRXpRRDk5M2pMOWJwNUxIbTRSVlMxUHYxOFpLWjJn?=
 =?utf-8?B?TDZ4UytuRkxCbHhsWGlxRE50QTFpVlVTNjJhRVBsNjhDZVNHc0VZZzdCcGJs?=
 =?utf-8?B?NUZ4Q216K3FHOGdGUlZCM2MwNDVhbWpraFp3aVptOHBtd0F4ZnpTRVpjRUNa?=
 =?utf-8?B?TlJvQkZaYlM1VHFCR0gyZ1dnaEdBcFZWaWpyWlFRcUNWYmVuQUV1NW1iajlo?=
 =?utf-8?B?VEF0WVVNVVJDRmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGo1SXhhbVRyR3gydGJDcWcyZENydTErTjdqbHpXQ1U4SGdTOVVNcVBteHZs?=
 =?utf-8?B?ditqUGJtUjlBMUZZMGNZRGpPNlN4QUFyVFZ4N3V6bzNOQ3JzZm1jSVd3VHVX?=
 =?utf-8?B?cEIrRCtPcWpmSzJLSStYZ3FZbHNNSEdwdjJ0UUZxTHJ2UVIrbmFRQ0Q1R2Vz?=
 =?utf-8?B?SmpqYWFkd2FKb1R6UE5hR0hGRlNRZEprZmhyWkNkYnlxVjExRlFQVk43T1Jq?=
 =?utf-8?B?TnRGeGErcmx2Q3NZWC9pbEJ2MHBUSGJmRThRYUxLUHY0MHFscXVrZk13bmYz?=
 =?utf-8?B?cjh2Q2h3eGE4WmlKZ2ZGbU5UN25pc2U1clRPVTI3VWs0OVhPdzN0R1lrdGhT?=
 =?utf-8?B?VThtVURHckhtalZzOGhtNUpIOFk0UEJIOVFENDgxWWZoVWRGd2xpNi9DM1Fx?=
 =?utf-8?B?dUJxQU03dTNRYkZxYjRJYVdSRmcwU2w4VGJpM3lMcE9MR0gwRFdMNnJJNWln?=
 =?utf-8?B?ZlQvcGltKy9qZHdkWG0rQTFsQ3hQZktsQ2kvZDljV2Z1YnVra1dsTU5nTDJr?=
 =?utf-8?B?TER4SmI3VVBVMWhncFptYzRlTTBrTVhiSkVWeEhNMys0SitnY0wzc3dxSVgx?=
 =?utf-8?B?NCsxV0duUXVVdzBNbHY3QkdYWFJjSTJURnQvbEhkQ0t3b0dBR3E2WEZscTlt?=
 =?utf-8?B?YktrQjEvbmtzRi9DMXROcUY5RGJRejZoVDkxWHNrWHVMc3pUL2VHbTNJZTB6?=
 =?utf-8?B?KzdISXBsUFdwM1lBVXpnZjhNVUZuR3NMVE12Y280Sm5vR0pZNWcvc2tpblpm?=
 =?utf-8?B?cWs2MFNqYnpjSU1DblFnYTFvYTExN0Yxd2psTjYzWkdmNlMyYmlUemNxa292?=
 =?utf-8?B?dUVzVUxDbnh3N2hCV2JXRXppb0ZSbzh3djNka3pHd3d1NlpXWEFlU1pHemVo?=
 =?utf-8?B?MlZsY0Nnd0RWUEtLTUJXZWRKT1RMVzU4YWRPT04yNU1LbVROYVdmVUlEYnhH?=
 =?utf-8?B?b3E1M0xsSTVoYWpkZW1yRklCNEdRcHRDNDQzaWVZcHl5SVQvaVd6bHdWb2hy?=
 =?utf-8?B?cllJeGRoWmMxSU5CVE42SnV5TVo3bW9jQ1FVQTFVbENpYy9vQXdRRlp1NjN2?=
 =?utf-8?B?MUNQVmpvb1hxMXkwNnJUdVVRVE85K2FMMWMzWjd1bzcrQ0U2Z3gwWm9ld0xj?=
 =?utf-8?B?WHV2Y242OTBkajN3QUl3Z3l6VWEwMzdGM3dNRkNJTjNFbEZVczBiSFhxS1NL?=
 =?utf-8?B?dmw1ay80QlE2MGFpQWtrOEtld3V4cWJzeXpDbktPUU9nR1BxZnZlN3RyK1Jx?=
 =?utf-8?B?ZlIwU1dqakZaQ1cyZUpQeVlRRkNjTzBrMkVuV0VLbGlMUDVXUWxpeHczZWNp?=
 =?utf-8?B?YzFlZ01NU3lMcWpuNHhIWm9NOE41aC9SYlQ1WHdlNUZjcHdlY0ljL0lIN2k1?=
 =?utf-8?B?c1dQaEM0ZWNkN2pyUlJYY3UwU0NmaHNxYXFXT0JkemFxZk11WUN6NFgrQndL?=
 =?utf-8?B?VTlIZmFtSVJJd3QvaU9mWWhnL2lWN0szWXhSd2c3UFRiVzU4bkx3YWlrNWFu?=
 =?utf-8?B?REtBNncvTWRoc1AwSmFmTEJyb0tibGF4RHNjLzc2eDZTNWUyOFRMODRaYXhH?=
 =?utf-8?B?Q2s3OFpCMURiSkQra29KL3oyR2NITHNSMjFMTVgvZWNLb282Y3F6V0Zwenpp?=
 =?utf-8?B?KzBDcEp6YkN2eHFseG1DY2xTK1p3MkNzM3BzOEZGanVOZTd3dXQxcU01NkZp?=
 =?utf-8?B?aW45aUkxTzZsL1cva1Y5ZXJVY1RuSnBPTlFTbmY2YWYyTVVWQUwxN0JYZDFm?=
 =?utf-8?B?SzR3aVc4bkM2OXByRUVMZEp0VWY3SGpDYVRjZ3JiYkx3N0NYVDJXSFlYb2E0?=
 =?utf-8?B?UGdJOWpuMGc3SHd5Y0VYeXE3d2F6QlY0Nk9GSk5uQnh0Z3pvOG1DdFZjOHpk?=
 =?utf-8?Q?xsAZs5Z3Be1kt?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: afd547d6-970e-4bd0-a5e2-08de833dc529
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:24:06.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8283


On 3/7/2026 9:04 PM, Jinyu Tang wrote:
> KVM RISC-V triggers a TLB flush for every single stage-2 PTE
> modification (unmap or write-protect) now. Although KVM coalesces the
> hardware IPIs, the software overhead of executing the flush work
> for every 4K page is large, especially during dirty page tracking.
>
> Following the approach used in x86 and arm64, this patch optimizes
> the MMU logic by making the PTE manipulation functions return a boolean
> indicating if a leaf PTE was actually changed. The outer MMU functions
> bubble up this flag to batch the remote TLB flushes. This change makes
> the generic KVM MMU callbacks (e.g., `kvm_unmap_gfn_range()`) actually
> effective by returning the true flush requirement rather than `false`.
>
> Consequently, the flush operation is executed only once per batch.
> Moving it outside of the `mmu_lock` also reduces lock contention.
> For directory pages, we keep the synchronous flush to ensure safety.
>
> Tested with tools/testing/selftests/kvm on a 4-vCPU guest (Host
> environment: QEMU 10.2.1 RISC-V)
> 1. demand_paging_test (1GB memory)
> 	# time ./demand_paging_test -b 1G -v 4
>     - Total execution time reduced from ~2m33s to ~2m25s
> 2. dirty_log_perf_test (1GB memory)
>     	# ./dirty_log_perf_test -b 1G -v 4
> 	- "Clear dirty log time" per iteration dropped significantly from
>       ~3.02s to ~0.20s
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>   arch/riscv/include/asm/kvm_gstage.h |  6 ++---
>   arch/riscv/kvm/gstage.c             | 40 ++++++++++++++++++++---------
>   arch/riscv/kvm/mmu.c                | 34 ++++++++++++++++++------
>   3 files changed, 57 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
> index 595e21831..b003a07f1 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -59,13 +59,13 @@ enum kvm_riscv_gstage_op {
>   	GSTAGE_OP_WP,		/* Write-protect */
>   };
>   
> -void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> +bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>   			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op);
>   
> -void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
> +bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   				  gpa_t start, gpa_t size, bool may_block);
>   
> -void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
> +bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
>   
>   void kvm_riscv_gstage_mode_detect(void);
>   
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b67d60d72..8e7a69d35 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -209,49 +209,59 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>   	return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
>   }
>   
> -void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> +bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>   			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
>   {
>   	int i, ret;
>   	pte_t old_pte, *next_ptep;
>   	u32 next_ptep_level;
>   	unsigned long next_page_size, page_size;
> +	bool flush = false;
>   
>   	ret = gstage_level_to_page_size(ptep_level, &page_size);
>   	if (ret)
> -		return;
> +		return false;
>   
>   	WARN_ON(addr & (page_size - 1));
>   
>   	if (!pte_val(ptep_get(ptep)))
> -		return;
> +		return false;
>   
>   	if (ptep_level && !gstage_pte_leaf(ptep)) {
>   		next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
>   		next_ptep_level = ptep_level - 1;
>   		ret = gstage_level_to_page_size(next_ptep_level, &next_page_size);
>   		if (ret)
> -			return;
> +			return false;
>   
>   		if (op == GSTAGE_OP_CLEAR)
>   			set_pte(ptep, __pte(0));
>   		for (i = 0; i < PTRS_PER_PTE; i++)
> -			kvm_riscv_gstage_op_pte(gstage, addr + i * next_page_size,
> +			flush |= kvm_riscv_gstage_op_pte(gstage, addr + i * next_page_size,
>   						&next_ptep[i], next_ptep_level, op);
It would be better to align with the first parameter.
There are many similar lines that need to be aligned in this patch.

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> -		if (op == GSTAGE_OP_CLEAR)
> +		if (op == GSTAGE_OP_CLEAR) {
> +			gstage_tlb_flush(gstage, ptep_level, addr);
> +			flush = false;
>   			put_page(virt_to_page(next_ptep));
> +		}
>   	} else {
>   		old_pte = *ptep;
>   		if (op == GSTAGE_OP_CLEAR)
>   			set_pte(ptep, __pte(0));
>   		else if (op == GSTAGE_OP_WP)
>   			set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
> -		if (pte_val(*ptep) != pte_val(old_pte))
> -			gstage_tlb_flush(gstage, ptep_level, addr);
> +		if (pte_val(*ptep) != pte_val(old_pte)) {
> +			if (gstage->flags & KVM_GSTAGE_FLAGS_LOCAL)
> +				gstage_tlb_flush(gstage, ptep_level, addr);
> +			else
> +				flush = true;
> +		}
>   	}
> +
> +	return flush;
>   }
>   
> -void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
> +bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   				  gpa_t start, gpa_t size, bool may_block)
>   {
>   	int ret;
> @@ -260,6 +270,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   	bool found_leaf;
>   	unsigned long page_size;
>   	gpa_t addr = start, end = start + size;
> +	bool flush = false;
>   
>   	while (addr < end) {
>   		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
> @@ -271,7 +282,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   			goto next;
>   
>   		if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
> -			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +			flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
>   						ptep_level, GSTAGE_OP_CLEAR);
>   
>   next:
> @@ -284,9 +295,11 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>   		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < end)
>   			cond_resched_lock(&gstage->kvm->mmu_lock);
>   	}
> +
> +	return flush;
>   }
>   
> -void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end)
> +bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end)
>   {
>   	int ret;
>   	pte_t *ptep;
> @@ -294,6 +307,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>   	bool found_leaf;
>   	gpa_t addr = start;
>   	unsigned long page_size;
> +	bool flush = false;
>   
>   	while (addr < end) {
>   		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
> @@ -305,12 +319,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>   			goto next;
>   
>   		if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
> -			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +			flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
>   						ptep_level, GSTAGE_OP_WP);
>   
>   next:
>   		addr += page_size;
>   	}
> +
> +	return flush;
>   }
>   
>   void __init kvm_riscv_gstage_mode_detect(void)
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 0b75eb2a1..075cc433e 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -23,6 +23,7 @@ static void mmu_wp_memory_region(struct kvm *kvm, int slot)
>   	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
>   	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
>   	struct kvm_gstage gstage;
> +	bool flush;
>   
>   	gstage.kvm = kvm;
>   	gstage.flags = 0;
> @@ -30,9 +31,10 @@ static void mmu_wp_memory_region(struct kvm *kvm, int slot)
>   	gstage.pgd = kvm->arch.pgd;
>   
>   	spin_lock(&kvm->mmu_lock);
> -	kvm_riscv_gstage_wp_range(&gstage, start, end);
> +	flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
>   	spin_unlock(&kvm->mmu_lock);
> -	kvm_flush_remote_tlbs_memslot(kvm, memslot);
> +	if (flush)
> +		kvm_flush_remote_tlbs_memslot(kvm, memslot);
>   }
>   
>   int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
> @@ -88,6 +90,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
>   void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
>   {
>   	struct kvm_gstage gstage;
> +	bool flush;
>   
>   	gstage.kvm = kvm;
>   	gstage.flags = 0;
> @@ -95,8 +98,11 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
>   	gstage.pgd = kvm->arch.pgd;
>   
>   	spin_lock(&kvm->mmu_lock);
> -	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> +	flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
>   	spin_unlock(&kvm->mmu_lock);
> +
> +	if (flush)
> +		kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT, size >> PAGE_SHIFT);
>   }
>   
>   void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
> @@ -108,13 +114,18 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>   	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>   	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>   	struct kvm_gstage gstage;
> +	bool flush;
>   
>   	gstage.kvm = kvm;
>   	gstage.flags = 0;
>   	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
>   	gstage.pgd = kvm->arch.pgd;
>   
> -	kvm_riscv_gstage_wp_range(&gstage, start, end);
> +	flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
> +	if (flush)
> +		kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
> +			(end - start) >> PAGE_SHIFT);
> +
>   }
>   
>   void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
> @@ -140,6 +151,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>   	gpa_t gpa = slot->base_gfn << PAGE_SHIFT;
>   	phys_addr_t size = slot->npages << PAGE_SHIFT;
>   	struct kvm_gstage gstage;
> +	bool flush;
>   
>   	gstage.kvm = kvm;
>   	gstage.flags = 0;
> @@ -147,8 +159,10 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>   	gstage.pgd = kvm->arch.pgd;
>   
>   	spin_lock(&kvm->mmu_lock);
> -	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> +	flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
>   	spin_unlock(&kvm->mmu_lock);
> +	if (flush)
> +		kvm_flush_remote_tlbs(kvm);
>   }
>   
>   void kvm_arch_commit_memory_region(struct kvm *kvm,
> @@ -253,10 +267,9 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>   	gstage.flags = 0;
>   	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
>   	gstage.pgd = kvm->arch.pgd;
> -	kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
> +	return kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
>   				     (range->end - range->start) << PAGE_SHIFT,
>   				     range->may_block);
> -	return false;
>   }
>   
>   bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> @@ -579,6 +592,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>   {
>   	struct kvm_gstage gstage;
>   	void *pgd = NULL;
> +	bool flush = false;
>   
>   	spin_lock(&kvm->mmu_lock);
>   	if (kvm->arch.pgd) {
> @@ -586,13 +600,17 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>   		gstage.flags = 0;
>   		gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
>   		gstage.pgd = kvm->arch.pgd;
> -		kvm_riscv_gstage_unmap_range(&gstage, 0UL, kvm_riscv_gstage_gpa_size, false);
> +		flush = kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +					kvm_riscv_gstage_gpa_size, false);
>   		pgd = READ_ONCE(kvm->arch.pgd);
>   		kvm->arch.pgd = NULL;
>   		kvm->arch.pgd_phys = 0;
>   	}
>   	spin_unlock(&kvm->mmu_lock);
>   
> +	if (flush)
> +		kvm_flush_remote_tlbs(kvm);
> +
>   	if (pgd)
>   		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
>   }

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282535;
	b=oeY7FWsxtWLDhmE3O1RtGJ5SXkfkcEEfnMt3QWmNdvSxK0wOBCg2efH8x0Ko8suO8CGX
	 AW576aJ+1I3co2xkERQOnPRIOYytPwrB19KVyYE8bFFmpJ/jbeDG145N1WZNXZ3EqnXI9
	 OQzBF4GCgoWdi//fW+CVSKeaCSJBTtvCDbVVcu5NsNpykR6IJ8xOrZ1Y8p+IMHqmAbqVT
	 ykiSmLY1AKWwH3C5RHs/tfK4kJjJbE9E6KrA02Bcdo4CG4PzFVsgyZrO3nDjmWPU8zID6
	 d45+Tt717AnfUmPKkAW5qlfKaD50JdEZh3tGGLS1XLQi48ETWajVCGPULdw0EBpE7ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282535;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2CmVX3mHznKL42+UvNvVHMd56rdYAOHtrtm1B1OsuQA=;
	b=sgMYKLd+Rl/Jg6DTS+kNpd0HYGRNafumEBXXrgn8CJKPgBoifQl2qKH6BEDmLubMwQ9w
	 sexhhgihbnyVkF6jdz6A7bXc7+usaYrnd1PYd/3lZdrKWAsYZapGjQsDfJSXGoZRAqRe9
	 ylcAT8KAJwa2KwVbScGeY+bc8KuAZP/Xt85CZbI1nnrQOFSplJN7t0RX4yYlZQt00NHxG
	 aH9YGBi3po5fdKMU2NrTGPX/E1h5sXLrUkZLkiZlDpyzzVZsXVXKwk8pj3zUP6Bq59LZL
	 jlfA/8ETYrbfuqfMpXAZ5d0kqNqVwyeerxcjvoTE934YVynVtJGBVBZnVfAzxMVwxtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VHD8uZjs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.120
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39839606A32C;
	Sat, 21 Nov 2026 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39839606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VHD8uZjs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms2bg7u8Ih7hRzEl53w0ebPQq7u/2W05MCY+YS2RHpPbjaGwLoASSoxKiDzEtoKARDd3HoKoKlZcA9/pvsJ+B8rZoihYxMoUZFNUp/PBSfWtPkw4P8OyNruuZgUK+V//DTIzoBlu5hTmu3QXuEWZndvK7RRqqxjBrDlB4t9/yiS7Zq8Qvza0PcTp95KiRbWZfk8EUIUfLtXG9w/OnmTK3irlhIOfJqSX3gFUTfAIu21aCbko+/G0AOOe4YIgKT2UFdRGqVxufVYRzb+LLTG8ymMVV4ldxS5Z3OCrQgzwifuBCDauPKKx8oIY+2NDULJ8HIvXPRlQ/Ooli+8aB/w09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CmVX3mHznKL42+UvNvVHMd56rdYAOHtrtm1B1OsuQA=;
 b=CaHVhRNi7pQZ1zLB5uRwY3LzP3jthMLZ9FSOCK4W6ywlQgVJTtsedn5wXI9zKhCLX+sYcwcEGrmMUoHVaF0ZpAd3WJnVYQnZje0x3z3GjPMdqwKRxsEgzA8/DxFRUGHaUDiw418MjnOfKtmN0Ue0QSa8xyolgr4lKalLKUq85FD0pMIkLkHK0JJYhGTiLMHd7X9N/okd+Y9iUs1KmvwyDUZVBloRK8JpRCznXh91ML2e6Py2eusQ3C9eqck+VkwSLW6oi1DfAcCCSZctua0gfI8nJvim9xXuQgGq6hIvZtPuj3Nu7Hdf3nGjdM+k439ja64r3LFfN3OzAyRGxB3X9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CmVX3mHznKL42+UvNvVHMd56rdYAOHtrtm1B1OsuQA=;
 b=VHD8uZjsME5qnUI7/yv7I2c6bJKhIxTvbCFEzIvzQJPEhIkiAXK/G7qk+J4u7PBIcZZVzeeuAWe8Lp3IvQt0kYofBpSWcGEpT/kknhKc9NqAMRMREo+8FT0BKKP2iOmxd5FtKkLDeN/muzwHM31idvp4esem3N3B5AGK0XO5e8M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB5134.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 17:35:30 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 17:35:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] RISC-V: KVM: Lessen steal time update overhead
Date: Sun, 22 Nov 2026 02:35:23 +0900
Message-ID: <20261121173526.892344-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0081.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ac5348-3e79-4bf2-9f13-08df47f5d6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|23010399003|18002099003|6133799003|56012099006|260925022911599003|260925021911599003|260925021311599003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026135527099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5alztBNy4pRSuaoHW4Ouwe/cKyP5sPpBofXy8xUIiQ3UwOlqzA5BVGL/qYi8uXWF8Kkb/gnfeYYY2LHBQRXP6TuesVvddlwFzB+wcXsHhtH9LD+quMXQBQzA5reK9IB+BeNt38Jb786y9PCtQBTKpxwN25lMTtGBn60zFwDDA+TNSuPLDvW2u96/EA2oBlDgXc+MH/nT1PFoPoXOCR1fH6THMp8xT6aCbQyp02tnIK+eh4vWdvz/NCUrKn4u2KrC2fkr1+WVfP8iSEbDT3PiogxASli13bqwhmESDQK3nvnFfmDp6tSyj+YBwPK7EPuFStHVRy8MCbzDmLTiueNsXnG2lf96bkzrWsn5RTBOTFk2+7EgSTH/6kQBxEnpy0b8qszstQ48lEntmds2E6zFXyzvtu93/L1nR996XdUAhvHit4TYGtPm76vkM+7IACkEoM9hbcXAmgV59liiJQd1020IhpGx2q8xBxumh7N1YvNlVIs3NqEhl7SG/pQzPj60RcYpUnMBplvI+i80tVTzMEiW/FUXGHbywauRGiWNHcoPzkyHOxFfw7v7FolJF20BAjLlD9/R/reRodL6BOEgo5dZMLqak/mZYfqxS8P1cew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(23010399003)(18002099003)(6133799003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026135527099003)(261026140227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDxpraYI62/zEOJ+3f6W0KODSs1hlLb3s1RhWXNjR5bWHIJYObA4mKO91dUG?=
 =?us-ascii?Q?bU/kjAfKtwhQw4GhbecDgOTWl/RBubDGQj0lrAfgpPqBnGkao6a8/aukqATa?=
 =?us-ascii?Q?vd68tsE4Va2WJDflJ8wq2sMX62ORtuGhbeBQHMNua+FPLtm5ZVqMlM6PmLWj?=
 =?us-ascii?Q?Ggp0b2MHKEjsVra/u4Bvp41xUbYBM/DjED4zExHoIhAc67UMyQNVnaQMO83R?=
 =?us-ascii?Q?QAQxYWfYTXzDUIHEi85Ftlkk8ob1Oy5OEF7i91oh6tuEhvFZVzHnss8kN3/s?=
 =?us-ascii?Q?qCjfdN5iPceiyLzeTvknESj7lJUQ3+B6+GavjyNoNePsQNpzVL6cY7f4cKpH?=
 =?us-ascii?Q?YLO9fN4zYHJ3coaIn6zSuR0YATpHkc5PPFHlpHbBXSbSDf1sEXtM2M+D1DQE?=
 =?us-ascii?Q?k8MPPOdhi1ch78pB0XGUijM5tjCjy5W/R+ScKCf+/ZA0PeSKNSJDvA2vehDN?=
 =?us-ascii?Q?hB2hNC2QLb6XNv6o3ToVUuBd9ezWAW8xFOPXZ60/qW/CbdfJwot75o/aQyla?=
 =?us-ascii?Q?h1b+w4/D0hzBzBx2b1DdYW0r44Uer/6fzDC/cHI7NjnFTVuxLhIXFNCEH+eA?=
 =?us-ascii?Q?k5sOp8bYouOjSbjuo7pgIj48efIeqn5kiwqV1RrwzNw9lxyoqagUbMRYbD8e?=
 =?us-ascii?Q?Urr1aAYo09p7R82AiIQN8rhw+7DtDA5Z4KfQrpD/eES/9UGKz7jJyJNW2d8d?=
 =?us-ascii?Q?iiJ8aDOrIGO9iprbCq584Y44DYpDXq7KI1y0/N5INYZkneEDqza1+6oXwZyb?=
 =?us-ascii?Q?XCHmfCfJULkeSaVPMBeuT7bkCsyYKVannUyEv0PEz+3FSuDJA67yPlbiTUTy?=
 =?us-ascii?Q?PdwN4YPSot7yYdJwbPmhxmNweZzR/Fdq1ZnWgTza6FekZzyMs5ujhMMcQj7q?=
 =?us-ascii?Q?CEIORirdwCv1RfyuL42yg9NgMMXuUBtf5rQfwQI0MSnf4YjPLxADI2TeCI2h?=
 =?us-ascii?Q?lhJamvOfhIq+jMRQqxqF2K6o/gPl4xhjAdcnR9Xgc7ZFUJR0IT3m+VZ364BK?=
 =?us-ascii?Q?o8PENBjy5BPswjNiM+G9o43Situn1f4vAm/1WXyOteKYEpgoAsveHUHa2xD9?=
 =?us-ascii?Q?GgfwVsf6yY5IVUsc8xmTRBcg7uzV0SiLgp54Jcduqoy4hcq9bZsNn5hrIo2G?=
 =?us-ascii?Q?HboWAvF8+rf/oUuDfL/fLwMmy49jmB2mcLrsc566HgIeLKpPituwqj5kLhZT?=
 =?us-ascii?Q?G7JNzzTyKUpyMllqJVVg+8Q5geOLh+bB2mbJBKgod/vZ9u+aDv8SThr7D73b?=
 =?us-ascii?Q?VBHktL42oKpXINahLsOb2qs+Wn1iIQCW2Oq6SaOwq2rl5EDvCahgr6J4kzpo?=
 =?us-ascii?Q?RvVHhmJ5LAoWkYDw9kQb/iDSVeFkGMVPJvhW17AAxkN9zgwqZFY5OdZPJy+Z?=
 =?us-ascii?Q?LOtlu6QkAU10/PM71luX8MiHBEL3XtwkiKe3qRjnsw6I+wBd2q1kP8XMD/bS?=
 =?us-ascii?Q?/v2fAyqkMZ51oQbfxno0sIj9uZ6AC/md0lc7kViqBdqczfG4ISbw0dWH7374?=
 =?us-ascii?Q?S46jrtvyom4G0aiLg9pzstVv5JIIwX2r1znjLC+lkS5chKJsXs8MbDZXroxF?=
 =?us-ascii?Q?jgyjWAYKo4RLhO+ZLT4GqPcP+L2elZAwukDI5wSkZPM7afO4hQlEWkpjcp/p?=
 =?us-ascii?Q?uEZAEYTZM4/2EeCj5OCEmO8Q2bNgRYj4SvcUPBIPHFBV1SPWWPBqSX6PHT58?=
 =?us-ascii?Q?L+r4i71X+K0non+9Nox++B4WajCwJxPeCT/VR34ZBoU8LkxC6QQ9GGa6q7Tn?=
 =?us-ascii?Q?bhH0Z1ps+fXvLGrtPUbf6ySoDyGChMtgaG3pD+3ziqc5WAetEPsR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ac5348-3e79-4bf2-9f13-08df47f5d6a4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 17:35:30.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APsquEpMtuTDBmgyyN0yrv0NDJpXUZjwszveyBTcyT51oNZ7/XQYC5DQXpXY0WYbzd8Md7Pt8UGiUTiGEwfWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5134

Hi,

For guests that register an SBI STA shared-memory area, this small patch
set reduces update overhead by batching user accesses and also skipping
updates when run_delay is unchanged.

Tested on SpacemiT K3:
The benchmark uses KVM selftest helpers. The guest registers its STA
shared memory and calls GUEST_UCALL_NONE() in a loop. The vCPU thread is
pinned to one host CPU and re-enters KVM_RUN after each exit.

The table shows the median vCPU thread CPU time per round trip (from
host userspace to the guest and back), measured with
CLOCK_THREAD_CPUTIME_ID. Each case has five runs of 1,000,000
iterations, preceded by 10,000 warm-up iterations per run.
Below, "contended" adds a busy loop on that CPU.

                Before      After
  ------------  ----------  -------------------
  uncontended   2900.01 ns  2669.59 ns (-7.95%)
  contended     2876.42 ns  2670.01 ns (-7.18%)

Based off of riscv_kvm_next, commit e9bf49bbc422 ("RISC-V: KVM: Fix
G-stage page table memory leak on VM destroy")

Best regards,
Koichiro Den
---
v1->v2 changes:
  - Address Andrew's feedback. See the individual patches for details.
  - Rerun the benchmark on SpacemiT K3 and update the results.
  - Add Andrew's Reviewed-by to patch 3.

v1: https://lore.kernel.org/r/20261118062242.2914385-1-den@valinux.co.jp/


Koichiro Den (3):
  RISC-V: KVM: Order writes to the SBI STA shared structure
  RISC-V: KVM: Batch user accesses when updating steal time
  RISC-V: KVM: Skip steal-time updates when run_delay is unchanged

 arch/riscv/kvm/vcpu_sbi_sta.c | 68 ++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 29 deletions(-)


base-commit: e9bf49bbc4227048685c78f97e1446845760df4f
-- 
2.54.0


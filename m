Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023142.outbound.protection.outlook.com [52.101.127.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95B345EDE
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511390; cv=fail; b=BCcrxs7X5eYPNIv/iYrUeBzksrixjgDAYIN8C0LTUvpbDgCIttun7AE8H1/yGCbzThoaaCYU13Y5et3ohX8lnLduvw6ZEsF1yjqlqGJjEqLwWsCwh4ppuX7FzSn2+f3+sLXjfwc2t05BUr6xzeZBqzLVKIkrpOCgFqHg3o0CnAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511390; c=relaxed/simple;
	bh=2eDhT99K/dxlb6mF5XOKnAZRHK+qR3ICtMZWiaDHD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=In5/zKM01teceS0nMHWx2FYDe5Q9reCW1Bg8kd4UX4S6K8KF8R5QHXR643Xj/X4nMQ+Tj1zOveqVvuZUeyR2whcjT2ibnejs+bMvgcRORM9YgZrRqCfd2PlIlp3LdrwfM6RBDjaY3s3tystKh8N2j9uM4K04AUY144SXIgR6buM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=jsnTeSxO; arc=fail smtp.client-ip=52.101.127.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="jsnTeSxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlcbDLmt17PL1KHG1mLhtvJvDBgF8GuIRZw5s6AJbPpQ6rqBqmeQJ86OlvGF7LgcZk5MR7AkE3I6DwC17s2YUa/mynEqeLab7EcgLqo/qcgfKYxHaIgfRT8uEu6rbxMqgTX9YBMKt5P8N/6KNBnh08BhmL6z3Ka+aCDn9nvVny+J3hg5YoZUrQvCzoVJ71Y84bYNtVKycYFkBbQUt13BTpJcs66JMohjCZBgvBg/xVW5TS87zufXu6FyhloK93lwZ1J4ogC9uW+dDXAsq6ZnFZiy4keWwRkMtBay9u4BKD0rcQVsOA8ScHWPlHC5pYqzHpxZ1lGp8U/G9LiLopNi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCV1RTrFz8GKOyerhNCUZ1uRjqnC+Qtf8kNFF4KLkM8=;
 b=Yxi+K0OQgz21QeNXU5/uiEtVnOY3A99zplYHy2KREeERTYoR8BOmQDsbWqUiB4kTKJmysYV3RohIt5vgBAHcRUCsPWWuvpGhtPUDngxv995E8WP7pMFhSaG2bMdTkFzPYwPu58FB/J899hH/oP2878CL4zEkiKSiByGSa887i0mxgJZClPtZGA2HtRuyNWQBzHAZTZwo8pAj1KHjhPG37w9XTtbHd/pc9arGAnHDX339xKqne86EPMjTrLwJ2s/ukrteWkoKL7QDmsbOJDjueXYnLMJbU7I4BrJKLItHKjaB+ChTL43oni6CTdZeWqJbiaaeJDLTQ8mjfJJavJ77ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCV1RTrFz8GKOyerhNCUZ1uRjqnC+Qtf8kNFF4KLkM8=;
 b=jsnTeSxOMHGNEnFZOsJset9CvkM0KKyP0hrfuEmSxmtpXwRH27QAKSLhE8ku2DA8hvzfRKF8yoFpwYefpCvekuuN+yyt8+B9yBD0WswOgg7AhwtxXhBmVHQBHVbM8vY/zEY9jzApQ9Ye/aRCZUd/XD6Bkt+xJkpRirlQi0BYEUsXXHw1muHB25PFTtdYxRNzSSga2VT274MOPeG7/v29yHuaxIsPegbzRt5F8QIBvNAbfhcV9H7fCfz0AZT8CBPJ8Us1yPzmI78Fk78XVRfg2aaB3NVPQx6QMByxJ2pBVOCknYsRYsQOfRs7/TD2yALMWKqku/hhfdVkfgsAXY3uWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by TY0PR02MB5621.apcprd02.prod.outlook.com (2603:1096:400:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 12:16:24 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 12:16:24 +0000
Date: Sun, 27 Sep 2026 20:16:15 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
	xen-devel@lists.xenproject.org, Igor Mammedov <imammedo@redhat.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Fabiano Rosas <farosas@suse.de>, 
	Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
	David Hildenbrand <david@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
	kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Stafford Horne <shorne@gmail.com>, 
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
	Weiwei Li <liwei1518@gmail.com>, Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, 
	qemu-s390x@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v3 034/114] target/riscv: Include migration/vmstate.h
 instead of migration/cpu.h in machine.c
Message-ID: <arkILubl2mARqX39@MacBook-Pro-4.local>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
 <20260923131635.1894-35-luoyonggang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923131635.1894-35-luoyonggang@gmail.com>
X-ClientProxiedBy: PH8PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:510:2da::35) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|TY0PR02MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef0dbda-0881-4109-31c1-08df1c9124da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dCG4AKz2TSOTXpPh6fozxrva9ygcWuOKW/crKVHDWSwr39AP5566wSSN58bmSi15BkV5kV9BM9KfczKvHDFPtHyTtxdsBXaRZTPr93Bj6Gowt88bWszXbjGol1ZbdzbGebh8wccTKx9xN99yZs7pNw2/UnCiH4+uvKoGxDFyzmffpihn9QvmfOA/4m3F1JbV/kuARXbjsn6e88qKSwPlf/YGyqPUCLjMyawxGs87JdwNac6Ee9nhZhyOwyzbgSK0BGun3rtENQrB8k6SAw8EQdUtboXczwCNboyPfjD4XgJRfneEEDFPM1Cx9S32WmkeStwcuSvUdpDfxcyYlbqdVunwFOARnQKYG0/gLRwCYTJoRhIePB9xRGyR2h6BI2+0/KEVkVpak5cSYYMQ1xAL2ljkOpRRWYcwIUOz9M+bgqvcfxzRFlSRMmQJCddN1kyjIhV52x4ZA5PllfLxt+cmm/LKKHPUFaOaqqKX6dRoM2BoSIte3/9vyLJ+ZgABNjNHCaPpF6brZzojZayjnqSIirCTC7hDHKhl/ii9z3NeDa7KHP1RUnr0pIaT9UeppeiMOsftT7u4mWaQyx5vpLxC8u2pPPUWXqaTfCnkuhoTPvaMaxsYrgmTFEJfzNtk90THWzl5ulxc7U+og9TEXqlZn5dCq1Ojd1gl5Vysnj4M5Bw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUXPR02MB9336.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qejOmHBXqVGkbPtY5Y1Romh1xWU9/TwSZESQ7imsqDLCW8JYZdYkSeVzOPQP?=
 =?us-ascii?Q?X6GJ8fmMMIqNdwb9l4VcMMh7lW1u4JUW90T/j25ZpYUKWb+uUhhm1nS6DBaO?=
 =?us-ascii?Q?NAyjlXmluSGekULt6kx9z0/jvPb6C65gBoewRUBfWfp3v+y9yqWzN/+xhe28?=
 =?us-ascii?Q?9RkhokK664uu+VQo3iMIu1HOg0JXhFjpJLpWDQjc2cP1ySocH1cRPOW8/NPi?=
 =?us-ascii?Q?Olk8evkjjJm2pB00770x94dVo1A1tB6AunUV4PFiaV1pEaOrnN4/b9l49N90?=
 =?us-ascii?Q?gEhQO6zC1SY8lJImpbd6GISQ79FtdH/mLaGHcRo/4CxbnLtqpxNO+wR7F6eZ?=
 =?us-ascii?Q?lLHAY5zJcQKo+PGAxMw10tuFJm35e7uOiRKHGlYcyfzxMx/bx+XtKNGUCeyu?=
 =?us-ascii?Q?y+IZB3Bn6L9+BdueSYusqR/tE2YfqzL0DjpGd7H/pDakib4NFEucmL77esWF?=
 =?us-ascii?Q?wGO9y34E0qhd48/U1M4HtlIc0v/nkebe4oI9xOuIn/BiLGTTJayBzTusEr3V?=
 =?us-ascii?Q?U8pNTz0klqu6tX2xX+51MqGTbBRSdt87h87y+M676Bz3bR3JLbja5cnAC4Ve?=
 =?us-ascii?Q?d7klEoZyRNSwUIjcVDQa4jXZ4w0Yd3ySkaA5K22iIW1ha6AIvdexmuM83DeY?=
 =?us-ascii?Q?4QrIny48T28Wk2qHVkbSV7n8AP+wLSQ2kjLGNGl9eNj1wMBEaeZkRw87O/70?=
 =?us-ascii?Q?TxBBUVE8DEGJhFE8CYqdoj8Tn/ZXWbrm3IsH+Fc6vbcv217nuj9aceeZsYMH?=
 =?us-ascii?Q?xAsnVnCmbrA4PdQ1iQi9f0Cu9GTPV+M9XdBX8eBIuGWtv2mUJE2NK+nCdnnA?=
 =?us-ascii?Q?acSHCSIcxtC8z9h0MWCLOsh7RWtlKV4gKT12ApMsyUflPXBL+W3sv4C6elLH?=
 =?us-ascii?Q?ZwO8tXM/MXoyHGUHvQf70mG2x1ZjkL0LuzF6ep2u9GfiYBa8oaGMzaug/VKA?=
 =?us-ascii?Q?ZLWbj+mIbqaOYlx5BhXhw9cQ8+N+0tv+nYPxKDTuXEFnsq2zBgAWvIuE0Ne9?=
 =?us-ascii?Q?cx6j0XmU947y1e1B5CVgSwQZAY8x5wfODdnWjSLWH85QR3vfTilcMGc+nvSh?=
 =?us-ascii?Q?p03hFqw8QWDHVlXQw9uSYgXxn4CDHCLgqL8sJOvujyLn10zynunHEKf/pKVD?=
 =?us-ascii?Q?O2YLr8H8g5cxTuZElhFsUREeLqgR7SrZsalf+tN3py/TJpXImemdSjKsB9kA?=
 =?us-ascii?Q?1Pc5I0GBfSFSjbitjR36KJ53a1QiM8a0hvYAqaMOK0LpdLDM2Q76TzVAN7dG?=
 =?us-ascii?Q?IkFVCuWzF3G/+Gf415s4MW0SEQe9hEnn8PnLpShm7myk4Yz0ZeyXVZsLt3s5?=
 =?us-ascii?Q?pz8bZq44zNKEOlw7Oa1SRBcAbqPo4FWGM9nS0EBNgbcR6rf2v/fh+o1RzYrE?=
 =?us-ascii?Q?DpGkYHhNf5265uZcJH42V4fUrsmwTI4PMbot5Xkr4a6XENVq9bKZbIE3CWyj?=
 =?us-ascii?Q?8TQN5tJ6k9ITm0QcvLP+pW41NMvNjf+jQpQ7AgogSgrGI5r75VDQKVzILKgd?=
 =?us-ascii?Q?aNM6DqHUYxx88WGLSD6gNxrK5N1AYNhoWtQy/R+rKa9fiSK6oRiY8XVFfhIq?=
 =?us-ascii?Q?bWBgXHg8TewIjkMoacLMD/Ol9Ifxw4Me/Jx0b01Az69qbAvPXYy7oVL4M34o?=
 =?us-ascii?Q?ApxtG9K9QJDrHCEs+EuFvPFrvnPxse6S7zYRmZ7zkPrKw46SC1hz3L1c7mkD?=
 =?us-ascii?Q?55+pEX9o3ZuKxALx2oip0rfDXH6VO8U7q7kMwG1HizlHIA5mnS2EAUcOAkWA?=
 =?us-ascii?Q?wZx/myneZImYiLd7Wc4Eke5IXTI64Ok=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef0dbda-0881-4109-31c1-08df1c9124da
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 12:16:24.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtvF4kxj6VDk5sgTClhfm5d8ogz+XPtmmmEur/dKG7JmlAf421JNUAfqGtMvuna4CP9d2A3OB1uCLy1sLNrafpLOcAYuUieXpYRn87toEaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5621

On Wed, Sep 23, 2026 at 09:15:08PM +0800, Yonggang Luo wrote:
> already uses fixed-width VMSTATE_* macros and does not need TARGET_LONG_BITS UINTTL helpers.
Please wrap the commit message at 76 columns.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/riscv/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index bf203bffcef..00805745fbf 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -21,7 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "system/kvm.h"
>  #include "system/tcg.h"
> -#include "migration/cpu.h"
> +#include "migration/vmstate.h"
>  #include "exec/icount.h"
>  #include "target/riscv/tcg/debug.h"
>  #ifdef CONFIG_KVM
> -- 
> 2.52.0.windows.1
> 

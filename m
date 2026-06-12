Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750138D687;
	Fri, 12 Jun 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262619; cv=fail; b=DC1ylF43V/tpk7Q41KV2Is+4tDC2RBcn6MXpQ2w+AWxHp8XtKeYbdEF98zwdawLinDq/hcS1oqgo/wfoUeFZZOwzlmHCPJNh6jp04wDSXXsZVBmpl2n9PCdW6CaB/8df/4r7suIkqxARC7r7EVef/9aiRxRcv2cNouUYQ+4fdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262619; c=relaxed/simple;
	bh=+4IdD4ypdKfhm//kH2T65RNBK+E0XWt/GDFLSES51Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkAbrEqo9uVEOwYRL8JpRoUIze9UsdMsws2RUBhle7tfpjcVptTD4svyu2U24G7Kf8gZiHErgPUnh+1y8aHEf0MDu6DtXS93rqxnHv9SasWL3b1rpFQECEESy6Y8XfK+eiyEn3HwQ4mhyW/n1c7QZEWhQ1ME87zWiE6FlrUXrYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqJWzxfe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqJWzxfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781262615; x=1812798615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+4IdD4ypdKfhm//kH2T65RNBK+E0XWt/GDFLSES51Tg=;
  b=XqJWzxfeaxy9jSMNwk9UtKNMI2vFN7GMejChEbVmsQI0acmH3Ir0P/nH
   B1ftpRpDEm3W9NadpwPsnnLagoGC6GzfnqgOBsSQ2RBWNm/qgwHbmLxC5
   x7b5uWeFqSbvvKfdI/WSBzNzYx4rgLFOnJRMrMB4P4JckEzpBRY0EyzJv
   WWCk3rxPVduXs4pllE1VVlQPEAYIqqItdamNuqobECa2azgq0gj1swLvo
   uTGvYhMBOE42a1sOrAQ7gL9SVxsHipJrPp0Gp31zEbiHjsyHaIfpglOub
   CYhoLu2shngHoh0kDC/0L3CDceRhKK5zegzizR5EBkoJIkjRjQNTLHD0P
   A==;
X-CSE-ConnectionGUID: IoYhIC9ITbipiIrx8NufzQ==
X-CSE-MsgGUID: tTjjh6o6QgqJSoxgcex59w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="107524945"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="107524945"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:14 -0700
X-CSE-ConnectionGUID: 9VmTGQLDQza8FpOm8et+pg==
X-CSE-MsgGUID: svdAykDfQDanu5vRqTeWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270840227"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:10:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 04:10:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 04:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW/Mf+Jzw0kdXxvmFE0q7I10k+9asYBFgcx1kK9pT/tF0ZBxk6xq8tLr4ObvDQheHz6lqMkJbAM4Sefbm+nSOFmBgvt3kiE16/CaVbn5IftrT6FC2QFLJC5ZHVMwZz6/s4v7w+Q1lMYAKadau8ZH/LWRYNCByTnBThMvZUOfavWtuzhYXu6xlWBgESppe9+RzsvjL5hB8zz/YA4lJSmpXXpyCM2HlNJExbtsQ9mN1vzpBnwccIn+c2Yjl0tWXqahNPdOuVvestZp+aMpZLHVWkNkr4P0C4e7qAbHLXfrlmVC3p4ptbskxgMYjHKsbkmddOlVDEWuCZbRWpHKV75vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aNLYHQLJnIyY4sVu3Aq3zGfmvYbuo2MxnujrlbLQ/E=;
 b=RJcTl/39wHJ4hhiM6raL/GpnJ+lvHVf4RwT1p4pAb06PTZqu9HPvnnPmF2mX5zDwaxsmxDtjyEvvXzD0B0UcSl7p9TH/CXks/SVckiWFXD6UBixyhoy5dx/b0lBKptOA98r/MjYWlRKZA0wLM1mWGZiSu8I76/7O1SZfznViNmQxkyG/kLCn/CjxjZM2XdA9Ld/ilVobYAH/VN/vaGRf4dJuSj8RhlqgjA61k7P8ToOyHzWdhAFl9jFlDyEs3GE97pfiiWtp4I3HasbcSlfWmR0AKNI0hO57rYIl/LWpqReefFzrZtDDNJRcXYfRl7gQc4Eye9Iomq59A6k7bu/RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 11:10:02 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:10:02 +0000
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Peter Fang
	<peter.fang@intel.com>
Subject: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Date: Fri, 12 Jun 2026 04:08:48 -0700
Message-ID: <20260612110853.3188196-2-peter.fang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612110853.3188196-1-peter.fang@intel.com>
References: <20260612110853.3188196-1-peter.fang@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c07a32-c0c0-43ed-a1e4-08dec8732649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /3gweoIjZ/oSkdIEudbJmfBgg72bj2O2KX8r+ZaFzOAbs+Z3OzSyyRjqhgPbpNWaemwspNkQ4beMcTBlTZboeUHmzi3+0DS1LTaeLrsyTOx8RkJ264oKdncugB5AGVlusOigJSG5Cz1ntHcjcIpLhF2rCDQF6g+nOAXTsaXvQyH/huveYPO6u6ghTGm7PmqDkdWBBvvmsuhPovttbu7f0R9vbZ7yKigI38IxTB5SxidWZmAxROnfoVOhP+VBfjDuKXEds9b0kb+2xLhIlv6v2GzRbFF2E3YaHmA4E4YEPqVNT4XZRnw/Mg5QgHUg6R6dBv73/804dYuh5ow6xZGWOlRmI5X/klwNPwMZ+OOVHsnSVM9jOqKD1widDCEqNGG+9LMvUuM5sojqyZdl6750/E9FwLTllGxXhie0pZPaKJjiRnajmL1EYufQcNC1/DUfG7UioHe59YwBlNSDNFqiy3ewUpAOvtQNsmRHUCpoxlNP4Bw4Aje6CBfjV+WBOhyza68H01lNocP+7jq9gRhTx/zD4QQ3zMritthfU2ZGel+gjyzl2qEXtX8o4N67wPzaeHF2gnoTQjsHOlxB0tIFY+CKSyNdcbDULkTFiBUHwgSgoytoGy0bptbhPipPbbFQk/63UGU1C18Y2EPMwZ2K31eDxT9jvSACOtt2UGlmcFVJ1Nd6SHk2c0wWdy1U6Krn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/lR3GfAm552r5GEqTmtJC18fjVkgszCiQT8ND47Ph9K2OrHxxLRdR9YYuHA?=
 =?us-ascii?Q?xJ+vbtIdxNec9MexxE/K2GXWZEKnAjD11GGK/wTuggg4BP9WowqY53vhmSW8?=
 =?us-ascii?Q?hnRjCc+zBVDaU6gQ+LDlwBZEtBbYP3Latp/zedkJvieiRmEfj/21IvGtKlf5?=
 =?us-ascii?Q?oKDxzlwHRKBWM2O51WY8KFmo6aIAqueuanE6/Y7NLoECr0bhkBkXCQPd73Ww?=
 =?us-ascii?Q?tN6LSer8ff8z/l5vlQ0Wd3cBaH6gEy1QS3YNddW87c3lw67OS44iUtugXb4g?=
 =?us-ascii?Q?ZAlrtjd3A/V47k3UE8u0GnwEDlhjQ1nCXpz7aN3nk1L+LPOhE6zo+jIq5c14?=
 =?us-ascii?Q?MjU+yVaVCRMw0BItBfUh7I73V08Pa2q5yzvOL1zZlN6MMg6B4JqMzASLt9jv?=
 =?us-ascii?Q?zwMNIClRlCp8aqIUndnEkXgbHF+3igHWjYylz5WcEl9uVorexeNsso1R+JCB?=
 =?us-ascii?Q?0LbYSaGzwLpqLUSLtgywmXsMurckOvsEeexAJH7WMkvVsWJ35dwlGf1zt2cw?=
 =?us-ascii?Q?XmCtjVIV+p5cLsh6ocHQ7igTaqlXsTJGMtrDTzzjPKB8ZtgyGIH+rZaEl/Lv?=
 =?us-ascii?Q?zn72S1qW8ay9VFP7H5n3eObJ8yiaMEmx+c2Ch2fyzh/1QbUiTtkDaYCDoXq+?=
 =?us-ascii?Q?kNw+vwxLQNJN/skeA1d0t4ZtxI0CipsX9ID+2XbPD/f7OL4uCcMc3JIgXCC4?=
 =?us-ascii?Q?c5j83nuoZcZzsgQk3hD7m/TAL6iHH053/7GlHQT7SjR8+kKXbpfvHRg3opGZ?=
 =?us-ascii?Q?mGoMjvXXsgykbxKarif7lh/gVxz50Mea3FYdrG+RRx4he/2na7/Zl6A/cFT0?=
 =?us-ascii?Q?ETfY2KUW2c7M8EKj/W0DSBiU3cYQAzj0fKsj6h7YXRReuVNxKkY5mbKZJtOq?=
 =?us-ascii?Q?4qepSEoU5+QqGtNpglseliFj3iF5nbpwMrWRsmtX3FMZIRVrDcdKGiCulPMV?=
 =?us-ascii?Q?XPIlCDYG9+uuHRuzNNgKLoNCNPVoUZGYA/8qbxQB9ne1aVgamVt+IuJ3DtBE?=
 =?us-ascii?Q?NQfw6RJwvq5DONJqq1Q9xYsjcp/NH9235SfDc4+Em2dRutsZzdWQq0tqvHIl?=
 =?us-ascii?Q?vg9cIHphhZpyhD8692qwyOPAYkNH7u/ezBF6E+UbWIhxk1Ts+VxNfRZHaqIi?=
 =?us-ascii?Q?WG4aKHwTwnAvRz4w9ThS1LczbK0CwtYDmHSkoeLO+X5n0WsvAUEWch1zQjj4?=
 =?us-ascii?Q?KroiNlN7JKoDcF7hux2Ad/BbQ+nhlNuKc2ymftAF/ye7V8bc0AQq2sZLHkJg?=
 =?us-ascii?Q?O+ow9Ps1gjDxMv600UUx2HvSTRZxEYe0/dU4kR532rSJpRnpjaTYW/6Q2k4w?=
 =?us-ascii?Q?ukKjtQoELtGqtE4fMTWcYBKxPP3WJchVjEZ1l2rqr67+ZMMxoithBorJDpSI?=
 =?us-ascii?Q?o2wIwmg2OJSIPTTtp4PSPpbUalL9gTdlNR0he/CKOUj0erQ2RnMb/phkekAj?=
 =?us-ascii?Q?Nv5YB0e6YmiIKB8ITJkxmP1nsC2nB4cX9KoRw9cPKTGEELQJsV5dnKV3huuC?=
 =?us-ascii?Q?6ZQPCcpUjo47b+jDC08ivEvpLyLZeRCrUHu1N5EenCPCvRv8/uSQylJttj5V?=
 =?us-ascii?Q?+h5vncJSO1Cn8IoKF7jShbQwX9MgBF3BdG8VFOMv4OSQX/xNXdUaMzAuKURV?=
 =?us-ascii?Q?NAq1tX9R/Fp3XKlb1yor+kbqBmO9uV1vUp66mEtHSZE/0WlozYfe/dyMdv1J?=
 =?us-ascii?Q?ThUdztWK/1PdTfplAJKdpvF6kuXu/F+bWNmEhUbnfCELzcu37U/NbGPkx9PR?=
 =?us-ascii?Q?Dk0qAl3CAQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: GmF5AlP6bblnDoGxZun2sp9OcZa6oXY8Gt4uXc5zfrm0HN8UdAtez6GAjIL/JRm1dYs9TDeoNjZq/WmIYJ2ZPAS4x1k1wyAwL8TBy3dCaDYoe7O1g+N5mTHvoxbCN8QwPi85CtHSyHAS0aF7OkHgokh2VJOK5gj9l/9knAbhsCDfPzK3/cRBwWnUGdjPEfcMXQAmhh1/dWwUv1+X/0A8djglLYkzzpSf6bvv7C4mGu9wVFI+K9OW+VoNytrkgBf2hDLzF9rnwkeTd+fYddW1fkZBaAD6ga299tf02Usg4j4kAE/pmKeyqOqqrMTNX5UaT73ebrBuVaBnuTTwWOi4zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c07a32-c0c0-43ed-a1e4-08dec8732649
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:10:02.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15HWJ0h7S89DRTnV14T2oe/3ZKz7NdYf3cKBzcNiREhsIvkp1pLfSKPcrqozJDUwM7CgowUj8J7n25PWVM/JOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com

TDX attestation blob ("TD Quote") sizes can grow with newer
cryptographic schemes, so guests can no longer rely on a fixed-size
buffer for the Quote.

Newer TDX modules report the maximum TD Quote size via a TD-scope
metadata field. Add a helper to query it instead of exposing tdg_vm_rd()
directly, as it can read arbitrary metadata fields.

Thanks to Xu Yilun for suggesting this.

Assisted-by: Claude:claude-opus-4-7
Assisted-by: GitHub Copilot:gpt-5.4
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..88c66c46e70a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -197,6 +197,25 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/**
+ * tdx_get_max_quote_size() - Get the maximum TD Quote size
+ *
+ * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
+ * guest driver uses it to size the buffer for Quote retrieval. Older TDX
+ * modules do not support this field and return an error.
+ *
+ * Return: Maximum Quote size in bytes on success, or 0 on failure.
+ */
+u32 tdx_get_max_quote_size(void)
+{
+	u64 val, ret;
+
+	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
+
+	return ret ? 0 : (u32)val;
+}
+EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
+
 static void __noreturn tdx_panic(const char *msg)
 {
 	struct tdx_module_args args = {
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 049638e3da74..2880f493a8e5 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -49,6 +49,7 @@
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
+#define TDCS_QUOTE_MAX_SIZE		0x9010000200000008
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
 #define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a149740b24e8..ac39674c9479 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,6 +72,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+u32 tdx_get_max_quote_size(void);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
-- 
2.53.0


Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062E2D9EE7
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943122; cv=none; b=GkkL87fL7hTeO9ilIgBZwxggzAKgtaV6NUpBxd8DNwRbq3uLV+HwE/hMFRF6YOJ/wpGlELftpWBOb42NgN3PlcnRigWEy7ME09uvc851+CH+tWEYkWjQAxSUjo1iSsvl42PqnsqMUQv1olut+x6ot48HHdSJ+DVQDDYOv7kkJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943122; c=relaxed/simple;
	bh=15p6TXVpbKwrNFtVOskJ2GtZPDhMsnpU5Wh4o2UEpMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbqaDsq+LGvvYdsi2LtJQxGezSltAMpZ+i+y073i97BbF4fAo66kdIFAfikFJ/KV6+6IhQJzPFJP4X70ndf/0TxyWkrmVNqsdpj3DAE3YL+dnf+8phDJvF549o1KOwfxwGgoXQ5Qf+Q9in4Kxe4hT6ZLWisGkkZgWEX2WafiWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GQ3n2byY; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GQ3n2byY"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b9d8056d2so435873f8f.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790943119; x=1791547919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6kEmu3YDcoMJ8yl0SlAKy2tL2zLnfmMhg9lEydpAegs=;
        b=GQ3n2byY7ggX+FQg8pTq8IUS9G5O7JeIZDjKTd8Ne5ghdIz7E0uFixE4Q3uF3wo60t
         Gu9qguKjRYpUNr8BW8Rb0exJKcabTWSnR2kjqQWFJls4RHG3UGrBpYvvK8EA5ppAs4H8
         AZnKPLyP/HV2T8kKgMGPIZIJK4rWSHwkzVAQ0XZ/TEKXF/o9kRzj4tlH7AUElxcWiWgm
         HhqkW9naIuH+D+4GkpFhlj6Dg1JdDsl1u+osUqo1/ut9R49/QJZXnfAx+DRaxKJrNRZn
         CW6F1b7WKwQACqu0Gv5DiQEU9x7wgN8/qLhpKFL6jhBtoWOPq60484riW516NIfcicDD
         /Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790943119; x=1791547919;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6kEmu3YDcoMJ8yl0SlAKy2tL2zLnfmMhg9lEydpAegs=;
        b=Y18PlbjUSb354js68KPC/qSS34n6YCM94+CUOfLi2d3puFShIxw9iLgZJqEiRtLz/M
         TvqCWTNU1WfZ2q364UhFnFGigJrXfb3reWl8oppF7FBNoRgCq8fbFUsl/4WUW5EnSfE2
         faXQuLw7Ij1YvkbaDVPAQjXYI8Awa6uN9kpkylMg5oncpT2scOxM30Ll5aB5uB36v6Xa
         dO/NvPLbcw8VJmX72PhRynF5wmwDE3TTCv77BVdHFOsu+NxDnvfv2vO6s3QF89nPbDKz
         MN6Vz6nWvJHGky5PsF2UYt7MSV6WaT8fxrb1u97Hoqoh5wFGT9LBJVpGskvrtBbyv7G9
         7bCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxarr/UFF/ouGMGlKX6Nd9+AT6dlQexK837fhrgcY6WFCwCATIAhPlwL2HJDakwQV8GwQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTTkeuPnfzb99V2Ve8VyWRHAweaQKP1UfJHz/NyVdQQX15HERq
	tJHp5eulaUeHcPxP3AGOZt45Ja/0Cf9ShnLUq0p1mEXKumFO+rkVqMaGoo1gYO8aS/mUrLLx/lY
	jTVlzxfU=
X-Gm-Gg: AYBFou0hdGyqD8SSzuLtKxYvZgYVQlAMLX5z0MqzljR04nXihL3rW6zyp/geItLAPB2
	+QLh3grj3CM+PsNw1Fb/LOCOuruky8vOJcUBzGNViV2y0nm+mWTfNHE2zmWg74rbXGmxFTFw2WX
	Z5ME+ejzQGSw9ql9WXljK+illI4vtFBmtfq/jS0W8pUohyr/aUHZL805R5O7Y7zI7WMDA94LjKh
	iF3GSIEWoRjbLgx2D8xiPA8OHPnZcoRqNUsBaRpCJmftBCHw0X49QMKHLDgS5QlSFmBSrHKJzZK
	wQ6sBLxCjaTFx4q6ZRk5YmH301ddnYXifR4FuZml7WLRJrFBJvnTnfup5dfPc2AdZGSEZdNZR7X
	J1TJzKKFRfWtKvw6WbX2iJxli6cdf2CAYPUSUDOjsvtEMCqT8591O2/9m21FYys4fJb9KxpMmov
	yLAZbuO5ye6cdeNZS3YK14LxgGxNk9I3c/TMrvrMUJQD7KtW3/kO1g5yMFFuY6ZIgxJfqyjquBt
	VAGU4z6LNNupufzFyYnsxw=
X-Received: by 2002:a5d:55ca:0:b0:48b:10c8:2180 with SMTP id ffacd0b85a97d-48b1274a617mr3238654f8f.33.1790943118936;
        Fri, 02 Oct 2026 05:11:58 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0ab7sm5298748f8f.7.2026.10.02.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 05:11:58 -0700 (PDT)
Message-ID: <2dabd129-5f44-4a45-b8a2-b1ea6894f85b@suse.com>
Date: Fri, 2 Oct 2026 15:11:56 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
To: Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 yilun.xu@linux.intel.com, binbin.wu@linux.intel.com,
 tony.lindgren@linux.intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-3-chao.gao@intel.com>
 <5fe666c8-55ad-4f06-b853-a532d73c35be@suse.com>
 <824738e9-ff22-45b2-b7ee-b9dc86d1686f@intel.com> <ar-e8WzRS7IUKWgH@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <ar-e8WzRS7IUKWgH@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.10.26 г. 15:09 ч., Chao Gao wrote:
> On Thu, Oct 01, 2026 at 09:27:57AM -0700, Dave Hansen wrote:
>> On 10/1/26 09:24, Nikolay Borisov wrote:
>>> nit: I personally dislike adding this level of indirection, albeit
>>> rather shallow just so you don't have to repeat 'struct xxxx' in every
>>> TDX_SYS_INFO_MAP. Same goes for the rest of the patches. In the past I
>>> remember TDX code also suffered from, in my opinion, excessive macro
>>> nesting.
>>>
>>> Dave, what's your take on this?
>>>
>>>> +
>>>> +static const struct field_mapping version_mappings[] = {
>>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
>>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
>>>> +    TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
>>>> +};
>>
>> I'm kinda ambivalent on it. The width of the structure doesn't really
>> matter much. It's readable either way and it's already got *PLENTY* of
>> duplicate gunk in it.
>>
>> I'd try to remove the macro, and make sure the structure definition
>> doesn't get too icky.
> 
> OK, I will remove the per-structure macros. I would also rename
> TDX_SYSINFO_MAP() to FIELD_MAP(), which keeps the table definitions
> within 100 columns apart from MAX_RESERVED_PER_TDMR and
> PAMT_PAGE_BITMAP_ENTRY_BITS.
> 
> static const struct field_mapping version_mappings[] = {
> 	FIELD_MAP(TDX_FIELD_MINOR_VERSION,	struct tdx_sys_info_version, minor_version),
> 	FIELD_MAP(TDX_FIELD_MAJOR_VERSION,	struct tdx_sys_info_version, major_version),
> 	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	struct tdx_sys_info_version, update_version),
> };
> 
> static const struct field_mapping feature_mappings[] __initconst = {
> 	FIELD_MAP(TDX_FIELD_TDX_FEATURES0, struct tdx_sys_info_features, tdx_features0),
> };
> 
> static const struct field_mapping tdmr_mappings[] __initconst = {
> 	FIELD_MAP(TDX_FIELD_MAX_TDMRS,		struct tdx_sys_info_tdmr, max_tdmrs),
> 	FIELD_MAP(TDX_FIELD_PAMT_4K_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_4k_entry_size),
> 	FIELD_MAP(TDX_FIELD_PAMT_2M_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_2m_entry_size),
> 	FIELD_MAP(TDX_FIELD_PAMT_1G_ENTRY_SIZE,	struct tdx_sys_info_tdmr, pamt_1g_entry_size),
> 	FIELD_MAP(TDX_FIELD_MAX_RESERVED_PER_TDMR, struct tdx_sys_info_tdmr,
> 		  max_reserved_per_tdmr),
> };
> 
> static const struct field_mapping dpamt_mappings[] __initconst = {
> 	FIELD_MAP(TDX_FIELD_PAMT_PAGE_BITMAP_ENTRY_BITS, struct tdx_sys_info_tdmr,
> 		  pamt_page_bitmap_entry_bits),
> };
> 
> static const struct field_mapping td_ctrl_mappings[] __initconst = {
> 	FIELD_MAP(TDX_FIELD_TDR_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdr_base_size),
> 	FIELD_MAP(TDX_FIELD_TDCS_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdcs_base_size),
> 	FIELD_MAP(TDX_FIELD_TDVPS_BASE_SIZE,	struct tdx_sys_info_td_ctrl, tdvps_base_size),
> };
> 
> static const struct field_mapping handoff_mappings[] = {
> 	FIELD_MAP(TDX_FIELD_MODULE_HV, struct tdx_sys_info_handoff, module_hv),
> };
> 
> static const struct field_mapping td_conf_mappings[] __initconst = {
> 	FIELD_MAP(TDX_FIELD_ATTRIBUTES_FIXED0,	struct tdx_sys_info_td_conf, attributes_fixed0),
> 	FIELD_MAP(TDX_FIELD_ATTRIBUTES_FIXED1,	struct tdx_sys_info_td_conf, attributes_fixed1),
> 	FIELD_MAP(TDX_FIELD_XFAM_FIXED0,	struct tdx_sys_info_td_conf, xfam_fixed0),
> 	FIELD_MAP(TDX_FIELD_XFAM_FIXED1,	struct tdx_sys_info_td_conf, xfam_fixed1),
> 	FIELD_MAP(TDX_FIELD_NUM_CPUID_CONFIG,	struct tdx_sys_info_td_conf, num_cpuid_config),
> 	FIELD_MAP(TDX_FIELD_MAX_VCPUS_PER_TD,	struct tdx_sys_info_td_conf, max_vcpus_per_td),
> };
> 


Looks good, and FIELD_MAP is generic enough.

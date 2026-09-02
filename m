Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D322541C
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308409; cv=none; b=ZGGrn4F8B17wycxicg+MexNvL3GVGxNK9miepTFAGo4GMUkeZ8k+tXFBuoadvBeeWJqp002ZF0uyjVA6EbGI43+rvReFnrYpCPPfORsrrt/uVGjaa0hpsQ94gVP8pL3T97HZQYEGs4IBjETYYMT80+u6rsTFgmXRuFASi0BSCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308409; c=relaxed/simple;
	bh=BXRcOixdMzXQLW85aUU4Wf/qtNPkoLSWJYkLfRBdgIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O4bu3aGwKTvQP3ORqqmmnY0Fh5F3c2sPRtI9PQHncevQ+41RzLplR+6HM2RangY9xTN/Zc/MKtNTHqKfxLPbSzUIAncewBXvgdne/wfp+126UsnIB0cKEfS6Bs9Ug6UrPHoucs/zPyp/EFKQKA6QTiMKjd13PrUOk1U3U+WPzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGyIGDlg; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGyIGDlg"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7443e0f0bso5940865ad.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788308407; x=1788913207; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSeD0zkw5d62oYTgpl5Wd4yc4wNF2jb8Exvm2SVVImE=;
        b=EGyIGDlgDWZrrSLSvNuT/1WXenJlnWO5SjMinOZ8UbwqKh01OpqSgOrgeJ5Tlqt/Jo
         t/gTxRsVi6C4GGTDumBLIg+LC7MSbRYijzaYmB6sYehrhASarUYnQHVvhMf2k1Z96+zY
         jH3zGfhrwB34nraqZszxU5Zw6lchIL+WturKcKbzioZdWI7qU8eF4AQI3X83aGOb60jC
         2XbhzHfnuSUpV4OcjH67MTaubQ4jXl119tB05S6lHicEjLfTQCmlrCHdGowuxaDDKWnl
         x0L9hMhhTkqanqO4gWlwnRwxfw0wbgNE3bSRRdyxXIZMIThivqJ/LP0K5pLaE5Y7q6u9
         PvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788308407; x=1788913207;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BSeD0zkw5d62oYTgpl5Wd4yc4wNF2jb8Exvm2SVVImE=;
        b=e0hBAFt+uSPeNuecJu7cKSqALxyufj/jyQ8sKImW9saxR2AbGejqwCHze8tGPohCb9
         i6FjJbOA6LFjc84Sl+PBvx6L7AlKt12D2Mh4JZDvwabRiGlTNY+VtllVrv/7q0VreS7x
         nEKnGvjFh3H56dnYIlEO+INd0cvoklqbQNqKygCbuCsWjJ2HMVdlXO/x/P4pQV+hN361
         hv/1wp6eYJzG4G3v+yUU88U1So22sx+F1O3LCcIOpreSZhk69yAho6ZJ40pFPMw0KCRX
         pxFmSmBGU66/+p/M0bQlqkCLO8CBV4T1Ho9gn6bHPSBFVgXB7VZN3bJhDvnhzT+Kjpee
         zeHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwgp+CwnpYbkp1IETbd21GWURBwMBNAV9CpG6RXFW8ZAlMNXbI7cHpwhkj5bKBvDhd9uI=@vger.kernel.org
X-Gm-Message-State: AFuF++mOZFcFyJop6n92gRr+A0jkWxLn+Akamooas3BkBBoeT3k4y+1m
	5REc/Z2nEJYmc/xIT2F6zMS4DXfL0xq09p9VG4iYF6dLiD3HUSjgQ1jbNlSO7B1V03pwatCCGPP
	nUdH9Bw==
X-Received: from pgco28.prod.google.com ([2002:a63:731c:0:b0:cbe:dc75:c58e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e787:b0:2d9:4358:73ab
 with SMTP id d9443c01a7336-2daec775fd0mr16568335ad.19.1788308407429; Tue, 01
 Sep 2026 17:20:07 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:20:06 -0700
In-Reply-To: <20260730110524.2539316-8-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com> <20260730110524.2539316-8-ewanhai-oc@zhaoxin.com>
Message-ID: <apdrtnMGJN7K0wRa@google.com>
Subject: Re: [PATCH 7/8] KVM: selftests: nested_exceptions_test: Add Zhaoxin
 CPU support
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, Ewan Hai-oc wrote:
> From: Frank Zhu <frankzhu@zhaoxin.com>
> 
> In the test, the ERROR_CODE_EXT_FLAG bit should not be set in the #GP
> error code on Zhaoxin CPUs.

Why not?

> Add GP_ERROR_CODE_ZX and use it when > running on Zhaoxin hardware.
> 
> Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  tools/testing/selftests/kvm/x86/nested_exceptions_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> index aeec3121c8e8..bacbbdc5dc69 100644
> --- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> @@ -38,6 +38,7 @@
>   */
>  #define GP_ERROR_CODE_AMD ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
>  #define GP_ERROR_CODE_INTEL ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG | ERROR_CODE_EXT_FLAG)
> +#define GP_ERROR_CODE_ZX ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
>  
>  /*
>   * Intel and AMD both shove '0' into the error code on #DF, regardless of what
> @@ -139,7 +140,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
>  	 */
>  	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF), 0);
>  	vmx_run_l2(l2_ss_pending_test, SS_VECTOR, (u16)SS_ERROR_CODE);
> -	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR, GP_ERROR_CODE_INTEL);
> +	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
> +		   host_cpu_is_zx ? GP_ERROR_CODE_ZX : GP_ERROR_CODE_INTEL);
>  
>  	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF), 0);
>  	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
> -- 
> 2.34.1
> 
> 

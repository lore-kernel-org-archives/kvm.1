Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85224E016;
	Thu, 10 Sep 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040458; cv=none; b=kHUYKFMsY9qYCp3dPdPP2JdDhnsuE2ibm40b+Y9xqXNTTbNVzjfjAufWKADHTYXOn1uSB9xgtTWNG52qADgOUQsTFDW1+ovQwbLrlorFDmJnH4NLhpjavK8W7L/ijG1OIGtrlNTyuhyv8H97XgHwX46mnZ/IF5j/eSvOEKDHsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040458; c=relaxed/simple;
	bh=bKtcY9FT7Pxi1rnMqFGg49+LTjkWx+VDrxDMUvSLsj4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcP6pbF2FcJb+2DjiPyC5wC2AuHn8ss2LY2m0sjNYmkGKQUYaR0e8SIM86TV7k5bGrLGLIU18CIjdy6azjc38f5xPtyVJs/eCsGRhz3QmPJw4l1kHWBcaeencAjbUwIj7W+YV2n+tGad1dEpnPzQ/E3Hd2Px+paa5Vj/6mM1X7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbN36tFTzb0tj9;
	Thu, 10 Sep 2026 19:40:51 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbN15Lmfzb0tj9;
	Thu, 10 Sep 2026 19:40:49 +0800 (CST)
Received: from ewan-server (ewan-server [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP8faebb235c4cc3404a7e47455dc250e2
	Thu, 10 Sep 2026 19:40:48 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Thu, 10 Sep 2026 19:40:47 +0800
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH 7/8] KVM: selftests: nested_exceptions_test: Add Zhaoxin
 CPU support
Message-ID: <aqKW7ls1KpdsCxdN@ewan-server>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
 <20260730110524.2539316-8-ewanhai-oc@zhaoxin.com>
 <apdrtnMGJN7K0wRa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdrtnMGJN7K0wRa@google.com>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

On Tue, Sep 01, 2026 at 05:20:06PM -0700, Sean Christopherson wrote:
> On Thu, Jul 30, 2026, Ewan Hai-oc wrote:
> > From: Frank Zhu <frankzhu@zhaoxin.com>
> > 
> > In the test, the ERROR_CODE_EXT_FLAG bit should not be set in the #GP
> > error code on Zhaoxin CPUs.
> 
> Why not?

We confirmed with the Zhaoxin hardware team that EXT is set only during
interrupt delivery and for the following guest-mode events: ICEBP, #MC,
#BR, #UD, #NM, #DB, and #MF.

In this test, #GP is generated while vectoring an injected #SS through
an empty IDT. Since #SS delivery is not one of the cases that sets EXT
on Zhaoxin CPUs, EXT remains clear and the resulting error code is 0x62.
We observed this behavior on the Zhaoxin system used to test the series.

This explanation is included in patch 8's description in v2.

> 
> > Add GP_ERROR_CODE_ZX and use it when > running on Zhaoxin hardware.
> > 
> > Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
> > Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> > ---
> >  tools/testing/selftests/kvm/x86/nested_exceptions_test.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> > index aeec3121c8e8..bacbbdc5dc69 100644
> > --- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> > +++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
> > @@ -38,6 +38,7 @@
> >   */
> >  #define GP_ERROR_CODE_AMD ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
> >  #define GP_ERROR_CODE_INTEL ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG | ERROR_CODE_EXT_FLAG)
> > +#define GP_ERROR_CODE_ZX ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
> >  
> >  /*
> >   * Intel and AMD both shove '0' into the error code on #DF, regardless of what
> > @@ -139,7 +140,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
> >  	 */
> >  	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF), 0);
> >  	vmx_run_l2(l2_ss_pending_test, SS_VECTOR, (u16)SS_ERROR_CODE);
> > -	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR, GP_ERROR_CODE_INTEL);
> > +	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
> > +		   host_cpu_is_zx ? GP_ERROR_CODE_ZX : GP_ERROR_CODE_INTEL);
> >  
> >  	GUEST_ASSERT_EQ(vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF), 0);
> >  	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
> > -- 
> > 2.34.1
> > 
> > 
> 


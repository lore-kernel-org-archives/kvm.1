Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FE3839B8
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375461; cv=none; b=oJL8fOsZDwxgxX++KyuE7vZud1jEMvvqd00IjimcOAViLKqbgc78hDjCM4I052X5qGMk1oG/Wv+qsL49d0kH/0zMRywg2SfVPlzLBfWN5BwClS3KmJiZIsSetwikQ/XPYeb7OjobqLo3tU3CGkhfWDtTs0MCtKJr/XYMPam2Aeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375461; c=relaxed/simple;
	bh=XUSUhEOD3AEeGMVWCzAc7D3WvLTYGb4Xl/pLG2PkS84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p30PgLKMPC8OLz8C7zAHMqa3AsGwXAVMcLX+ECXH9F+dR5ScYaApMsWfTPOO7Z4Z0i2tDEMI/iSRpZWHIIS9IRY7nsO98mkgfG9xCPmbiQ47KLlMoknp+K3GAhUJXpXCrfpGBVZCIGSBxDjzBUo4C6KG4wwEH7niccuLAdEVj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCh+qqJX; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCh+qqJX"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d292eac1so2891343a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788375459; x=1788980259; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOJWvn9jFBquFoGU/4Ofg6TSnCdV5OfffuxmIvMHBKs=;
        b=wCh+qqJX6L+TvzOPEYyBfjpJMW1blxscnIYc4E+JP2ybsGhAkt5QJ2T+0MMkffgf1+
         7kCyne5nWeiZhgu2XpZh8WHqrMh06/ZvoTxc9PUuzXa+aIjzbTHLnn9MNsFIzw8KeUlu
         6pZ+MBwldG5J1UzCux7U325GbQkSDXBEjPK9+V4aTs50Ic3N8L2Bi5B0IPMBdewn9a08
         I2wbIUzi6O5hSaWOvjY3BkIngikZPnHyGhjn7hwbHT456v5G7ZFw7GyxpOoJWDdn1eLn
         QP7mzXw/5khX+o8mRDM3mBpILWg4QuVpCbzKTE5bpnaTGpMxZsOeRn7BFWtDEWVzjsII
         1WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375459; x=1788980259;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOJWvn9jFBquFoGU/4Ofg6TSnCdV5OfffuxmIvMHBKs=;
        b=pluvU5ho9HBJuezwWouYufQRgJ+P04E6KRwl0KbizB/fB7Y9OeUfn2kFw+ouCCdyjQ
         2PTAj8H+xIKsIfiNZbZHidbyxIHliValaEzhqaDiV3lBM1uLja3X5U2TeytjTuAxvR2F
         xXBtK0uvHjWeG4XAL0t5CzMgZlIUkrel+VHxGciYJCLRSLwdDLih+BFqJrf2IroB60HG
         3eqK53BsMfkF5eI3Oz+yVSAL/SK97qcJXa+LHxuj/yVxG6V3EJOCYSfimhX3h5Jan6pm
         AErI/Y42KxTchDBQ7DzBSG9T9/drKDDlC16Vb062oQHq2W8ZndwWriWccTOGGJBFAPvo
         BJnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAYNeRmW+qH6BWD5Hcu+K/CmHG7wJXZhQvN3KdYXde0Qg9gKMWpFdmij2e1PwZAnDOw/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mQyMA0ftrILgg4QaZqbV2ToyMfwTj5sr8FQ28W2qfhmm7hTDi7
	asxIvxyNNb6zTUzCo2z+pwdolgjb0hHTaYN4rmqfFdoGNr9udi78OmMXqaPvTmjfIaoMg5P4nOQ
	YYAOrow==
X-Received: from pjbpx8.prod.google.com ([2002:a17:90b:2708:b0:398:d843:cae4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da83:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-39aedfb8f16mr11014152a91.9.1788375458987; Wed, 02
 Sep 2026 11:57:38 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:57:38 -0700
In-Reply-To: <586448da19d357ac6914fe100e5f09f22c5c9de8.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831213632.81023-1-dwmw2@infradead.org> <20260831213632.81023-2-dwmw2@infradead.org>
 <3590c47d-302a-4a24-9953-828eb9b38c38@xen.org> <586448da19d357ac6914fe100e5f09f22c5c9de8.camel@infradead.org>
Message-ID: <aphxoidZsbyoNEN0@google.com>
Subject: Re: [PATCH v3 01/13] KVM: x86/xen: Rename 'longmode' to 'is_64bit' in
 hypercall handling
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <xadimgnik@gmail.com>, pbonzini@redhat.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, ankur.a.arora@oracle.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	x86@kernel.org, syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com, 
	nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, David Woodhouse wrote:
> On Wed, 2026-09-02 at 13:18 +0100, Paul Durrant wrote:
> > On 31/08/2026 22:26, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > 
> > > Rename the local 'longmode' variable and function parameter to
> > > 'is_64bit' throughout the Xen hypercall handling code. This
> > > distinguishes it from the VM-wide kvm->arch.xen.long_mode which
> > > represents the Xen shared_info layout mode.
> > > 
> > > The 'is_64bit' parameter indicates whether the vCPU was in 64-bit
> > > mode when it made the hypercall, which determines how to parse the
> > > hypercall arguments. The UAPI field name (vcpu->run->xen.u.hcall.longmode)
> > > is unchanged.
> > > 
> > 
> > Given that 'longmode' is the term used in the UAPI I'm not sure I really 
> > see the point in this change (particularly since there is not even a 
> > name clash with 'long_mode').
> 
> The difference between 'longmode' and 'long_mode' is subtle, and *has*
> caused confusion which IIRC is what led to part of this series.
> 
> Having to keep 'longmode' in the UAPI for KVM_EXIT_XEN_HCALL is sad,
> but at least the context is very clear there (xen.u.hcall.longmode).

We can actually "fix" that, if we want.  And given that the only "longmode"
reference left in KVM is one in kvm_hv_hypercall_set_result() that can and should
be nuked, I think it make sense to purge longmode from KVM's source.

We already did something very similar in e65733b5c59a ("KVM: x86: Redefine 'longmode'
as a flag for KVM_EXIT_HYPERCALL").  And if we expose both names to userspace, we can
even purge the misleading name from selftests without forcing existing VMMs to
rebuild.

E.g. (completely untested)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 718396340d3c..043a61e2409d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1804,7 +1804,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 handle_in_userspace:
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
-	vcpu->run->xen.u.hcall.longmode = is_64bit;
+	vcpu->run->xen.u.hcall.is_64bit = is_64bit;
 	vcpu->run->xen.u.hcall.cpl = cpl;
 	vcpu->run->xen.u.hcall.input = input;
 	vcpu->run->xen.u.hcall.params[0] = params[0];
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9fc8dfdfd65f..5a74765732e3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -131,7 +131,12 @@ struct kvm_xen_exit {
 	__u32 type;
 	union {
 		struct {
-			__u32 longmode;
+			union {
+#ifndef __KERNEL__
+				__u32 longmode;
+#endif
+				__u32 is_64bit;
+			};
 			__u32 cpl;
 			__u64 input;
 			__u64 result;
diff --git a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
index 2585087cdf5c..702920674b57 100644
--- a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 		if (run->exit_reason == KVM_EXIT_XEN) {
 			TEST_ASSERT_EQ(run->xen.type, KVM_EXIT_XEN_HCALL);
 			TEST_ASSERT_EQ(run->xen.u.hcall.cpl, 0);
-			TEST_ASSERT_EQ(run->xen.u.hcall.longmode, 1);
+			TEST_ASSERT_EQ(run->xen.u.hcall.is_64bit, 1);
 			TEST_ASSERT_EQ(run->xen.u.hcall.input, INPUTVALUE);
 			TEST_ASSERT_EQ(run->xen.u.hcall.params[0], ARGVALUE(1));
 			TEST_ASSERT_EQ(run->xen.u.hcall.params[1], ARGVALUE(2));

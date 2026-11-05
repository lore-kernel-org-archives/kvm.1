Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845515;
	b=hYmk9A/lLCZgkBE48JIjfSL7r6xYuruGJf2+dlZkwpHY71lSGmc65VgYaGUZ3dT7J3wL
	 Eg+u7pYqHfwflKg/ShDwAGNuKUZGHevw+HO/1JAQhGzkmr4KFUElU2xENiaD6Eu6JE9p+
	 qthcjI5SP6RIBxQQC36JdOxvnQ9/i50YgzyE7rW1xU2FI6t0RRESXTgi0p9OuwF0ubP7n
	 y/QvQLmqd6wFYBpAVyuHPRSqYog4+uD+/Vq0c6Nn7m+41xdCfmCGSR8dgdqHbShuiVcQX
	 owneNMKE1L1GDVA+L2iAdVww1WudPlljxsCBlxZi2Px8vplss3t2fj5INJj3MDboMGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845515;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9tgfi0g4ooZidWYhyQMPl553l8pXXds0ehLJC86Y8L4=;
	b=SOaQq/JIW5geMNp9cqMdhQCi1WuVx9DSDKTJilRmX8jbii3BV4pIQkPbiF/fYnCsnheo
	 kPLjYBN80o3ihphEYSZjmS4bg9KNtCIe5+6ad+ejQKNC6whp8/oVJwaGk9VjVI7RnaUhx
	 mnLcDt6nN/jH0IHQjGVw8BYVQEvWFgQzyC9mMI+mL/78dGFo0GsoofOYa8T0ZuZTSluCa
	 CTY1HwWY/jSlGviDjXJd4SdjNrBPrC7eYNjETgXu5yvR2iquDC52kSgnuUtnjcA5cVGol
	 wPNR2HkxV3MtjWKiR2liHeDWPeT7lgHvHD4VSmaPuFi3DBuxMdAkDKAV7pX4kvDhwvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY+6KJHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387B606A31B;
	Thu,  5 Nov 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY+6KJHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7200C1F000C1;
	Thu,  5 Nov 2026 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845514;
	bh=9tgfi0g4ooZidWYhyQMPl553l8pXXds0ehLJC86Y8L4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kY+6KJHV852GmSzzIRQJrIDPDXsChr9I6IQELha2aAER3Z/k9Fh/OILEc4MRZFyUR
	 ZoaOhelMms0Q8oraiAANLXmYEcDq99yeU3JMgmxel7Oa0rGLDhTtgsa9PxDAiJTfB5
	 c7fcJFOov6zoPrHqiXVCZ/rgKtCoKghPtVluJCFu2JpMd4FahzZUNWavYt+SH2H/YZ
	 rBeyWj8EKJnBkEYnXzICrV78pn9xbIkdwPcvAWXIYuaqPABQZXaM8VjnGklqEcaZKc
	 6e7qiDC5Wy7KyGMxeT4gAd8oJLBlc6yqDiHWHXfPFr9i1d/RSbVv/BK5u+tJmhPb4X
	 IQmlqH3fblZzA==
Message-ID: <sashiko-outbox-198459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/20] KVM: selftests: Add nested VMX APIC cache
 invalidation test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105020104.2507083-15-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
 <20261105020104.2507083-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:25:13 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing virtualize APIC accesses check in main()
- [Medium] KVM: selftests: memslot move races with vmlaunch() and vmresume(=
) in run()
- [Medium] KVM: selftests: vmx_apic_update_test fails to verify APIC-access=
 exits
--

commit c3febf61f5d64e784b8c55b816b4a00a658a0208
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: selftests: Add nested VMX APIC cache invalidation test

This commit adds a selftest for nested VMX APIC-access page cache
invalidation while an L2 guest writes to the APIC-access page concurrently
with either madvise(MADV_DONTNEED) or memslot moves.

> diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c b/too=
ls/testing/selftests/kvm/x86/vmx_apic_update_test.c
> new file mode 100644
> index 0000000000000..357e10c88cd0a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
[ ... ]
> +static void l1_guest_code(struct vmx_pages *vmx_pages)
> +{
> +	uint32_t control, exit_reason;
> +
> +	prepare_for_vmx_operation(vmx_pages);
> +	load_vmcs(vmx_pages);
> +	prepare_vmcs(vmx_pages, l2_guest_code);
> +
> +	/* Enable APIC access */
> +	control =3D vmread(CPU_BASED_VM_EXEC_CONTROL);
> +	control |=3D CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
> +	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
> +	control =3D vmread(SECONDARY_VM_EXEC_CONTROL);
> +	control |=3D SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
> +	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
> +	vmwrite(APIC_ACCESS_ADDR, VAPIC_GPA);
> +
> +	GUEST_SYNC1(0);
> +	vmlaunch();
> +again:
> +	exit_reason =3D vmread(VM_EXIT_REASON);
> +	if (exit_reason =3D=3D EXIT_REASON_APIC_ACCESS) {
> +		uint64_t guest_rip =3D vmread(GUEST_RIP);
> +		uint64_t instr_len =3D vmread(VM_EXIT_INSTRUCTION_LEN);
> +
> +		vmwrite(GUEST_RIP, guest_rip + instr_len);
> +		vmresume();
> +		goto again;
> +	}
> +
> +	GUEST_SYNC1(exit_reason);
> +	GUEST_ASSERT(exit_reason =3D=3D EXIT_REASON_VMCALL);
> +	GUEST_DONE();
> +}
[ ... ]
> +static void *update_move_memslot(void *arg)
> +{
> +	struct update_control *ctrl =3D arg;
> +	uint64_t gpa =3D VAPIC_GPA;
> +
> +	wait_for_start_signal(ctrl);
> +
> +	/*
> +	 * Alternate the slot between VAPIC_GPA and an alternate address,
> +	 * so that the GPA under test is repeatedly unbacked (L2's APIC
> +	 * access bounces to userspace as MMIO) and re-backed (KVM must
> +	 * re-latch the page). Moving strictly away would change
> +	 * vCPU-visible state only once.
> +	 */
> +	while (is_running(ctrl)) {
> +		usleep(update_period_ms * 1000);
> +		gpa =3D (gpa =3D=3D VAPIC_GPA) ? VAPIC_GPA + 0x10000 : VAPIC_GPA;
> +		vm_mem_region_move(ctrl->vm, VAPIC_SLOT, gpa);
> +		ctrl->updates++;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void run(void * (*update)(void *), const char *name, bool mmio_ok)
> +{
[ ... ]
> +		case KVM_EXIT_MMIO:
> +			/*
> +			 * While the slot is moved away, the GPA under test
> +			 * is unbacked and the access legitimately bounces
> +			 * to userspace as MMIO (until the updater moves it
> +			 * back). madvise() never unbacks the GPA, so there
> +			 * an MMIO exit means KVM lost the mapping: fail.
> +			 */
> +			TEST_ASSERT(mmio_ok,
> +				    "%s: unexpected APIC MMIO access at 0x%llx",
> +				    progname, vcpu->run->mmio.phys_addr);
> +			printf
> +			    ("%s: APIC MMIO access at 0x%llx (memslot move effect)\n",
> +			     progname, vcpu->run->mmio.phys_addr);
> +			break;

[Severity: Medium]
Does checking for the absence of KVM_EXIT_MMIO in run() actually verify that
APIC-access virtualization stayed active across invalidations?

In l2_guest_code(), L2 performs 8 writes to VAPIC_GPA + 0x80 followed by
vmcall(), while l1_guest_code() handles EXIT_REASON_APIC_ACCESS by advancing
GUEST_RIP and executing vmresume() without counting how many
EXIT_REASON_APIC_ACCESS exits occurred.

In the madvise(MADV_DONTNEED) test, VAPIC_SLOT remains registered at
VAPIC_GPA. After madvise() zaps the userspace PTE and EPT02 SPTE, L2's next
write faults in a new anonymous host page in EPT02 rather than triggering
KVM_EXIT_MMIO. If KVM fails to refresh vmcs02.APIC_ACCESS_ADDR to the new
HPA (or fails to re-enable SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES after
update_move_memslot() moves VAPIC_SLOT back to VAPIC_GPA), the EPT02 HPA
will not match vmcs02.APIC_ACCESS_ADDR and L2's writes will silently commit
to normal memory without triggering either EXIT_REASON_APIC_ACCESS or
KVM_EXIT_MMIO.

Should l1_guest_code() and run() count the EXIT_REASON_APIC_ACCESS exits and
assert that all 8 L2 writes are intercepted as EXIT_REASON_APIC_ACCESS in
the madvise case (and as either EXIT_REASON_APIC_ACCESS or KVM_EXIT_MMIO in
the memslot-move case)?

> +		default:
> +			TEST_FAIL("%s: Unexpected exit reason: %d (flags 0x%x)",
> +				  progname,
> +				  vcpu->run->exit_reason, vcpu->run->flags);
> +		}
> +	}

[Severity: Medium]
As reported by Sashiko on v1 [1], can update_move_memslot() race with
vmlaunch() and vmresume() in l1_guest_code() and cause run() to fail with
KVM_EXIT_INTERNAL_ERROR?

In l1_guest_code(), GUEST_SYNC1(0) starts the updater thread before
vmlaunch(), and each EXIT_REASON_APIC_ACCESS exit into L1 advances GUEST_RIP
and executes vmresume(). Concurrently, update_move_memslot() toggles
VAPIC_SLOT between VAPIC_GPA and VAPIC_GPA + 0x10000.

In KVM's nested VM-entry path:

  nested_vmx_run()
    nested_vmx_enter_non_root_mode()
      nested_get_vmcs12_pages(vcpu, false)

nested_get_vmcs12_pages() is called with lazy =3D=3D false on both vmlaunch=
 and
vmresume. Unlike lazy revalidation while L2 is already in guest mode, if
VAPIC_GPA is unbacked when L1 executes vmlaunch() or vmresume(),
nested_get_vmcs12_pages() treats the missing gfn as an error and exits to
userspace with KVM_EXIT_INTERNAL_ERROR, hitting the default TEST_FAIL() case
in run().

[ ... ]
> +int main(int argc, char *argv[])
> +{
> +	int opt_madvise =3D 0;
> +	int opt_memslot_move =3D 0;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> +	TEST_REQUIRE(kvm_cpu_has_ept());

[Severity: Medium]
Should main() also check TEST_REQUIRE(kvm_cpu_has_vmx_virtualize_apic_acces=
ses())
here, similar to vmx_apic_access_test.c?

In l1_guest_code(), the test unconditionally sets
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES in SECONDARY_VM_EXEC_CONTROL before
calling vmlaunch(). On hosts or nested environments where virtualize APIC
accesses is unsupported or disabled (for example when flexpriority is
disabled), vmlaunch() will fail with a guest assertion failure instead of
skipping the test.

[1] https://lore.kernel.org/r/20260920211920.928306-13-dwmw2@infradead.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020104.2507=
083-1-dwmw2@infradead.org?part=3D14

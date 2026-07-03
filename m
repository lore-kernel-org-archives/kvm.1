Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C3272801
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099327; cv=none; b=sH0d6hmTROeGbIZYfVdVPWppwMAyf16WQq+ari2biC6UzGxTwu3Svs+DgxBX9ZjvAIWdr9wh1Ut6anH4HTvu5EchgcgBFqAx7JD0sfiRNZ6/UHXfcoUXHkd4sZoBTdj9LaAcFQRi/T1uIxs0HZlYXvQf8dz90MnaDEm+FnmQT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099327; c=relaxed/simple;
	bh=XZXZ0VjyIGUcYyjcNCa/ia/32bPkwNy9b+oXCkoRi6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYFyXEa0uvnKUC/Vu2r65rjRqYtbTmTUYpePZMW3ACeR9cCs5QXU63qcKa6Zsh1sGJC01h/L1fW27tU6p6OxQizDwX+U/d6Iq+s325v/s8ndkeAPk018D0MZgdUgFPfVckwyKjg21FfAPE/lj4YmMfCDzcxU4vfNktGtaoKcHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k5KlEpql; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k5KlEpql"
Received: from example.com (unknown [167.220.208.73])
	by linux.microsoft.com (Postfix) with ESMTPSA id C722C20B7168;
	Fri,  3 Jul 2026 10:22:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C722C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783099323;
	bh=5468h0Xyk6ddN2jsouLnEHhGWSRplnM5oFZ9ld71cOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5KlEpqlaNIJN1ta+sH7yK85jKJQOSZfT3xFtOyKtj6p2Lopqe55Fnw5SzIfXBEmI
	 9dLWIwLPm4/xc5GvMRw1b+JgV1pJbv/nuEYuwgywp5dB5+LY5llPYbp0RlCdDuhNz7
	 rOSuWkIOAT61MeoUFvjNAYdJf71K3OUxY8yoIl7M=
Date: Fri, 3 Jul 2026 19:21:59 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Message-ID: <akfvt0nTdVKZFOmJ@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>

On Thu, Jul 02, 2026 at 10:50:17AM +0200, Paolo Bonzini wrote:
> Sorry, I forgot to reply about this one.
> 
> It is not clear why you need to pause, since this is handled by common
> code. Are you not handling live migration yet? That should be handled at
> levels above QEMU, because users expect migration to be performed while the
> VM runs, and the SaveVMHandler should just fail migration of the VM is
> running.
> 
> Paolo
> 

Hey Paolo,

I spent some time looking at this. it's a bit twisted. The un/pause()
calls are unfortunately named, they are merely freezing the progress of
the reference timer, which for any real-world workload is in fact
pausing the guest b/c if the timer doesn't progress an os would mostly
stall, waiting for ticks.

We want to freeze the timer though during the last phase of the
migration on the source and on the destination (can't set the reference
time if the vcpu time is not frozen). But currently it's the wrong
place. I'll find some more fitting place to perform this ceremony.

Curiously the time-frozen source was obscuring another potentially more
serious bug. The mshv vcpu dispatch loop currently does not honor a
cpu->exit_request, like it is currently set after precopy:

migration_completion_precopy()
  migration_stop_vm()
    vm_stop_force_state()
      vm_stop()
        do_vm_stop()
          pause_all_vcpus()
            cpu_pause()
              cpu_exit()
                qatomic_store_release(&cpu->exit_request, true)

The two bugs were sort of cancelling each other out. Since the source
guest was not busy, migrations were still succeeding, even though the
the vcpus were not actually "stopped" on the vcpu.

I'll rework this a bit, and submit a revised version.

best,

magnus

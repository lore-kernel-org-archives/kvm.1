Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E64071DA
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811695; cv=pass; b=c4S3y5y1w30KwyMDTOQ3Yu9CN6bAbv2ktGUD2b+Go/EESyU3u9e4yk06n9LixMPdJmEeVSn3JR3d9DFEpxvUhyAGa90jjO4qSaUlq0ifxbz2ToDHmX6TTQ4CelYC7+yXEP7NLZSUJgaNgaO1lBayTRONy9QizQxmCm3Ex2t8sXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811695; c=relaxed/simple;
	bh=uz9uUhexCYmhkBMUW9kqKaAHnjzrD9tTHxL8eI5e5U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkTi0E451fT/BZxAuoIYbEa38Ox7IPOv+FujsVIbjZGxm9Lo2lFUPZZFT3c+wfUZiryM6zG6jOFqq9JyMPYXi+Zlh4jzOIC/cMMKH9HJPshHeZ+7iyMz2/gGBIMXoki5iIiKP7d3g5PoruaffgB8C5T2OWWaczA1x+D+Tqo3q9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=icxzSTcX; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="icxzSTcX"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-396770cdcfdso34328421fa.0
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 22:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780811692; cv=none;
        d=google.com; s=arc-20240605;
        b=fSELXxzwkYqneqPRhpml8o2pBlkxCUp7QotPs0GVQnfK+CKrfDtouzQNuL4S2as8Hb
         fXz6MJWW3EfL0CvuUgnWjR9eMLs+qnqtAt2x2xp/bqi4kojD9wfGTYtPKRokdXLIAF4m
         92uIk7c2NTK6ujRrPN5LjJERFUOiqKOLOVWtrVzwpYRLuTKK9LsiQXQBBF3tjYMkMaZP
         VZXFDBQjoMxGnJ+RLJAj2jKy+l3K9Z2sk5KIdinNsToY8Q7yN38CuQ4DQzdbRQ/ynug2
         cIBj4myILvF/LGKB+aQ0xHcQGYAaV4qGOGLmrJcDApK51lqgw/M82bwnaYcPo/WY/zTf
         SuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GI/CELcqqMge0dwSQkZwLgMfV8nY/qrqwPle2IRk0dw=;
        fh=9jr53OgSFZlPja8qkALS7ZJEQ8UmUCEEYVni78ma6oU=;
        b=BIUaYkbY3f9WTrz6xO/PqJ9oN/l8nkQ7EVM0sMkMgOs5+zJAuWqI1dJQFf8s4hcDTQ
         0Tu5KT4ZcHl1/kkYe4qjDKM4EVUPRJhOxdHgFdUeHVyvvdW2WBX26WHrWyX/jXwVkX5Q
         7BQ6YaB2mCuHJuvn8X1V2qNJ6WTkDiFOfIidVoiD0GhZF8igafSPTEDrxIUo3yaWGqrN
         ZzKFFVGJ9PvYpkomSsG+q1gsoAxm10QCv0t98MnQUGj9HmJPZqY0G/B6WPO41TrNO4UE
         OGvnrIHgnUf3HgvlgwBjqckY3NdoLA+NP58JRwh8Zm5L+ArnhuNGm04HkCEuns1MN9FX
         quDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1780811692; x=1781416492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI/CELcqqMge0dwSQkZwLgMfV8nY/qrqwPle2IRk0dw=;
        b=icxzSTcXFt6QQsj8oHR9dUC2rAiDfelqOk6J1L2CmXIZRt920fNYIW7wn+Lca477z7
         o/hxe7vRANmVCJIkQYkRAp+Q6iUoz45VU1AsHpJJR8Vq2jNvK+hG3DOEqp3tc5WLzi94
         x1Q/6wmSQnTt0+Jojyyfkwf6KdH4hLGmVfBfpcZKdLoNDk90bgak6Uym7Dxs5YBkpCTT
         h0fGTjRMaRjZF6CgyI13UL+gr4fJkbBdmcT/Ch+GmugS+LIIzy7BSogGpf1qTidgzar9
         JuKA3TLU7WDhDh8ZgiQ/S8DRrSlCcPq1E0zqdUnck0zEf4/5GoZxUZ0in3Eu6oEy8Sfn
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780811692; x=1781416492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI/CELcqqMge0dwSQkZwLgMfV8nY/qrqwPle2IRk0dw=;
        b=LPUF2CxjPUDzRnoroflURsgSY+/4bR0/9R7jhjy57ndqvKaHhF5Mnqmbo/CwiLldbo
         n9Nvxv3upxlLzNEQqjzWcO2AV8vAzN4a00dSVUCP5nGIZhLUoe718tPZk/RbnWRrgpiI
         LAih9MuDNWBQU0Jso74sgX8sUrGjatI7ojkzXYfMuhhHqtc3W3VCW4egzRDvyccCsvYb
         LncKeaNqygdGOug5er4E+EjY/r9SSHiCC4t4mGpmUCI4bHxk09qJ3F76CgasSvThTKN2
         WmQbAO+pegKCBOpo2ezzlC2VdSKQ7R9yIfKUPwnO6ObhEwFrKz5tWfxjAuquFeikcOmW
         aF7A==
X-Forwarded-Encrypted: i=1; AFNElJ8lJuelVhhLOeLxCoxJigunp+NPkx2ku+d8pr83EAojZ3jRnaJpuqumJL9pwBHSDxscwGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNaSamTVadGdrY9ibVT/+MyjKF/c6gFafKwGKgQ9fh8gNjmF3
	JRypJLfK3pqK+UDfggv0RavaTnkXyv7AU0FgPSAAW5uUnJ4ElvKcwqKWpzLGd1LmkOhfoSpBAyh
	zob7sVtF1nvDA+w5GpUETc8hSCeMlKAv63i26YsrU8Q==
X-Gm-Gg: Acq92OGAaaW0/OLDywWPD8F0Nsrudakymc4KIlwjR3dHXRNMC3sNOzsOgWTSHvb7qL7
	xWiktKx8nf+YZ9ANiifoOHXEnYWA7s8kQ8mKW2iYUxlwrZFO0Pp2Hm1Yv/lpaEqCIYQVvxQeY0q
	aP7krlbJu2Jbz1xo/mT1qai8vYO44VZnFdvB0e/BKh3quw2Ya6p4XgENJNnCnokBlZ3beddtR51
	OmZcRe6Spe6+I97ZSvGQWnZO+09V0rb6FwJTQkpGF+8eD9Cywolq1o72Ohf/NbMh2BcjCVVKmxd
	tHLdW+234hpHNa77GkjjxXPprAqMhI6NocgUBFrA0xV+F+EfItX8
X-Received: by 2002:a05:651c:1423:b0:38a:8602:71aa with SMTP id
 38308e7fff4ca-396d0895469mr18718371fa.16.1780811692124; Sat, 06 Jun 2026
 22:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604142602.3582602-1-tjytimi@163.com> <20260604142602.3582602-3-tjytimi@163.com>
In-Reply-To: <20260604142602.3582602-3-tjytimi@163.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 7 Jun 2026 11:24:40 +0530
X-Gm-Features: AVVi8CenzaChEvM0QLFFb2Zk6nh65TW0r-wtF9-zKuIk2urNBL-QPcDlyquxHck
Message-ID: <CAK9=C2Xx+wWL=htOvqmPfF4=f68CNF0r3W9nfTNSMjfSyws-tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Add a hugetlb memslot alignment
 test mode
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 7:58=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> kvm_page_table_test can already exercise hugetlb-backed guest memory,
> but it always creates the test memslot with GPA alignment matching the
> hugetlb backing size. That misses the case where a valid hugetlb
> memslot is later moved so that the memslot GPA and HVA no longer have
> the same offset within the backing huge page.
>
> Add a -u option that moves the test memslot GPA by one guest page after
> creating the hugetlb memslot. The memslot is created through the normal
> helper first, so the backing allocation remains valid and hugetlb aligned=
.
> Moving the memslot then creates a deliberate HVA/GPA offset mismatch
> before the guest mapping is installed.
>
> This mode is useful for checking that architecture MMUs do not install
> a block mapping when the block would map the wrong host pages or cover
> memory outside the memslot. The option is restricted to hugetlb-backed
> test memory because it's specifically about hugetlb block mapping
> eligibility.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

I did not observe any impact on the default usage without "-u"
option hence queueing it for Linux-7.2

Thanks
Anup

> ---
> v1 -> v2:
>   - Keep the selftest change unchanged from v1
>
>  .../selftests/kvm/kvm_page_table_test.c       | 28 +++++++++++++++----
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/te=
sting/selftests/kvm/kvm_page_table_test.c
> index fc5242fb9..a910e3abb 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -230,6 +230,7 @@ struct test_params {
>         u64 phys_offset;
>         u64 test_mem_size;
>         enum vm_mem_backing_src_type src_type;
> +       bool misalign_slot_gpa;
>  };
>
>  static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void=
 *arg)
> @@ -244,6 +245,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_gu=
est_mode mode, void *arg)
>         u64 guest_num_pages;
>         u64 alignment;
>         void *host_test_mem;
> +       struct userspace_mem_region *region;
>         struct kvm_vm *vm;
>
>         /* Align up the test memory size */
> @@ -276,13 +278,22 @@ static struct kvm_vm *pre_init_before_test(enum vm_=
guest_mode mode, void *arg)
>         /* Add an extra memory slot with specified backing src type */
>         vm_userspace_mem_region_add(vm, src_type, guest_test_phys_mem,
>                                     TEST_MEM_SLOT_INDEX, guest_num_pages,=
 0);
> +       region =3D memslot2region(vm, TEST_MEM_SLOT_INDEX);
> +       host_test_mem =3D region->host_mem;
> +
> +       if (p->misalign_slot_gpa) {
> +               TEST_ASSERT(is_backing_src_hugetlb(src_type),
> +                           "Memslot GPA misalignment requires hugetlb ba=
cking");
> +               TEST_ASSERT(guest_num_pages > 1,
> +                           "Need at least two guest pages to misalign me=
mslot GPA");
> +
> +               guest_test_phys_mem +=3D guest_page_size;
> +               vm_mem_region_move(vm, TEST_MEM_SLOT_INDEX, guest_test_ph=
ys_mem);
> +       }
>
>         /* Do mapping(GVA->GPA) for the testing memory slot */
>         virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_=
pages);
>
> -       /* Cache the HVA pointer of the region */
> -       host_test_mem =3D addr_gpa2hva(vm, (gpa_t)guest_test_phys_mem);
> -
>         /* Export shared structure test_args to guest */
>         sync_global_to_guest(vm, test_args);
>
> @@ -417,8 +428,8 @@ static void run_test(enum vm_guest_mode mode, void *a=
rg)
>  static void help(char *name)
>  {
>         puts("");
> -       printf("usage: %s [-h] [-p offset] [-m mode] "
> -              "[-b mem-size] [-v vcpus] [-s mem-type]\n", name);
> +       printf("usage: %s [-h] [-p offset] [-m mode] [-b mem-size]\n", na=
me);
> +       printf("          [-v vcpus] [-s mem-type] [-u]\n");
>         puts("");
>         printf(" -p: specify guest physical test memory offset\n"
>                "     Warning: a low offset can conflict with the loaded t=
est code.\n");
> @@ -428,6 +439,8 @@ static void help(char *name)
>         printf(" -v: specify the number of vCPUs to run\n"
>                "     (default: 1)\n");
>         backing_src_help("-s");
> +       printf(" -u: move the test memslot GPA by one guest page after cr=
eating\n"
> +              "     the memslot, forcing a hugetlb HVA/GPA offset mismat=
ch\n");
>         puts("");
>  }
>
> @@ -442,7 +455,7 @@ int main(int argc, char *argv[])
>
>         guest_modes_append_default();
>
> -       while ((opt =3D getopt(argc, argv, "hp:m:b:v:s:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "hp:m:b:v:s:u")) !=3D -1) {
>                 switch (opt) {
>                 case 'p':
>                         p.phys_offset =3D strtoull(optarg, NULL, 0);
> @@ -461,6 +474,9 @@ int main(int argc, char *argv[])
>                 case 's':
>                         p.src_type =3D parse_backing_src_type(optarg);
>                         break;
> +               case 'u':
> +                       p.misalign_slot_gpa =3D true;
> +                       break;
>                 case 'h':
>                 default:
>                         help(argv[0]);
> --
> 2.43.0
>
